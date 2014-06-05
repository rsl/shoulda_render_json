require 'shoulda_render_json/version'
require 'shoulda_render_json_object_matcher'
require 'shoulda_render_json_array_matcher'
require 'shoulda_render_json_test_integration'

if defined?(ActionController)
  ActionController::TestCase.__send__ :extend, ShouldaRenderJsonTestIntegration
end
