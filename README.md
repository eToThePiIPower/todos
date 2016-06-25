# Todos

[![Build Status][travis-badge]][travis-status]

A not-so-basic todos app

**Todos** aims to be a free and open-source todos app supporting ideas from
_Getting Things Done_ and other productivity methodologies.

## Installation

Clone the repository:

```ruby
git clone https://github.com/eToThePiIPower/todos
```

Create the Postgres user and databases

```ruby
createuser todos -s
rake db:create
rake db:migrate
```

Start the server locally:

```ruby
rails server
```

Or deploy to Heroku or your Rails host of choice

## Usage

Push to Heroku or your host of choice

TODO: More deatil

## Contributing

Included in the bundle are several linters, but we also need
ESLint for dev which gets installed via npm.

```sh
npm install
```

In order to ensure a clean, standardized coding style, linters are provided
in the development environment and enforced in Travis CI.

You can run the linters individually or in bulk via rake, which
has the added benefit of providing consistent success/failure
messages with color coding :D

```sh
rake lint:rubocop
rake lint:slim
rake lint:eslint
rake lint:all
rake lint
```

Specs can be run the standard way

```sh
rake spec
```

## Authors

*   Charles Beynon &lt;@[eToThePiIPower][cb]>

## License

[MIT][license]

<!-- Definitions -->

[cb]: https://github.com/eToThePiIPower "Charles Beynon"

[license]: LICENSE.txt

[travis-badge]: https://travis-ci.org/eToThePiIPower/todos.svg?branch=master

[travis-status]: https://travis-ci.org/eToThePiIPower/todos "Todos on Travis CI"
