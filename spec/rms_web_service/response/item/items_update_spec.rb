require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::ItemsUpdate do
  subject(:res) {described_class.new(fixture('items_update.xml'))}
  it {is_expected.to respond_to(:status)}
  it {is_expected.to_not respond_to(:code, :item_url)}
  it 'should be an array of RWS::Response::Item::Update' do
    expect(res[0]).to be_a RWS::Response::Item::Update
  end
end
