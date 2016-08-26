require 'test_helper'

class MissionControllerTest < ActionController::TestCase
  test "should get detail" do
    get :detail
    assert_response :success
  end

end
