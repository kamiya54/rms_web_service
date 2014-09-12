module RmsWebService
  module Response
    module Item
      class Update < Parser
        attr_accessor :code
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//item").children
          set_attributes xml.xpath("//errorMessage").children if xml.xpath("//errorMessage").present?
          @code = xml.xpath("//code").first.content
          super
        end
      end
    end
  end
end
