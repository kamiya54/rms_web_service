module RmsWebService
  class Item
    def self.delete(args)
      xml_object = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.request do
          xml.itemDeleteRequest do
            xml.item do
              args.each {|key, value| eval("xml.#{key.to_s.camelize(:lower)} '#{value}'")}
            end
          end
        end
      end

      request = connection("item/delete").post {|req| req.body = xml_object.to_xml}
      return Delete.new(request.body)
    end

    class Delete
      include Response
      def initialize(xml)
        xml = Nokogiri::XML.parse(xml)
        set_attributes xml.xpath("//status").children
        set_attributes xml.xpath("//item").children
        set_attribute("code", xml.xpath("//code").first.content)
      end
    end
  end
end
