require 'spec_helper'

describe RmsWebService do
  describe '.configure' do
  end

  describe ".configuration" do
    subject { described_class.configuration }
    it { is_expected.to be_a(RmsWebService::Configuration) }
  end
end
