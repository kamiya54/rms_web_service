require 'nokogiri'
require 'faraday'
require 'active_support'
require 'active_support/core_ext'

module RmsWebService
  module Client
    class Item
      Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"
      attr_accessor :configuration

      def initialize(args={})
        @configuration = ::RmsWebService::Configuration.new(args)
        @endpoint = args[:endpoint]
      end

      def connection(method)
        connection = Faraday.new(:url => endpoint(method)) do |c|
          c.adapter Faraday.default_adapter
          c.headers['Authorization'] = self.configuration.encoded_keys
        end
      end

      def endpoint(method)
        @endpoint || Endpoint + method
      end

      def get(item_url)
        request = connection('item/get').get {|req| req.params['itemUrl'] = item_url }
        return ::RmsWebService::Response::Item::Get.new(request.body)
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
        return ::RmsWebService::Response::Item::Insert.new(request.body)
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
        return ::RmsWebService::Response::Item::Update.new(request.body)
      end

      def delete(item_url)
        xml_object = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.request do
            xml.itemDeleteRequest do
              xml.item do
                xml.itemUrl item_url
              end
            end
          end
        end

        request = connection("item/delete").post {|req| req.body = xml_object.to_xml}
        return ::RmsWebService::Response::Item::Delete.new(request.body)
      end

      def search(args)
        request = connection("item/search").get do |req|
          args.each {|key, value| req.params["#{key.to_s.camelize(:lower)}"] = args[:"#{key}"]}
        end

        return ::RmsWebService::Response::Item::Search.new(request.body)
      end

      def items_update(args)
        xml_object = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.request do
            xml.itemsUpdateRequest do
              xml.items do
                args.each do |item|
                  xml.item do
                    item.each {|key, value| eval("xml.#{key.to_s.camelize(:lower)} '#{value}'")}
                  end
                end
              end
            end
          end
        end

        request = connection("items/update").post {|req| req.body = xml_object.to_xml}
        return ::RmsWebService::Response::Item::ItemsUpdate.new(request.body)
      end
    end
  end
end
