require "test_helper"

class CategoriesFlowTest < ActionDispatch::IntegrationTest
  test "category creation and display" do
    get categories_url
    assert_response :success

    get new_category_url
    assert_response :success

    # Create valid category
    assert_difference "Category.count", 1 do
      post categories_url, params: { category: { name: "Tech" } }
    end
    follow_redirect!
    assert_match "Tech", response.body

    # Create invalid category
    assert_no_difference "Category.count" do
      post categories_url, params: { category: { name: "" } }
    end
    assert_match "The following errors prevented the Category from being saved", response.body
  end
end
