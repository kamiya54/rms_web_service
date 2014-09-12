require "rms_web_service/version"
require "rms_web_service/configuration"
require "rms_web_service/client"
require "rms_web_service/response"

RWS = RmsWebService

module RmsWebService
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
