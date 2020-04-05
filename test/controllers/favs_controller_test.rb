require 'test_helper'

class FavsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favs_create_url
    assert_response :success
  end

end
