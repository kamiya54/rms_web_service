require 'spec_helper'

describe RmsWebService::Response::Item::Parser do
  describe "initialize" do
    subject {::RWS::Response::Item::Update.new(fixture('update.xml'))}
    it {is_expected.to be_a ::RWS::Response::Item::Parser}
  end

  describe "#errors" do
    let(:api) {::RWS::Response::Item::Update.new(fixture('update.xml'))}
    it "" do
      expect(api.errors).to be_a Array
    end
  end
end
