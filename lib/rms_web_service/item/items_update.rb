module RmsWebService
  class Item
    def self.items_update(args)
      xml_object = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.request do
          xml.itemsUpdateRequest do
            xml.items do
              args.each do |item|
                xml.item do
                  item.each {|key, value| eval("xml.#{key.to_s.camelize(:lower)} '#{value}'")}
                end
              end
            end
          end
        end
      end

      request = connection("items/update").post {|req| req.body = xml_object.to_xml}
      return ItemsUpdate.new(request.body)
    end

    class ItemsUpdate < Array
      include Response
      def initialize(xml)
        xml = Nokogiri::XML.parse(xml)
        set_attributes xml.xpath("//status").children
        xml.xpath("//itemsUpdateResult").children.each {|item| self << Update.new(item.to_xml)}
      end
    end
  end
end
