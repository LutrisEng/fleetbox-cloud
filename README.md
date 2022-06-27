# Fleetbox Cloud

## Dependencies

### Ruby version

Use the Ruby version specified in `.ruby-version` - `rbenv` should do this
by default.

### System dependencies

Fleetbox Cloud is only compatible with UNIX-like operating systems, and
requires Imagemagick to be installed.

## Development environment

### Database

For development, install a local Postgres instance. Set up the database with
the following commands:

```shell
bin/rails db:create
bin/rails db:schema:load
```

### Running tests

For unit and integration tests, simply run the following:

```shell
bin/rails test
```

For system tests, install Google Chrome and run the following:

```shell
bin/rails test:system
```

To run all tests (unit, integration, and system), run the following:

```shell
bin/rails test:all
```

### ActiveJob backend

Fleetbox Cloud uses GoodJob as its ActiveJob backend in production. In
development and test environments, jobs are run in the server process.

## Deployment

All commits to the main branch are deployed to the staging environment
(<https://staging.fleetbox.io>). To release to production, create a GitHub
release. The version number will be
`<year in 20XX format>.<month in XX format, 01-12>.<release number in month, 1-XYZ>`,
the tag name will be `v<version number>`, and the release name will be
`Fleetbox <version number>`.

## License

> Fleetbox Cloud  
> Copyright &copy; 2022 Lutris Inc
> 
> This program is free software: you can redistribute it and/or modify
> it under the terms of the GNU Affero General Public License as published by
> the Free Software Foundation, either version 3 of the License, or
> (at your option) any later version.
> 
> This program is distributed in the hope that it will be useful,
> but WITHOUT ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> GNU Affero General Public License for more details.
> 
> You should have received a copy of the GNU Affero General Public License
> along with this program.  If not, see <http://www.gnu.org/licenses/>.