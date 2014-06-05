class ShouldaRenderJsonArrayMatcher < ShouldaRenderJsonObjectMatcher
  def description
    "render JSON array for #{@root}"
  end

private

  def missing_keys
    @missing_keys ||= keys[:required].select do |key|
      key unless json[root].all?{|node| node.has_key?(key)}
    end
  end

  def forbidden_keys_found
    @forbidden_keys ||= keys[:forbidden].select do |key|
      key if json[root].any?{|node| node.has_key?(key)}
    end
  end

  def expected_root_class
    Array
  end
end
