require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(username: "allie", email: "allie@example.com", password: "password", admin: true)
  end

  test "get the new category form and create a category" do
    sign_in_as(@admin_user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "diy"}}
    end
    # assert_template 'categories/index'
    # assert_match "something new", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_as(@admin_user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: ""}}
    end
    assert_template 'categories/new'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

  test "should redirect if non admin user hits create category page" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: "sports"}}
    end
    assert_redirected_to categories_path
  end
end