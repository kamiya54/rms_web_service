module RmsWebService
  module Response
    module Item
      class Delete
        include ::RmsWebService::Response
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//status").children
          set_attributes xml.xpath("//item").children
          set_attribute("code", xml.xpath("//code").first.content)
        end
      end
    end
  end
end
