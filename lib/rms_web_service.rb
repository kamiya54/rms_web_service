require "rms_web_service/version"
require "rms_web_service/configuration"
require "rms_web_service/item"

RWS = RmsWebService

module RmsWebService
  Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"

  def configuration(&block)
    @configuration ||= Configuration.new
    block.call @configuration if block_given?
    return @configuration
  end

  module_function :configuration

  class AuthError < StandardError
  end
end
