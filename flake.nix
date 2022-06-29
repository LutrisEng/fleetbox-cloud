{
  inputs.nixpkgs.url = github:nixos/nixpkgs;
  inputs.flake-utils.url = github:numtide/flake-utils;
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgsToRuby = (pkgs: pkgs.ruby_3_1);
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            # Latest V8 fails to compile on Darwin
            v8 = final.v8_8_x;
          })
        ];
      };
      ruby = pkgsToRuby pkgs;
      gems = pkgs.bundlerEnv {
        name = "fleetbox-cloud-gems";
        inherit ruby;
        gemdir = ./.;
      };
    in
    rec {
      packages.fleetbox-cloud = pkgs.stdenv.mkDerivation {
        name = "fleetbox-cloud";
        src = ./.;
        buildInputs = [
          gems
          ruby
          pkgs.postgresql
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
            rails test
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
      devShells.fleetbox-cloud = packages.fleetbox-cloud;
      packages.default = packages.fleetbox-cloud;
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



