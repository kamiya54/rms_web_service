module RmsWebService
  class Item
    def self.get(args)
      request = connection('item/get').get {|req| req.params['itemUrl'] = args[:item_url]}
      return Get.new(request.body)
    end

    class Get
      include Response
      def initialize(xml)
        xml = Nokogiri::XML.parse(xml)
        set_attributes xml.xpath("//status").children
        set_attributes xml.xpath("//item").children
        set_attribute("code", xml.xpath("//code").first.content) if xml.xpath("//code").present?
      end
    end
  end
end
