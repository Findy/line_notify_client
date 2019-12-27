# frozen_string_literal: true

module LineNotify
  # Custom error class for rescuing from all LINE Notify errors
  class Error < StandardError
  end

  # Raised when HTTP request timeout
  class TimeoutError < Error; end
end
