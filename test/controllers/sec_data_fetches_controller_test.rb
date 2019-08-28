require 'test_helper'

class SecDataFetchesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sec_data_fetches_show_url
    assert_response :success
  end

end
