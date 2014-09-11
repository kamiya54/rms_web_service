module RmsWebService
  class Item
    class ItemsUpdate < Array
      include Response
      def initialize(xml)
        xml = Nokogiri::XML.parse(xml)
        set_attributes xml.xpath("//status").children
        xml.xpath("//itemsUpdateResult").children.each {|item| self << Update.new(item.to_xml)}
      end
    end
  end
end
