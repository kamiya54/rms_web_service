module RmsWebService
  module Response
    module Item
      class Get < Parser
        attr_accessor :code
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//item").children
          @code = xml.xpath("//code").first.content if xml.xpath("//code").present?
          super
        end

        def success?
          return @code == "N000" ? true : false
        end
      end
    end
  end
end
