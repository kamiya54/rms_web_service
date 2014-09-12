require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Update do
  subject {described_class.new(fixture('update.xml'))}
  it {is_expected.to respond_to(:status, :code, :item_url)}
end
