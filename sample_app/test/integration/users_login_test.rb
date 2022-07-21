require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login flash dissapears after first navigation" do
    get login_path
    assert_template 'sessions/new'
    
    post login_path, params: {
      session: {
        email: "email@example.com",
        password: "bad_password"
      }
    }
    assert_response :unauthorized
    assert_not flash.empty?
    assert_template 'sessions/new'

    get root_path
    assert flash.empty?
  end
end
