module SimpleAttribute
  class Builder
    # Initialize base attribute
    def initialize(context, options={})
      @context  = context
      @options  = options
      @record   = options[:record]
      @renderer = options.fetch :as, guess_renderer
    end

    # Base attribute renderer
    def base_renderer
      'SimpleAttribute::Attributes::Base'.safe_constantize
    end

    # Guess renderer
    def guess_renderer
      attrib = @options[:attribute].to_s
      column = @record.class.attribute_types[attrib]
      column = column.class.name.demodulize.downcase.to_sym unless column.nil?

      column || :base
    end

    # Find attribute renderer
    def find_renderer(renderer)
      renderer = "#{renderer}".classify
      custom   = "#{renderer}Attribute".safe_constantize
      builtin  = "SimpleAttribute::Attributes::#{renderer}".safe_constantize if custom.nil?

      custom || builtin || base_renderer
    end

    # Render attribute
    def render_attribute(renderer)
      renderer = find_renderer renderer
      options  = @options.except(:as)

      renderer.new(@context, options).render
    end

    # Render
    def render
      @rendered_attribute ||= begin
        html = Array(@renderer).map { |w| render_attribute(w) }
        html.reject(&:blank?).join.html_safe
      end
    end
  end
end
