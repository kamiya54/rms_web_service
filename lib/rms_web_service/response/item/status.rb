module RmsWebService
  module Response
    module Item
      class Status < Parser
        def initialize(xml)
          set_attributes Nokogiri::XML.parse(xml).xpath("//status").children
        end
      end
    end
  end
end
