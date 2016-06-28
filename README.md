# Todos

[![Build Status][travis-badge]][travis-status]
[![Code Coverage][codecov-badge]][codecov-status]

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

### Setting up Environment variables

Setup a `.env` file if you want to be able to send mails in Devise on your
development system. The `dotenv-rails` gem will automatically load these
environment variables when you start your server.

```sh
# /.env
RAILS_MAILER_HOST = 'yourapp.herokuapp.com'
RAILS_SMTP_ADDRESS = 'smtp.gmail.com'
RAILS_SMTP_PORT = 587
RAILS SMTP_DOMAIN = 'gmail.com'
RAILS_SMTP_USERNAME = 'user@gmail.com'
RAILS_SMTP_PASSWORD = 'password1234'
DEVISE_MAILER_SENDER = 'user@gmail.com'
```

For some services (such as Postmark), the `USERNAME` and `SIGNATURE` will be
different---eg the former will be an API token while the latter will be a
verified email that appears as the sender to recipients. Resonable defaults are
provided in the dev environment, but at the very least `USERNAME` and `PASSWORD`
need to be changed if you are using GMail as an SMTP sender.

### Starting the server

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

[codecov-badge]: https://img.shields.io/codecov/c/github/eToThePiIPower/todos.svg

[codecov-status]: https://codecov.io/gh/eToThePiIPower/todos

[license]: LICENSE.txt

[travis-badge]: https://img.shields.io/travis/eToThePiIPower/todos.svg

[travis-status]: https://travis-ci.org/eToThePiIPower/todos "Todos on Travis CI"
