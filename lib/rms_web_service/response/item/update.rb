module RmsWebService
  module Response
    module Item
      class Update
        include ::RmsWebService::Response
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//status").children
          set_attributes xml.xpath("//item").children
          set_attributes xml.xpath("//errorMessage").children if xml.xpath("//errorMessage").present?
          set_attribute("code", xml.xpath("//code").first.content)
        end
      end
    end
  end
end
