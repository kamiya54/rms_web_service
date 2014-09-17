require 'spec_helper'
require 'rms_web_service'

describe RWS::Response::Item::Error do
  subject {described_class.parse(fixture('update.xml').read)}
  it {is_expected.to be_a Hash}

  describe "attributes" do
    it {is_expected.to include('error_id')}
    it {is_expected.to include('field_id')}
    it {is_expected.to include('msg')}
  end

  describe 'invalid argument' do
    it "" do
      expect{described_class.parse(Array.new)}.to raise_error ArgumentError
    end
  end
end
