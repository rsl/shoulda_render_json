module ShouldaRenderJsonTestIntegration
  def render_json(key, options = {})
    klass = if options[:type] == Array
      ShouldaRenderJsonArrayMatcher
    else
      ShouldaRenderJsonObjectMatcher
    end
    klass.new key, options
  end
end
