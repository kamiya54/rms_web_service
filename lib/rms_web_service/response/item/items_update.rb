module RmsWebService
  module Response
    module Item
      class ItemsUpdate < Parser
        def initialize(xml)
          super
          @parsed_xml.xpath("//itemsUpdateResult").children.each {|item| self << Update.new(item.to_xml)}
        end
      end
    end
  end
end
