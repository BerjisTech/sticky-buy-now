require 'test_helper'

class ShopControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shop_show_url
    assert_response :success
  end

  test "should get update" do
    get shop_update_url
    assert_response :success
  end

end
