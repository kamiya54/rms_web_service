module RmsWebService
  module Response
    module Item
      class Insert < Parser
        attr_accessor :code, :errors
        def initialize(xml)
          super
          set_attributes @parsed_xml.xpath("//item").children
        end

        def success?
          @code == "N000" ? true : false
        end
      end
    end
  end
end
