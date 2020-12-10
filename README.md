## A sample coding task from Le Wagon

### Task description
Build an API endpoint that will receive a CSV file with the list of events (smart locks going online/offline) and save it in the database.
The API must have token-based authentication.

Example of the CSV file:
```
timestamp,lock_id,kind,status_change
2017-05-01T00:32:50Z,9db3b7eb,sensor,online
2017-05-01T00:40:20Z,6e711d12,gateway,online
2017-05-01T00:43:50Z,3831469f,sensor,offline
2017-05-01T00:50:10Z,3831469f,sensor,online
2017-05-01T00:50:30Z,89987171,gateway,online
```

### How to install and run
- clone the repo
- run bundle install
- run rails db:migrate db:seed
- note the user email and access token, they are printed during the seed
- run rails s
- send the POST request to /api/v1/events/ with the content-type multipart/form-data, CSV content as a part with the key 'report'
- use these headers for authentication: X-User-Email, X-User-Token
