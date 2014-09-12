module RmsWebService
  module Response
    module Item
      class ItemsUpdate < Parser
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          xml.xpath("//itemsUpdateResult").children.each {|item| self << Update.new(item.to_xml)}
          super
        end
      end
    end
  end
end