# StackOverFlow APIs
## Description
A simple server that allow adding, editing, deleting and searching for questions   using different APIs allowed.

## Usage
- Ruby 3.0.2
- Rails 6.1.4.1
- whenever (scheduling cron jobs for updating trending questions cache)
- ElasticSearch (for searching questions efficiently)
- PostgreSQL
- Redis (for caching trending questions)
- Docker
- Docker Compose

## How to run
- Make sure to install Docker and Docker compose.
- Run the following commands
```
cd server
docker-compose build
docker-compose run --rm web rails db:create db:migrate db:seed
docker-compose up
```

## API testing
- To test every thing is working fine, We can use newman to run postman tests. (Make sure to install newman).
- Run this commands 
```
cd postman
newman run StackOverFlow.postman_collection.json -e local.postman_environment.json
```
