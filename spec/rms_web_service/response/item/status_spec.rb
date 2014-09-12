require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Status do
  let(:status) {described_class.new(fixture('get.xml'))}
  it 'should have methods to return system status' do
    expect(status.respond_to?('interface_id')).to be_truthy
    expect(status.respond_to?('system_status')).to be_truthy
  end
end
