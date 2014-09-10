module RmsWebService
  class Item
    def self.update(args)
      xml_object = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.request do
          xml.itemUpdateRequest do
            xml.item do
              args.each {|key, value| eval("xml.#{key.to_s.camelize(:lower)} '#{value}'")}
            end
          end
        end
      end

      request = connection("item/update").post {|req| req.body = xml_object.to_xml}
      return Update.new(request.body)
    end

    class Update
      include Response
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
