require 'test_helper'

class FinancialControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get financial_show_url
    assert_response :success
  end

end
