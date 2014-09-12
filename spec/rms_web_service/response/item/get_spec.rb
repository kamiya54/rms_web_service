require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Get do
  subject {described_class.new(fixture('get.xml'))}
  it {is_expected.to respond_to(:status, :code, :item_url, :item_name, :item_price)}
end
