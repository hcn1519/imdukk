require 'test_helper'

class RegisterControllerTest < ActionController::TestCase
  test "should get info1" do
    get :info1
    assert_response :success
  end

  test "should get info2" do
    get :info2
    assert_response :success
  end

end
