require "rms_web_service/version"
require "rms_web_service/configuration"
require "rms_web_service/item"

RWS = RmsWebService

module RmsWebService
  Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"
  class AuthError < StandardError;end
end
