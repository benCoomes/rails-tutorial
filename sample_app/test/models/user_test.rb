require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name should exist" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should be shorter than 50 chars" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should exist" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "email should be shorter than 255 chars" do
    @user.email = "a" * 250 + "@a.com" # 250 + 6 = 256
    assert_not @user.valid?
  end

  test "email should accept valid patterns" do
    valid_emails = %w[user@example.com a-dash_under@foo.bar.org first.last@site.com alice+bob@baz.cn]
    
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email} should be valid"
    end
  end

  test "email should reject invalid patterns" do
    invalid_emails = %w[user@example,com user_at_example.com userexamplecom user@name. foo@bar_baz.com foo@bar+baz.com]

    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} should be invalid"
    end
  end

  test "emails should be unique" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end

  test "emails stored as lowercase" do
    upcase_email = @user.email.upcase
    @user.email = upcase_email
    @user.save
    @user.reload
    assert_not_equal @user.email, upcase_email
  end

  test "no password user is invalid" do
    @user.password = ""
    @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "passwords must match" do
    @user.password="barfoo"
    @user.password_confirmation="foobar"
    assert_not @user.valid?
  end
end
