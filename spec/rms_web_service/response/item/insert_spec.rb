require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Insert do
  subject {described_class.new(fixture('insert.xml'))}
  it {is_expected.to respond_to(:status, :code, :success?, :errors, :item_url)}
end
