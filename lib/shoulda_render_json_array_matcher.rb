class ShouldaRenderJsonArrayMatcher < ShouldaRenderJsonObjectMatcher
  def description
    "render JSON array for #{@root}"
  end

private

  def missing_keys
    @missing_keys ||= keys[:required].reject{|key| json[root].all?{|node| node.has_key?(key)}}
  end

  def forbidden_keys
    @forbidden_keys ||= keys[:forbidden].select{|key| json[root].all?{|node| node.has_key?(key)}}
  end

  def expected_root_class
    Array
  end
end
