require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
 def setup
    @user = users(:michael)
  end
  test "non-logged-in users" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
  end

  test "logged-in" do
    get root_path
    assert_template 'static_pages/home'
    log_in_as(@user)
    follow_redirect!
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")

  end
end