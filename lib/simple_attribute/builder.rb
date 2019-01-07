module SimpleAttribute
  class Builder
    def initialize(context, options = {})
      @context  = context
      @options  = options
      @renderer = options.fetch :as, guess_renderer
    end

    def base_renderer
      'SimpleAttribute::Attributes::Base'.safe_constantize
    end

    def guess_renderer
      record = @options[:record]
      attrib = @options[:attribute]

      SimpleAttribute::Matcher.new(record, attrib).match
    end

    def find_renderer(renderer)
      namespace = @options[:namespace]
      renderer  = "#{renderer}".classify
      custom    = "#{namespace}::#{renderer}Attribute".safe_constantize
      custom    = "#{renderer}Attribute".safe_constantize if custom.nil?
      builtin   = "SimpleAttribute::Attributes::#{renderer}".safe_constantize if custom.nil?

      custom || builtin || base_renderer
    end

    def render_attribute(renderer)
      renderer = find_renderer renderer
      options  = @options.except(:as)

      renderer.new(@context, options).render
    end

    def render
      @rendered_attribute ||= begin
        html = Array(@renderer).map { |w| render_attribute(w) }
        html.reject(&:blank?).join.html_safe
      end
    end
  end
end
