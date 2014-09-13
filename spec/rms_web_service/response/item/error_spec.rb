require 'spec_helper'
require 'rms_web_service'

describe RWS::Response::Item::Error do
  subject(:error) {described_class.new(fixture('update.xml'))}
  it {is_expected.to be_a RWS::Response::Item::Error}
  it {is_expected.to respond_to(:field_id)}
end
