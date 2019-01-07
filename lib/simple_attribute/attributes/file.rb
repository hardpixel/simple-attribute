module SimpleAttribute
  module Attributes
    class File < Link
      def attribute_name
        'file'
      end

      def render_attribute
        file  = value.to_s.split('/').last.split('.').first
        label = file.try(label_method)
        title = file.try(title_method)

        link_to label, value.to_s, html_options.merge(title: title)
      end
    end
  end
end
