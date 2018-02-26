require 'test_helper'

class TeamControllerTest < ActionDispatch::IntegrationTest
  test "should get index,create,update,new" do
    get team_index,create,update,new_url
    assert_response :success
  end

end
