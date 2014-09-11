require 'spec_helper'
require 'rms_web_service/item'

describe RmsWebService::Item do
  describe '.connection' do
    before do
      RmsWebService.configure do |c|
        c.service_secret = 'dummy_service_secret'
        c.license_key = 'dummy_license_key'
      end
    end

    it 'return instance of Faraday::Connection' do
      expect(RmsWebService::Item.connection("item/get")).to be_a Faraday::Connection
    end

    it 'have a collect endpoint' do
      expect(RmsWebService::Item.endpoint("item/get")).to eq "https://api.rms.rakuten.co.jp/es/1.0/item/get"
    end
  end
end
