require "rms_web_service/version"
require "rms_web_service/configuration"
require "rms_web_service/item"

RWS = RmsWebService

module RmsWebService
  Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"

  @@configuration = Configuration.new

  def configure(&block)
    block.call @@configuration if block_given?
  end
  module_function :configure

  def configuration
    @@configuration
  end
  module_function :configuration

  class AuthError < StandardError
  end

  class ParameterError < StandardError
  end
end
