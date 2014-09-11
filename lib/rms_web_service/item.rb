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

      def get(args)
        request = connection('item/get').get {|req| req.params['itemUrl'] = args[:item_url]}
        return Get.new(request.body)
      end

      def insert(args)
        xml_object = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.request do
            xml.itemInsertRequest do
              xml.item do
                args.each {|key, value| eval("xml.#{key.to_s.camelize(:lower)} '#{value}'")}
              end
            end
          end
        end

        request = connection("item/insert").post {|req| req.body = xml_object.to_xml}
        return Insert.new(request.body)
      end

      def update(args)
        xml_object = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.request do
            xml.itemUpdateRequest do
              xml.item do
                args.each {|key, value| eval("xml.#{key.to_s.camelize(:lower)} '#{value}'")}
              end
            end
          end
        end

        request = connection("item/update").post {|req| req.body = xml_object.to_xml}
        return Update.new(request.body)
      end

      def delete(args)
        xml_object = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.request do
            xml.itemDeleteRequest do
              xml.item do
                args.each {|key, value| eval("xml.#{key.to_s.camelize(:lower)} '#{value}'")}
              end
            end
          end
        end

        request = connection("item/delete").post {|req| req.body = xml_object.to_xml}
        return Delete.new(request.body)
      end
    end
  end
end

