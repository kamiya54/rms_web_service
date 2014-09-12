module RmsWebService
  module Response
    module Item
      class Delete < Parser
        attr_accessor :code
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//item").children
          @code = xml.xpath("//code").first.content
          super
        end
      end
    end
  end
end
