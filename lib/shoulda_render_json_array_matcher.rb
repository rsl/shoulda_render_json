class ShouldaRenderJsonArrayMatcher < ShouldaRenderJsonObjectMatcher
  def description
    "render JSON array for #{@root}"
  end

private

  def expected_root_class
    Array
  end

  def present?(key)
    json[root].all?{|node| node.has_key?(key)}
  end
end
