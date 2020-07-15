SSL Checker
==============

Domain SSL certificate check app with Grape API mounted on Rails.

* [domain](app/api/checker/domain.rb): insert domain data into DB

```

curl -X POST -H "Content-Type: application/json" localhost:3000/api/domain -d '{"name": "google.com"}'

{"id":7,"name":"google.com","status":true,"created_at":"2020-07-15T03:55:58.262Z","updated_at":"2020-07-15T03:55:58.677Z"}

```

* [status](app/api/checker/status.rb): show all domains with statuses

```

http://localhost:3000/api/status

[{"id":6,"name":"nokogiri.org","status":true,"created_at":"2020-07-14T12:47:03.714Z","updated_at":"2020-07-14T20:33:01.883Z"},
{"id":7,"name":"google.com","status":true,"created_at":"2020-07-15T03:55:58.262Z","updated_at":"2020-07-15T03:55:58.677Z"}]

```

* [journal](app/api/checker/journal.rb): show all journal events

```

http://localhost:3000/api/journal

[{"id":185,"message":"All right","domain_id":7,"created_at":"2020-07-15T03:55:58.664Z","updated_at":"2020-07-15T03:55:58.664Z"}]

```


Ruby
---
* Ruby 2.7.1, Rails 6.0.3.2

Run
---

```
bundle install
rails s
sidekiq

```