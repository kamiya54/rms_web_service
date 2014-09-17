require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::Insert do
  let(:api) {described_class.new(fixture('insert.xml'))}

  describe 'attributes' do
    it 'should respond to SystemResult' do
      expect(api).to respond_to :status
    end
  
    it 'should respond to ItemDeleteResult' do
      expect(api).to respond_to :code
      expect(api).to respond_to :success?
    end
  
    it 'should respond to Item' do
      expect(api).to respond_to :item_url
    end
  
    it 'should respond to ErrorMessage' do
      expect(api).to respond_to :errors
    end
  end
end
