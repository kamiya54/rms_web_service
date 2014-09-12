require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Status do
  subject {described_class.new(fixture('get.xml'))}
  it {is_expected.to respond_to(:interface_id, :system_status)}
end
