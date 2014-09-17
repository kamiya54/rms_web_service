module RmsWebService
  module Response
    module Item
      class Error
        def self.parse(xml)
          raise ArgumentError, "Argument must be a String class. but argument is #{xml.class}." unless xml.class == String
          hash = Hash.new
          Nokogiri::XML.parse(xml).xpath("//errorMessage").children.each {|att| hash.store(att.name.underscore, att.content)}
          return hash
        end
      end
    end
  end
end
