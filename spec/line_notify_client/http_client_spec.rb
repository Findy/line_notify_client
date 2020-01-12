# frozen_string_literal: true

RSpec.describe LineNotifyClient::HttpClient do
  def stub_api_request
    stub_request(request_method, request_url)
      .with(body: request_body)
      .to_return(status: status_code, body: response_body.to_json)
  end

  def success_response
    { "status" => 200, "message" => "ok" }
  end

  def status_success_response
    success_response.merge("targetType" => "USER", "target" => "DisplayName")
  end

  def invalid_token_response
    { "status" => 401, "message" => "Invalid access token" }
  end

  describe '#notify' do
    subject { LineNotifyClient.new('token').notify('test') }

    before { stub_api_request }

    let(:request_method) { :post }
    let(:request_url) { 'https://notify-api.line.me/api/notify' }
    let(:request_body) { { message: 'test' } }

    context 'when access token is valid' do
      let(:status_code) { 200 }
      let(:response_body) { status_success_response }

      it 'should return success response' do
        response = subject
        expect(response).to be_success
      end
    end

    context 'when access token is invalid' do
      let(:status_code) { 401 }
      let(:response_body) { invalid_token_response }

      it 'should return token expired response' do
        response = subject
        expect(response).to be_token_expired
      end
    end
  end

  describe '#status' do
    subject { LineNotifyClient.new('token').status }

    before { stub_api_request }

    let(:request_method) { :get }
    let(:request_url) { 'https://notify-api.line.me/api/status' }
    let(:request_body) { nil }

    context 'when access token is valid' do
      let(:status_code) { 200 }
      let(:response_body) { status_success_response }

      it 'should return success response' do
        response = subject
        expect(response).to be_success
      end
    end

    context 'when access token is invalid' do
      let(:status_code) { 401 }
      let(:response_body) { invalid_token_response }

      it 'should return token expired response' do
        response = subject
        expect(response).to be_token_expired
      end
    end
  end

  describe '#revoke' do
    subject { LineNotifyClient.new('token').revoke }

    before { stub_api_request }

    let(:request_method) { :post }
    let(:request_url) { 'https://notify-api.line.me/api/revoke' }
    let(:request_body) { nil }

    context 'when access token is valid' do
      let(:status_code) { 200 }
      let(:response_body) { status_success_response }

      it 'should return success response' do
        response = subject
        expect(response).to be_success
      end
    end

    context 'when access token is invalid' do
      let(:status_code) { 401 }
      let(:response_body) { invalid_token_response }

      it 'should return token expired response' do
        response = subject
        expect(response).to be_token_expired
      end
    end
  end

  describe 'when raised faraday error' do
    subject { LineNotifyClient.new('token').revoke }

    before { allow(Faraday).to receive_message_chain(:new, :send).and_raise(error_class) }

    context 'when raise Faraday::ClientError' do
      let(:error_class) { Faraday::Error.new('something wrong') }

      it 'should raise LineNotify::Error' do
        expect { subject }.to raise_error(LineNotify::Error)
      end
    end

    context 'when raise Faraday::Error::TimeoutError' do
      let(:error_class) { Faraday::Error::TimeoutError }

      it 'should raise LineNotify::TimeoutError' do
        expect { subject }.to raise_error(LineNotify::TimeoutError)
      end
    end
  end
end
