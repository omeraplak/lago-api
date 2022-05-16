# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LagoHttpClient::Client do
  subject(:client) { described_class.new(url) }
  let(:url) { 'http://example.com/api/v1/example' }

  describe '#post' do
    context 'when response status code is 2xx' do
      let(:response) do
        {
          'status' => 200,
          'message' => 'Success'
        }.to_json
      end

      before do
        stub_request(:post, 'http://example.com/api/v1/example')
          .to_return(body: response, status: 200)
      end

      it 'returns response body' do
        response = client.post('', {})

        expect(response['status']).to eq 200
        expect(response['message']).to eq 'Success'
      end
    end

    context 'when response status code is NOT 2xx' do
      let(:response) do
        {
          'status' => 422,
          'error' => 'Unprocessable Entity',
          'message' => 'Validation error on the record'
        }.to_json
      end

      before do
        stub_request(:post, 'http://example.com/api/v1/example')
          .to_return(body: response, status: 422)
      end

      it 'raises an error' do
        expect { client.post('', {}) }.to raise_error LagoHttpClient::HttpError
      end
    end
  end
end