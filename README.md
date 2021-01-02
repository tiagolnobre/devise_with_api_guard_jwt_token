# devise_with_api_guard_jwt_token

Setup of devise with jwt and refresh token using api_guard
  - devise registerable, confirmable
  - async email send using sidekiq
  - ...

Endpoints:

#### User registration:
```
POST "api/v1/users/sign_up"

# body
{
    "email": "john@smithee.com",
    "password": "my_password"
}

# response body
{
    "result": {
        "id": "2e1e4b1d-ef25-4723-858d-86ecdc658a28",
        "email": "john@smithee.com",
        "created_at": "2020-12-22T23:36:16.176Z",
        "confirmation_sent_at": "2020-12-22T23:36:16.176Z",
        "confirmed_at": null
    }
}
```

#### User sign in:
```
POST "api/v1/users/sign_in"

# body
{
    "email": "john@smithee.com",
    "password": "my_password"
}

# response headers
{
    "Access-Token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiM2Y1NDk3Y2YtOGFjZC00ZTYzLWEzNTEtZjZkYmRlYTA2MjNlIiwiZXhwIjoxNjA4NzY2NzE0LCJpYXQiOjE2MDg2ODAzMTR9.FxtjRUqQ9kTIclO8O2X401gzv_RROLQs_dH79bTyW5c",
    "Refresh-Token": "8AZhs-YlnsFZnNHHthuaKA",
    "Expire-At": "1608766714"
}

# response body
{
    "status": "success",
    "message": "Signed in successfully"
}
```

#### User sign out:
```
DELETE "api/v1/users/sign_out"

# headers
{
 Authorization: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiM2Y1NDk3Y2YtOGFjZC00ZTYzLWEzNTEtZjZkYmRlYTA2MjNlIiwiZXhwIjoxNjA4NzY2NzE0LCJpYXQiOjE2MDg2ODAzMTR9.FxtjRUqQ9kTIclO8O2X401gzv_RROLQs_dH79bTyW5c"
}

# response body
{
    "status": "success",
    "message": "Signed out successfully"
}
```

#### User details
```
GET "api/v1/user"

# headers
{
 Authorization: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiM2Y1NDk3Y2YtOGFjZC00ZTYzLWEzNTEtZjZkYmRlYTA2MjNlIiwiZXhwIjoxNjA4NzY2NzE0LCJpYXQiOjE2MDg2ODAzMTR9.FxtjRUqQ9kTIclO8O2X401gzv_RROLQs_dH79bTyW5c"
}

# response body
{
    "result": {
        "id": "2e1e4b1d-ef25-4723-858d-86ecdc658a28",
        "email": "john@smithee.com",
        "created_at": "2020-12-22T23:36:16.176Z",
        "confirmation_sent_at": "2020-12-22T23:36:16.176Z",
        "confirmed_at": null
    }
}
```

* Database setup
`bundle exec rails db:setup`

* How to run the test suite
`bundle exec rspec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
...

* Starting the application

- `foreman start` for api, jobs (sidekiq)
- `docker-compose up` for database, redis

