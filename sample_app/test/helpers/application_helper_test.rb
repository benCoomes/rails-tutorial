class ApplicationHelperTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  test "Full title shows the base title for empty" do
    t = full_title("")
    assert_equal t, "MICROPOSTS"
  end

  test "Full title shows the base title for nil" do
    t = full_title(nil)
    assert_equal t, "MICROPOSTS"
  end

  test "Full title shows the extended title" do
    t = full_title("page title X")
    assert_equal t, "page title X | MP"
  end
end