require 'spec_helper'
require 'rms_web_service/item'

describe RmsWebService::Item::ItemsUpdate do
  describe '.update_items' do
    let(:api) {RmsWebService::Item.items_update([
      {:item_url => 'test001', :item_price => 100},
      {:item_url => 'test002', :item_price => 200}
    ])}

    before do
      RmsWebService.configure do |c|
        c.service_secret = 'dummy_service_secret'
        c.license_key = 'dummy_license_key'
      end
    end

    before :each do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/items/update")
      .to_return(:status => 200, body: fixture('items_update.xml'))
    end

    it 'return Array of RmsWebService::Response' do
      expect(api).to be_a RmsWebService::Item::ItemsUpdate
      expect(api[0]).to be_a RmsWebService::Item::Update
    end

    it "have methods to return parameters of response" do
      expect(api.respond_to?(:system_status)).to be_truthy
      expect(api[0].respond_to?(:item_url)).to be_truthy
      expect(api[0].respond_to?(:code)).to be_truthy
    end
  end
end
