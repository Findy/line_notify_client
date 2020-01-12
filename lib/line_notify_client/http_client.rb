# frozen_string_literal: true

module LineNotifyClient
  # ## LineNotify::Client
  # A class for LINE Notify API client.
  #
  class HttpClient
    HOST = 'notify-api.line.me'
    ACCEPT = 'application/json'
    USER_AGENT = 'LineNotify Ruby'
    HEADERS = { 'Accept' => ACCEPT, 'User-Agent' => USER_AGENT }.freeze

    def initialize(access_token)
      @access_token = access_token
    end

    # ### LineNotify::Client#notify
    # Sends notifications to users or groups that are related to an access token.
    #
    # POST https://notify-api.line.me/api/notify
    def notify(message, options = {})
      params = { message: message }.merge(options)
      post('/api/notify', params, options)
    end

    # ### LineNotify::Client#status
    # Check the validity of an access token.
    #
    # GET https://notify-api.line.me/api/status
    def status
      get('/api/status')
    end

    # ### LineNotify::Client#revoke
    # Disable an access token.
    #
    # POST https://notify-api.line.me/api/revoke
    def revoke
      post('/api/revoke')
    end

    private

    def get(path, params = nil, headers = nil)
      request(:get, path, params, headers)
    end

    def post(path, params = nil, headers = nil)
      request(:post, path, params, headers)
    end

    def request(http_method, path, params, headers)
      faraday_response = connection.send(http_method, path, params, headers)
      LineNotify::Response.new(faraday_response)
    rescue Faraday::Error::TimeoutError => e
      raise LineNotify::TimeoutError, e.message
    rescue Faraday::Error => e
      raise LineNotify::Error, e.message
    end

    def connection
      @connection ||= Faraday.new(faraday_client_options) do |builder|
        builder.options.timeout = 5 # 5 seconds
        builder.request :url_encoded
        builder.request :json
        builder.response :json
        builder.adapter Faraday.default_adapter
      end
    end

    def faraday_client_options
      {
        url: "https://#{HOST}",
        ssl: { verify: true },
        headers: faraday_headers
      }
    end

    def faraday_headers
      HEADERS.merge('Authorization' => "Bearer #{@access_token}")
    end
  end
end
