require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Search do
  subject(:res) {described_class.new(fixture('search.xml'))}
  it {is_expected.to respond_to(:status, :success?, :code)}
  it {is_expected.to_not respond_to(:item_url)}
  it 'should be an array of RWS::Response::Item::Get' do
    expect(res[0]).to be_a RWS::Response::Item::Get
  end
end
