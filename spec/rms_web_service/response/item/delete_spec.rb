require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Delete do
  subject {described_class.new(fixture('delete.xml'))}
  it {is_expected.to respond_to(:status, :code, :success?, :item_url)}
end
