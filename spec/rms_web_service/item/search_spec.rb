require 'spec_helper'
require 'rms_web_service/item'

describe RmsWebService::Item::Search do
  describe '.search' do
    let(:api) {RmsWebService::Item.search(:item_name => 'test001', :item_price_from => 1)}

    before do
      RmsWebService.configure do |c|
        c.service_secret = 'dummy_service_secret'
        c.license_key = 'dummy_license_key'
      end
    end

    before :each do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/item/search?itemName=test001&itemPriceFrom=1")
      .to_return(:status => 200, body: fixture('search.xml'))
    end

    it 'return Array of RmsWebService::Response' do
      expect(api).to be_a RmsWebService::Item::Search
      expect(api[0]).to be_a RmsWebService::Item::Get
    end

    it "have methods to return parameters of response" do
      expect(api.respond_to?(:code)).to be_truthy
      expect(api.respond_to?(:system_status)).to be_truthy
      expect(api[0].respond_to?(:item_url)).to be_truthy
    end
  end
end
