module RmsWebService
  module Response
    module Item
      class Parser < Array
        attr_accessor :status
        def initialize(xml)
          @parsed_xml = Nokogiri::XML.parse(xml)
          @status = Item::Status.new(xml)
          @code = @parsed_xml.xpath("//code").first.content if @parsed_xml.xpath("//code").present?
          @errors = []
          @parsed_xml.xpath("//errorMessages").each {|error| @errors << Error.new(error)} if @parsed_xml.xpath("//errorMessages").present?
        end

        def set_attributes(args)
          args.each {|s| set_attribute(s.name, s.content)}
        end

        def set_attribute(name, content)
          att = name.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
          self.define_singleton_method(att) {content}
        end
      end
    end
  end
end
