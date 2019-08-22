require 'test_helper'

class YoursControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get yours_show_url
    assert_response :success
  end

end
