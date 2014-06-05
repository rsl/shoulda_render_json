class ShouldaRenderJsonObjectMatcher
  attr_reader :options, :context, :root, :keys, :response, :failure_message, :negative_failure_message

  def initialize(root, options = {})
    @options = options
    # Coercing types root: Symbol, keys: Array of Symbols
    @root = root.to_s
    @keys = {
      required: massage_options(:required),
      forbidden: massage_options(:forbidden),
    }
  end

  def description
    "render JSON Hash/Object for #{@root}"
  end

  def matches?(controller)
    @response = controller.response
    matches_content_type? &&
      matches_root? &&
      has_required_keys? &&
      has_no_forbidden_keys?
  end

private

  def matches_content_type?
    content_type = response.content_type
    set_failure_message "Expected content type to be 'application/json' but was '#{content_type}' instead"
    set_negative_failure_message "Expected content type not to be '#{content_type}'"
    content_type == 'application/json'
  end

  def root_matches_expected_type?
    matches_root? ? root_is_expected_type? : false
  end

  def matches_root?
    klass = json[root].class
    set_failure_message "Expected root level node '#{root}' as Hash/Object but it was not found [class was #{klass}]"
    set_negative_failure_message "Did not expect to contain root level node '#{root}' but it was present as #{klass}"
    json.has_key?(root) && json[root].is_a?(expected_root_class)
  end

  def has_required_keys?
    return true unless keys[:required]
    set_failure_message "Expected child nodes for #{format_keys(missing_keys)} but there were none"
    set_negative_failure_message "Expected no child nodes for #{format_keys(missing_keys)} but they were present"
    missing_keys.empty?
  end

  def has_no_forbidden_keys?
    return true unless keys[:forbidden]
    set_failure_message "Expected no child nodes for #{format_keys(forbidden_keys)} but they were present"
    # Negative failure here makes no sense since they are expected to not be present
    forbidden_keys.empty?
  end

  def missing_keys
    @missing_keys ||= keys[:required].reject{|key| json[root].has_key?(key)}
  end

  def forbidden_keys
    @forbidden_keys ||= keys[:forbidden].select{|key| json[root].has_key?(key)}
  end

  def set_negative_failure_message(message)
    @negative_failure_message = message
  end

  def set_failure_message(message)
    @failure_message = message
  end

  def format_keys(keys)
    keys.map{|key| "'#{key}'"}.join(', ')
  end

  def json
    @json ||= JSON.parse(response.body)
  end

  def expected_root_class
    Hash
  end

  def massage_options(key)
    [options[key]].flatten.compact.map(&:to_s)
  end
end
