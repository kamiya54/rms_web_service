module RmsWebService
  module Response
    module Item
      class Insert < Parser
        attr_accessor :code, :errors
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          set_attributes xml.xpath("//item").children
          @code = xml.xpath("//code").first.content
          @errors = []
          xml.xpath("//errorMessages").each {|error| @errors << Error.new(error)}
          super
        end

        def success?
          return @code == "N000" ? true : false
        end
      end
    end
  end
end
