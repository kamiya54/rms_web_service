require 'spec_helper'

describe RmsWebService::Configuration do
  let(:config){ described_class.new(service_secret: service_secret, license_key: license_key) }
  let(:service_secret){ "dummy_service_secret" }
  let(:license_key){ "dummy_license_key" }

  describe "#service_secret" do
    subject{ config.service_secret }
    it { is_expected.to eq(service_secret) }
  end

  describe "#license_key" do
    subject{ config.license_key }
    it { is_expected.to eq(license_key) }
  end

  describe "#encoded_keys" do
    context "with service_secret and license_key" do
      let(:encoded_string){
        encoded_credentials = Base64.encode64("#{service_secret}:#{license_key}")
        "ESA #{encoded_credentials}".chomp
      }

      subject{ config.encoded_keys }
      it { is_expected.to eq(encoded_string) }
    end

    context "without service_secret" do
      before { config.service_secret = nil }

      it "should raise ParameterError" do
        expect{ config.encoded_keys }.to raise_error(RmsWebService::ParameterError, /service_secret/)
      end
    end

    context "without license_key" do
      before { config.license_key = nil }

      it "should raise ParameterError" do
        expect{ config.encoded_keys }.to raise_error(RmsWebService::ParameterError, /license_key/)
      end
    end
  end
end
