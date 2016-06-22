# Todos

A not-so-basic todos app

**Todos** aims to be a free and open-source todos app supporting ideas from
*Getting Things Done* and other productivity methodologies.

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

(TODO: Describe basic usage)

## Contributing

Please ensure you write specs for your code, and ensure everything passes both
rspec and rubocop before submitting a pull request

(TODO: Go into more detail)
