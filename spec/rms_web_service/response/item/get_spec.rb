require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Get do
  let(:api) {described_class.new(fixture('get.xml'))}

  describe 'attributes' do
    it 'should respond to SystemResult' do
      expect(api).to respond_to :status
    end
  
    it 'should respond to ItemGetResult' do
      expect(api).to respond_to :code
      expect(api).to respond_to :success?
    end
  
    it 'should respond to Item' do
      expect(api).to respond_to :item_url
      expect(api).to respond_to :item_name
      expect(api).to respond_to :item_price
    end
  
    it 'should not respond to ErrorMessage' do
      expect(api).not_to respond_to :errors
    end
  end
end
