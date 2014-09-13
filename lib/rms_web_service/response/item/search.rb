module RmsWebService
  module Response
    module Item
      class Search < Parser
        attr_accessor :code
        def initialize(xml)
          super
          @parsed_xml.xpath("//items").children.each {|item| self << Get.new(item.to_xml)}
        end

        def success?
          return @code == "200-00" ? true : false
        end
      end
    end
  end
end
