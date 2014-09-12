module RmsWebService
  module Response
    module Item
      class Status < Parser
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//status").children
        end
      end
    end
  end
end
