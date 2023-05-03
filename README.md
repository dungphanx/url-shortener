# README

## Ruby version
  3.2.2

## Setup Project

```command
  $ cp .env_example .env
```
- Update your own values

```command
  $ bundle install
```

```command
  $ rails db:create
  $ rails db:migrate
```

### Create user & get your own token by rake, or you can create manual in rails console.

```command
  $ bundle exec rake one_time:create_user
```

## Using
You can use Postman app to request API or curl commands. \
For Heroku testing. Use this token `-XzFmMW7PLMu5ezgf7pZRZhqb11rtZ-TJDIXzxrF6uA`
### API to encode original url
`POST /api/v1/encode`
```command
  $ curl --location --request POST 'https://dungph-url-shortener.herokuapp.com/api/v1/encode' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer -XzFmMW7PLMu5ezgf7pZRZhqb11rtZ-TJDIXzxrF6uA' \
  --data-raw '{"original_url": "https://google.com"}'
```

### API to decode short url
`POST /api/v1/decode`
```command
  $ curl --location --request POST 'https://dungph-url-shortener.herokuapp.com/api/v1/decode' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer -XzFmMW7PLMu5ezgf7pZRZhqb11rtZ-TJDIXzxrF6uA' \
  --data-raw '{"short_url": "https://dungph-url-shortener.herokuapp.com/FZal6"}'
```

## Testing

```command
$ bundle exec rspec
```

## Real life problem
In my point of view, to adapt all real life situations, we can
-  Add authentication and authorization: Add user authentication and authorization to ensure that only authorized users can access the shortener service. This can be done using popular authentication and authorization libraries like Devise and CanCanCan.
- Add user dashboard: Provide a user dashboard where users can view their short links, track clicks, and manage their short links. This can be done using a simple dashboard built using Bootstrap or a more advanced dashboard using a third-party library like ActiveAdmin.
- Add analytics: Add analytics to track clicks, locations, and devices used to access the short links. This can be done using a third-party analytics service like Google Analytics or a self-hosted analytics tool like Matomo.
- Improve performance: Improve the performance of the app by optimizing the database queries, using a caching layer, and minimizing the use of external resources.