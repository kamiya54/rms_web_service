module RmsWebService
  class Item
    def self.search(args)
      request = connection("item/search").get do |req|
        args.each {|key, value| req.params["#{key.to_s.camelize(:lower)}"] = args[:"#{key}"]}
      end

      return Search.new(request.body)
    end

    class Search < ::Array
      include Response
      def initialize(xml)
        xml = Nokogiri::XML.parse(xml)
        set_attributes xml.xpath("//status").children
        set_attribute("code", xml.xpath("//code").first.content)
        xml.xpath("//items").children.each {|item| self << Get.new(item.to_xml)}
      end
    end
  end
end
