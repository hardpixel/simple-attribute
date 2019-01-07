module SimpleAttribute
  class Matcher
    def initialize(record, attribute)
      @record    = record
      @attribute = attribute
      @value     = record.try(attribute)

      find_type
      find_type_name
    end

    def find_type
      @type ||= @record.class.attribute_types[@attribute.to_s]
    end

    def find_type_name
      @type_name ||= @type.class.name.demodulize.downcase unless @type.nil?
    end

    def file_method?
      methods = [:mounted_as, :file?, :public_filename]
      methods.any? { |m| @value.respond_to?(m) }
    end

    def find_file_type
      media_type = MiniMime.lookup_by_filename(@value.to_s)
      media_type = media_type.content_type.split('/').first unless media_type.nil?
      available  = [:image, :video]

      available.find { |t| t.to_s == media_type } || :file
    end

    def match
      file_method? ? find_file_type : @type_name.to_sym
    end
  end
end
