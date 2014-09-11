require 'spec_helper'
require 'rms_web_service/item'

describe RmsWebService::Item::Delete do
  describe '.delete' do
    let(:api) {RmsWebService::Item.delete({:item_url => 'test001'})}

    before :all do
      RmsWebService.configure do |c|
        c.service_secret = 'dummy_service_secret'
        c.license_key = 'dummy_license_key'
      end
    end

    before :each do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/item/delete")
      .to_return(:status => 200, body: fixture('delete.xml'))
    end


    it 'return instance of RmsWebService::Item::Delete' do
      expect(api).to be_a RmsWebService::Item::Delete
    end

    it "have methods to return parameters of response" do
      expect(api.respond_to?(:code)).to be_truthy
      expect(api.respond_to?(:system_status)).to be_truthy
      expect(api.respond_to?(:item_url)).to be_truthy
    end
  end
end
