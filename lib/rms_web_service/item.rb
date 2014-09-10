require 'nokogiri'
require 'faraday'
require 'active_support'
require 'active_support/core_ext'
require 'rms_web_service/item/response'
require 'rms_web_service/item/get'
require 'rms_web_service/item/insert'
require 'rms_web_service/item/update'
require 'rms_web_service/item/delete'
require 'rms_web_service/item/search'
require 'rms_web_service/item/items_update'

module RmsWebService
  class Item
    class << self
      def connection(method)
        connection = Faraday.new(:url => endpoint(method)) do |c|
          c.adapter Faraday.default_adapter
          c.headers['Authorization'] = RmsWebService.configuration.encoded_keys
        end
      end

      def endpoint(method)
        return Endpoint + method
      end
    end
  end
end

