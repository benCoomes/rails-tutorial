class RootTest < ActionDispatch::IntegrationTest
  test "root should be home" do
    # todo: better way to share this logic with staic pages tests,
    # without moving this test to that file?
    get root_url
    assert_response :success
    assert_select "title", "MICROPOSTS"
  end
end