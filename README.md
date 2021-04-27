# Sweater Weather

This is the backend engine fueling an application to plan road trips. This app will allow users to see the curren weather as well as the forecasted weather at the destination. 

## Summary

  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installing](#installing)
  - [Endpoints](#endpoints)  
  - [Runing the tests](#running-the-tests)
  - [Authors](#authors)

## Getting Started

These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on how to deploy the project on a live system.

### Prerequisites

* __Ruby__

  - The project is built with rubyonrails using __ruby version 2.5.3p105__, you must install ruby on your local machine first. Please visit the [ruby](https://www.ruby-lang.org/en/documentation/installation/) home page to get set up. _Please ensure you install the version of ruby noted above._

* __Rails__
  ```sh
  gem install rails --version 5.2.5
  ```

* __Postgres database__
  - Visit the [postgresapp](https://postgresapp.com/downloads.html) homepage and follow their instructions to download the latest version of Postgres app.

### Installing

1. Clone the repo
  ```
  $ git clone git@github.com:abreaux26/sweater-weather.git
  ```

2. Bundle Install
  ```
  $ bundle install
  ```

3. Create, migrate and seed rails database
  ```
  $ rails db:{create,migrate}
  ```

4. Set up Environment Variables:
  - run `bundle exec figaro install`
  - add the below variable to the `config/application.yml` if you wish to use the existing email microservice. Otherwise you replace it the value with service if desired.
  ```
    mapquest_key: <your mapquest api>
    open_weather_map_key: <your open weather api>
    pexels_key: <your pexels api>
  ```
## Endpoints
| HTTP verbs | Paths  | Used for |
| ---------- | ------ | --------:|
| GET | /api/v1/forecast?location=denver,co | Retrieve weather for a city |
| GET | /api/v1/backgrounds?location=denver,co | Background Image for the City |
| POST | /api/v1/users | Creates a new user |
| POST | /api/v1/sessions | Creates a new session after logging in |
| POST | /api/v1/road_trip | Creates a new road trip |

## Running the tests
- To run the full test suite run the below in your terminal:
```
$ bundle exec rspec
```
- To run an individual test file run the below in tour terminal:
```
$ bundle exec rspec <file path>
```
for example: `bundle exec rspec spec/requests/api/v1/forecast/index_spec.rb`

## Authors
  - **Angel Breaux**
