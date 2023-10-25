# frozen_string_literal: true

require 'faraday'

require 'line_notify_client/error'
require 'line_notify_client/http_client'
require 'line_notify_client/response'
require 'line_notify_client/version'

module LineNotifyClient
  def self.new(access_token)
    LineNotifyClient::HttpClient.new(access_token)
  end
end
