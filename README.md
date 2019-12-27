# LINE Notify

LINE Notify API client library, written in Ruby https://notify-bot.line.me/doc/en/

## Install

```bash
gem install line-notify-rb
```

## Library

```ruby
require 'line-notify-rb'

access_token = 'access token from LINE Notify oauth2 authentication'

# new client
client = LineNotify::Client.new(access_token)

# Sends notifications to users or groups are related to an access token.
client.notify('message')

# Check the validity of an access token.
client.status

# Disable an access token
client.revoke
```
