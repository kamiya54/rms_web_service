require 'spec_helper'
require 'rms_web_service/item'

describe RmsWebService do
  describe '.configuration' do
    let(:config) {RmsWebService.configuration}
  
    context "don't set serviceSecret and licenseKey" do
      it 'raise AuthError' do
        expect{config.encoded_keys}.to raise_error RmsWebService::AuthError
      end
    end

    context 'set serviceSecret and licenseKey correctly' do
      before :each do
        RmsWebService.configuration do |c|
          c.service_secret = 'dummy_service_secret'
          c.license_key = 'dummy_license_key'
        end
      end
  
      it 'can set parameters properly' do
        expect(config.service_secret).to eq 'dummy_service_secret'
        expect(config.license_key).to eq 'dummy_license_key'
      end
  
      it 'return encoded keys' do
        expect(Base64.decode64(config.encoded_keys.gsub('ESA ', ''))).to eq 'dummy_service_secret:dummy_license_key'
      end
    end
  end
end
