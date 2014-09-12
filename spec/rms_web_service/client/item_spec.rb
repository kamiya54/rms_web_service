require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Client::Item do
  subject(:client) {described_class.new(:service_secret => service_secret, :license_key => license_key)}
  let(:service_secret) {'dummy_service_secret'}
  let(:license_key) {'dummy_license_key'}

  describe '.new' do
    it { is_expected.to be_a RmsWebService::Client::Item }
  end

  describe '.configuration' do
    subject {client.configuration}
    it { is_expected.to be_a RmsWebService::Configuration }
  end

  describe '.connection' do
    subject {client.connection("item/get")}
    it { is_expected.to be_a Faraday::Connection }
  end

  describe '.get' do
    let(:api) {client.get(:item_url => 'test001')}
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/item/get?itemUrl=test001")
      .to_return(:status => 200, body: fixture('get.xml'))
    end

    it 'should have methods to return parameters of "get" response' do
      expect(api).to be_a RmsWebService::Response::Item::Get
      expect(api.status).to be_a RmsWebService::Response::Item::Status
      expect(api.respond_to?(:code)).to be_truthy
      expect(api.respond_to?(:item_url)).to be_truthy
    end
  end

  describe '.delete' do
    let(:api) {client.delete(:item_url => 'test001')}
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/item/delete")
      .to_return(:status => 200, body: fixture('delete.xml'))
    end

    it 'should have methods to return parameters of "delete" response' do
      expect(api).to be_a RmsWebService::Response::Item::Delete
      expect(api.status).to be_a RmsWebService::Response::Item::Status
      expect(api.respond_to?(:code)).to be_truthy
      expect(api.respond_to?(:item_url)).to be_truthy
    end
  end

  describe '.insert' do
    let(:api) {client.insert({
      :item_url => 'test001',
      :item_name => 'test001',
      :genre_id => '560420'
    })}
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/item/insert")
      .to_return(:status => 200, body: fixture('insert.xml'))
    end

    it 'should have methods to return parameters of "insert" response' do
      expect(api).to be_a RmsWebService::Response::Item::Insert
      expect(api.status).to be_a RmsWebService::Response::Item::Status
      expect(api.respond_to?(:code)).to be_truthy
      expect(api.respond_to?(:item_url)).to be_truthy
    end
  end

  describe '.update' do
    let(:api) {client.update({:item_url => 'test001', :item_price => '10000'})}
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/item/update")
      .to_return(:status => 200, body: fixture('update.xml'))
    end

    it 'should have methods to return parameters of "update" response' do
      expect(api).to be_a RmsWebService::Response::Item::Update
      expect(api.status).to be_a RmsWebService::Response::Item::Status
      expect(api.respond_to?(:code)).to be_truthy
      expect(api.respond_to?(:item_url)).to be_truthy
      expect(api.respond_to?(:error_id)).to be_truthy
    end
  end

  describe '.search' do
    let(:api) {client.search(:item_name => 'test001', :item_price_from => 1)}
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/item/search?itemName=test001&itemPriceFrom=1")
      .to_return(:status => 200, body: fixture('search.xml'))
    end

    it 'should have methods to return parameters of "search" response' do
      expect(api).to be_a RmsWebService::Response::Item::Search
      expect(api[0]).to be_a RmsWebService::Response::Item::Get
      expect(api.status).to be_a RmsWebService::Response::Item::Status
      expect(api.respond_to?(:code)).to be_truthy
      expect(api[0].respond_to?(:item_url)).to be_truthy
    end
  end

  describe '.items_update' do
    let(:api) {client.items_update([
      {:item_url => 'test001', :item_price => 100},
      {:item_url => 'test002', :item_price => 200}
    ])}
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/items/update")
      .to_return(:status => 200, body: fixture('items_update.xml'))
    end

    it 'should have methods to return parameters of "items.update" response' do
      expect(api).to be_a RmsWebService::Response::Item::ItemsUpdate
      expect(api[0]).to be_a RmsWebService::Response::Item::Update
      expect(api.status).to be_a RmsWebService::Response::Item::Status
      expect(api[0].respond_to?(:item_url)).to be_truthy
      expect(api[0].respond_to?(:code)).to be_truthy
    end
  end
end
