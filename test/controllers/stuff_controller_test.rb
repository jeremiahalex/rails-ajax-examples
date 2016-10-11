require 'test_helper'

class StuffControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stuff_index_url
    assert_response :success
  end

end
