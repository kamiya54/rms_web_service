module RmsWebService
  module Response
    module Item
      class Error < Parser
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//errorMessage").children
        end
      end
    end
  end
end
