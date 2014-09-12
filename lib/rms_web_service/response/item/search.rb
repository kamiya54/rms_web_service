module RmsWebService
  module Response
    module Item
      class Search < ::Array
        include ::RmsWebService::Response
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//status").children
          set_attribute("code", xml.xpath("//code").first.content)
          xml.xpath("//items").children.each {|item| self << Get.new(item.to_xml)}
        end
      end
    end
  end
end
