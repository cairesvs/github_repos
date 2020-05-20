# github repos

Simple github repositories actions.

## Setup

You need to have 'ruby' `v2.6.4`.

To install dependencies from `Gemfile`:
```
bundle install
```

## Running application and test

#### Through Rake

The project have rake task to run the server `rake run` and `rake spec` to run the specs.

#### Manual

Alternately you can run manually, you just need to execute the `config.ru` using the `rackup` file, the server will run on `localhost:9292`.

```
rackup config.ru
```

And in order to run all tests inside `spec/` folder, you need to run:
```
bundle exec rspec
```

## Packaging and deploy

For packaging we use Docker and enable few possibilities of deployment like AWS elastic beanstalk, AWS ECS and Kubernetes.

The Rakefile have few utility task to generate and run the project:

### Build Image
`rake docker:build`

### Run Image
`rake docker:run`

You can override puma threads and workers by setting this variables on `docker run`, useful for production:

- PUMA_THREADS
- WORKERS


## App structure

```
├── Dockerfile
├── Gemfile
├── Gemfile.lock
├── README.md
├── config // All the application configuration
│   └── application.rb
├── config.ru
├── controllers // Controller logic, glue between the entry point and external data, like http request, database, etc
│   └── github.rb
├── puma.rb
├── requests // HTTP Client and requests
│   └── github_client.rb
├── server.rb
├── spec
│   ├── github_empty_response.json
│   ├── github_response.json
│   ├── github_spec.rb
│   └── spec_helper.rb
└── views
    └── index.erb
```
