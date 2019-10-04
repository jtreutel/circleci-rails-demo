require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ''
    assert_response :success
    assert_select '.lead a', 'Learn more about StillCoin'
  end
end
