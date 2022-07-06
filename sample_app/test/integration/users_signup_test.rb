require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid user is not saved" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { 
        user: {
          name: "valid name",
          email: "validemail@example.com",
          password: "does not match",
          password_confirmation: "confirmation"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  test "error messages are shown for invalid user" do
    get signup_path
    post users_path, params: {
      user: {
        name: "",
        email: "not a valid email",
        password: "short",
        password_confirmation: "no match"
      }
    }

    assert_response :unprocessable_entity
    assert_select "#error_explanation ul" do |error_list|
      assert_select error_list, "li", 4
    end
  end

  test "valid user is saved" do
    get signup_path
    assert_difference "User.count" do
      post users_path, params: {
        user: {
          name: "valid name",
          email: "validemail@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_response 302
  end

  test "tests are isolated at data layer part 1" do
    get signup_path
    assert_difference "User.count" do
      post users_path, params: {
        user: {
          name: "same name",
          email: "same@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_response 302
  end

  test "tests are isolated at data layer part 2" do
    get signup_path
    assert_difference "User.count" do
      post users_path, params: {
        user: {
          name: "same name",
          email: "same@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_response 302
  end
end
