[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=webhook_sms_request&metric=alert_status)](https://sonarcloud.io/dashboard?id=webhook_sms_request)

# README

## SMS Twillio Service Usage
```ruby
  # para correr en webhook
  # 1- Instalar las gemas: `bundle install`
  # 2- Correr `rackup`
  rackup

  # para correr sidekiq
  bundle exec sidekiq -r ./workers/sms_request_worker.rb -C ./config/sidekiq.yml

```
---
