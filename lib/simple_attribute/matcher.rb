module SimpleAttribute
  class Matcher
    # Initialize attribute matcher
    def initialize(record, attribute)
      @record    = record
      @attribute = attribute
      @value     = record.try(attribute)

      find_type
      find_type_name
    end

    # Find attribute type
    def find_type
      @type ||= @record.class.attribute_types["#{@attribute}"]
    end

    # Find type name
    def find_type_name
      @type_name ||= @type.class.name.demodulize.downcase unless @type.nil?
    end

    # Check if file method
    def file_method?
      methods = [:mounted_as, :file?, :public_filename]
      methods.any? { |m| @value.respond_to?(m) }
    end

    # Find file type
    def find_file_type
      media_type = MiniMime.lookup_by_filename("#{@value}")
      media_type = media_type.content_type.split('/').first unless media_type.nil?
      available  = [:image, :video]

      available.find { |t| "#{t}" == media_type } || :file
    end

    # Get renderer match
    def match
      file_method? ? find_file_type : @type_name.to_sym
    end
  end
end
