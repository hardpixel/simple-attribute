module SimpleAttribute
  module Attributes
    class Base
      attr_accessor :options, :record, :attribute, :value

      # Initialize base attribute
      def initialize(context, options)
        @context   = context
        @options   = options.reverse_merge defaults
        @record    = options.fetch :record
        @attribute = options.fetch :attribute
        @value     = @record.send attribute if attribute
      end

      # Get default options
      def defaults
        Hash(SimpleAttribute.config.send(:"#{renderer_name}")).symbolize_keys
      end

      # Check if has value
      def value?
        if value.is_a? ActiveRecord::Base
          value.try(:id).present?
        elsif value.is_a? String
          strip_tags(value).present?
        else
          value.present?
        end
      end

      # Get default value
      def default_value
        @options.fetch :default_value, '—'
      end

      # Check if needs wrapper
      def wrapper?
        options[:wrapper] != false
      end

      # Get wrapper
      def wrapper
        wrapper = options.fetch :wrapper, nil
        wrapper = SimpleAttribute.config.wrappers.send(:"#{wrapper}") unless wrapper.is_a? Hash

        Hash(wrapper).symbolize_keys
      end

      # Wrapper name
      def renderer_name
        name = self.class.name.gsub('Attribute', '')
        name = name.demodulize.underscore

        name == 'base' ? 'string' : "#{name}".dasherize
      end

      # Attribute name
      def attribute_name
        "#{attribute}".dasherize
      end

      # Attribute html options
      def html_options
        options.fetch :html, {}
      end

      # Wrapper html
      def wrapper_html
        classes = ['attribute', attribute_name, renderer_name].uniq.join ' '
        classes = "#{wrapper[:class]} #{classes}".strip

        wrapper.merge(class: classes)
      end

      # Render default value
      def render_default_value
        if default_value.present?
          @options[:wrapper] = nil
          content_tag :span, default_value, class: "attribute-default-value"
        end
      end

      # Render attribute
      def render_attribute
        "#{value || default_value}".html_safe
      end

      # Render attribute or default
      def render_with_default
        if value?
          render_attribute
        else
          render_default_value
        end
      end

      # Render wrapper
      def render_wrapper
        content_tag :span, render_with_default.to_s.html_safe, wrapper_html
      end

      # Render
      def render
        content = wrapper? ? render_wrapper : render_with_default
        content.to_s.html_safe
      end

      # Use view helpers if method is missing
      def method_missing(method, *args, &block)
        self.respond_to?(method) ? super : @context.send(method, *args, &block)
      end
    end
  end
end
