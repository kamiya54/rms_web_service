require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Client::Item do
  subject(:client) {described_class.new(:service_secret => service_secret, :license_key => license_key)}
  let(:service_secret) {'dummy_service_secret'}
  let(:license_key) {'dummy_license_key'}
  let(:default_url) {"https://api.rms.rakuten.co.jp/es/1.0/"}
  let(:specified_url) {"https://example.com/"}

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

  describe '.endpoint' do
    context 'default URL' do
      subject {client.endpoint("item/get")}
      it { is_expected.to eq default_url + "item/get"}
    end
    context 'specify URL' do
      let(:api) {described_class.new(:service_secret => service_secret, :license_key => license_key, :endpoint => specified_url)}
      subject {api.endpoint("item/get")}
      it { is_expected.to eq specified_url}
    end
  end

  describe '.get' do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/item/get?itemUrl=test001")
      .to_return(:status => 200, body: fixture('get.xml'))
    end
    subject {client.get('test001')}
    it {is_expected.to be_a RWS::Response::Item::Get}
  end

  describe '.delete' do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/item/delete")
      .to_return(:status => 200, body: fixture('delete.xml'))
    end
    subject {client.delete('test001')}
    it {is_expected.to be_a RWS::Response::Item::Delete}
  end

  describe '.insert' do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/item/insert")
      .to_return(:status => 200, body: fixture('insert.xml'))
    end
    subject {client.insert({
      :item_url => 'test001',
      :item_name => 'test001',
      :genre_id => '560420'
    })}
    it {is_expected.to be_a RWS::Response::Item::Insert}
  end

  describe '.update' do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/item/update")
      .to_return(:status => 200, body: fixture('update.xml'))
    end
    subject {client.update({:item_url => 'test001', :item_price => '10000'})}
    it {is_expected.to be_a RWS::Response::Item::Update}
  end

  describe '.search' do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/item/search?itemName=test001&itemPriceFrom=1")
      .to_return(:status => 200, body: fixture('search.xml'))
    end
    subject {client.search(:item_name => 'test001', :item_price_from => 1)}
    it {is_expected.to be_a RWS::Response::Item::Search}
  end

  describe '.items_update' do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/items/update")
      .to_return(:status => 200, body: fixture('items_update.xml'))
    end
    subject {client.items_update([
      {:item_url => 'test001', :item_price => 100},
      {:item_url => 'test002', :item_price => 200}
    ])}
    it {is_expected.to be_a RWS::Response::Item::ItemsUpdate}
  end
end
