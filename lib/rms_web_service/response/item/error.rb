module RmsWebService
  module Response
    module Item
      class Error < Parser
        def initialize(xml)
          set_attributes Nokogiri::XML.parse(xml).xpath("//errorMessage").children
        end
      end
    end
  end
end
