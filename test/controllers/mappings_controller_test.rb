require 'test_helper'

class MappingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mappings_new_url
    assert_response :success
  end

  test "should get create" do
    get mappings_create_url
    assert_response :success
  end

end
