#encoding: utf-8
module RmsWebService
  module Response
    module Item
      class Error
        require 'rms_web_service/response/item/error/const'
        def self.parse(xml)
          raise ArgumentError, "Argument must be a String class. but argument is #{xml.class}." unless xml.class == String
          hash = Hash.new
          Nokogiri::XML.parse(xml).xpath("//errorMessage").children.each {|att| hash.store(att.name.underscore, att.content)}
          if hash['field_id'] && ::FIELDID_LIST["#{hash['field_id']}"].present?
            hash.store("field", ::FIELDID_LIST["#{hash['field_id']}"][0].underscore)
            hash.store("field_name", ::FIELDID_LIST["#{hash['field_id']}"][1].underscore)
          end
          hash
        end
      end
    end
  end
end
