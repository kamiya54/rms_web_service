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
        Faraday.new(:url => endpoint(method)) do |c|
          c.adapter Faraday.default_adapter
          c.headers['Authorization'] = self.configuration.encoded_keys
        end
      end

      def endpoint(method)
        @endpoint || Endpoint + method
      end

      def get(item_url)
        request = connection('item/get').get {|req| req.params['itemUrl'] = item_url }
        ::RWS::Response::Item::Get.new(request.body)
      end

      def insert(args)
        xml = {:itemInsertRequest => {:item => args}}.to_xml(:root => 'request', :camelize => :lower, :skip_types => true)
        request = connection("item/insert").post {|req| req.body = xml}
        ::RWS::Response::Item::Insert.new(request.body)
      end

      def update(args)
        xml = {:itemUpdateRequest => {:item => args}}.to_xml(:root => 'request', :camelize => :lower, :skip_types => true)
        request = connection("item/update").post {|req| req.body = xml}
        ::RWS::Response::Item::Update.new(request.body)
      end

      def delete(item_url)
        xml = {:itemDeleteRequest => {:item => {:itemUrl => item_url}}}.to_xml(:root => 'request', :camelize => :lower, :skip_types => true)
        request = connection("item/delete").post {|req| req.body = xml}
        ::RWS::Response::Item::Delete.new(request.body)
      end

      def search(args)
        request = connection("item/search").get do |req|
          args.each {|key, value| req.params["#{key.to_s.camelize(:lower)}"] = args[:"#{key}"]}
        end
        ::RWS::Response::Item::Search.new(request.body)
      end

      def items_update(args)
        xml = {:itemsUpdateRequest => {:items => args}}.to_xml(:root => 'request', :camelize => :lower, :skip_types => true)
        request = connection("items/update").post {|req| req.body = xml}
        ::RWS::Response::Item::ItemsUpdate.new(request.body)
      end
    end
  end
end
