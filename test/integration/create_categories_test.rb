require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test "get the new category form and create a category" do
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "movies"}}
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "movies", response.body
  end

  test "invalid category submission results in failure" do
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