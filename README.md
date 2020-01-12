# line_notify_client

LINE Notify API client library, written in Ruby https://notify-bot.line.me/doc/en/

## Install

```bash
gem install line_notify_client
```

or

```
# Gemfile
gem 'line_notify_client'
```

## Library

```ruby
require 'line_notify_client'

# OAuth2 Auhentication Documentation: https://notify-bot.line.me/doc/en/
access_token = 'access token from LINE Notify oauth2 authentication'

# new client
client = LineNotifyClient.new(access_token)

# Sends notifications to users or groups are related to an access token.
client.notify('message')

# Check the validity of an access token.
client.status

# Disable an access token
client.revoke
```

## Development

* Run rspec

```ruby
bundle exec rake
```
