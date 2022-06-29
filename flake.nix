{
  inputs.nixpkgs.url = github:nixos/nixpkgs;
  inputs.flake-utils.url = github:numtide/flake-utils;
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgsToRuby = pkgs: pkgs.ruby_3_1;
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            # Latest V8 fails to compile on Darwin
            v8 = if prev.stdenv.isDarwin then final.v8_8_x else prev.v8;
          })
        ];
      };
      ruby = pkgsToRuby pkgs;
      gems = pkgs.bundlerEnv {
        name = "fleetbox-cloud-gems";
        inherit ruby;
        gemdir = ./.;
      };
      mkFleetboxCloud = systemTests: pkgs.stdenv.mkDerivation {
        name = "fleetbox-cloud";
        src = ./.;
        buildInputs = [
          gems
          ruby
          pkgs.postgresql
        ] ++ pkgs.lib.optionals systemTests [
          pkgs.google-chrome
          pkgs.chromedriver
        ];
        propagatedBuildInputs = [
          pkgs.nodejs
        ];
        unpackPhase = ''
          cp -R $src/* .
          chmod -R +w .
        '';
        buildPhase = ''
          rails assets:precompile
        '';
        doCheck = true;
        checkPhase = ''
          (
            set -euxo pipefail
            initdb -D tmp/testdb --auth=trust --username=rails --encoding=UTF8
            postgres -D tmp/testdb --unix_socket_directories="$PWD/tmp/testdb" -h "" &
            postgres_pid=$!
            trap "kill $postgres_pid" ERR
            export DATABASE_URL="postgres://rails:password@localhost/rails?host=$PWD/tmp/testdb"
            rails db:create
            rails db:schema:load
            rails ${if systemTests then "'test:system:with[headless_chrome]'" else "test"} TESTOPTS=--junit
            kill $postgres_pid
            wait $postgres_pid
          )
        '';
        installPhase = ''
          rm -rf log tmp
          cp -R $src/{log,tmp} .
          mkdir -p $out/share/fleetbox-cloud
          cp -R . $out/share/fleetbox-cloud
        '';
      };
    in
    rec {
      packages.fleetbox-cloud = mkFleetboxCloud false;
      packages.fleetbox-cloud-system-tests = mkFleetboxCloud true;
      devShells.fleetbox-cloud = packages.fleetbox-cloud;
      packages.default = if pkgs.stdenv.isLinux && pkgs.stdenv.isx86_64 then packages.fleetbox-cloud-system-tests else packages.fleetbox-cloud;
      devShells.default = devShells.fleetbox-cloud;
      hydraJobs = {
        inherit packages;
      };
      apps.bundle = {
        type = "
          app ";
        program = "${pkgs.bundler}/bin/bundle";
      };
      apps.bundix = {
        type = "app";
        program = "${pkgs.bundix}/bin/bundix";
      };
    }
  );
}



