# frozen_string_literal: true

module LineNotify
  # ## LineNotify::Response
  # A class for response data returned from API.
  #
  class Response
    HTTP_STATUS_SUCCESS = 200
    HTTP_STATUS_BAD_REQUEST = 400
    HTTP_STATUS_TOKEN_EXPIRED = 401
    HTTP_STATUS_INTERNAL_ERROR = 500

    def initialize(faraday_response)
      @raw_body = faraday_response.body
      @raw_headers = faraday_response.headers
      @raw_status = faraday_response.status
    end

    # ### LineNotify::Response#body
    # Returns response body returned from API as a `Hash`.
    #
    # ```rb
    # response.body #=> { ... }
    # ```
    #
    def body
      @raw_body
    end

    # ### LineNotify::Response#headers
    # Returns response headers returned from API as a `Hash`.
    #
    # ```rb
    # response.headers #=> { "Content-Type" => "application/json" }
    # ```
    #
    def headers
      @headers ||= @raw_headers.inject({}) do |result, (key, value)|
        result.merge(key.split("-").map(&:capitalize).join("-") => value)
      end
    end

    # ### LineNotify::Response#status
    # Returns response status code returned from API as a `Integer`.
    #
    # ```rb
    # response.status #=> 200
    # ```
    #
    def status
      @raw_status
    end

    # ### LineNotify::Response#status_message
    # Returns response status message returned from API as a `String`.
    #
    # ```rb
    # response.status_message #=> "OK"
    # ```
    #
    def status_message
      Rack::Utils::HTTP_STATUS_CODES[status]
    end

    # ### LineNotify::Response#success?
    # Returns success boolean value from API as a `TrueClass` or `FalseClass`.
    #
    # ```rb
    # response.success? #=> true
    # ```
    #
    def success?
      status == HTTP_STATUS_SUCCESS
    end

    # ### LineNotify::Response#status
    # Returns response status from API as a `TrueClass` or `FalseClass`.
    #
    # ```rb
    # response.success? #=> true
    # ```
    #
    def error?
      !success?
    end

    def bad_request?
      status == HTTP_STATUS_BAD_REQUEST
    end

    def token_expired?
      status == HTTP_STATUS_TOKEN_EXPIRED
    end

    def internal_error?
      status == HTTP_STATUS_INTERNAL_ERROR
    end
  end
end
