require 'test_helper'

class RecurringApplicationChargesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get recurring_application_charges_create_url
    assert_response :success
  end

  test "should get activate" do
    get recurring_application_charges_activate_url
    assert_response :success
  end

end
