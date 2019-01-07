module SimpleAttribute
  module Attributes
    class Base
      attr_accessor :options, :record, :attribute, :value

      def initialize(context, options)
        @context   = context
        @options   = options.reverse_merge defaults
        @record    = options.fetch :record
        @attribute = options.fetch :attribute
        @value     = @record.send attribute if attribute
      end

      def defaults
        Hash(SimpleAttribute.config.send(:"#{renderer_name}")).symbolize_keys
      end

      def value?
        if value.is_a? ActiveRecord::Base
          value.try(:id).present?
        elsif value.is_a? String
          strip_tags(value).present?
        else
          value.present?
        end
      end

      def default_value
        @options.fetch :default_value, '—'
      end

      def wrapper?
        options[:wrapper] != false
      end

      def wrapper
        wrapper = options.fetch :wrapper, nil
        wrapper = SimpleAttribute.config.wrappers.try(:"#{wrapper}") unless wrapper.is_a? Hash

        Hash(wrapper).symbolize_keys
      end

      def renderer_name
        name = self.class.name.gsub('Attribute', '')
        name = name.demodulize.underscore

        name == 'base' ? 'string' : name.to_s.dasherize
      end

      def attribute_name
        attribute.to_s.dasherize
      end

      def label_method
        @options.fetch(:label, :to_s)
      end

      def html_options
        options.fetch :html, {}
      end

      def wrapper_html
        classes = ['attribute', attribute_name, renderer_name].uniq.join ' '
        classes = "#{wrapper[:class]} #{classes}".strip

        wrapper.merge(class: classes)
      end

      def render_default_value
        if default_value.present?
          @options[:wrapper] = nil
          content_tag :span, default_value, class: "attribute-default-value"
        end
      end

      def render_attribute
        value.try(label_method).to_s.html_safe
      end

      def render_with_default
        if value?
          render_attribute
        else
          render_default_value
        end
      end

      def render_wrapper
        content_tag :span, render_with_default.to_s.html_safe, wrapper_html
      end

      def render
        content = wrapper? ? render_wrapper : render_with_default
        content.to_s.html_safe
      end

      def method_missing(method, *args, &block)
        @context.respond_to?(method) ? @context.send(method, *args, &block) : super
      end
    end
  end
end
