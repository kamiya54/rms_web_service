module RmsWebService
  module Response
    module Item
      class Update < Parser
        attr_accessor :code, :errors
        def initialize(xml)
          super
          set_attributes @parsed_xml.xpath("//item").children
        end

        def success?
          return @code == "N000" ? true : false
        end
      end
    end
  end
end
