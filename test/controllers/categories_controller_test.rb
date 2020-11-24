require "test_helper"

describe CategoriesController do
  describe "new" do
    it "can get the new category path" do
      get new_category_path
      must_respond_with :success
    end
  end

  describe "create" do
    let(:category_hash) {
      {
          category: {
              category_name: "test",
          }
      }
    }
    it "can create a category" do
      expect {
        post categories_path, params: category_hash
      }.must_differ 'Category.count', 1

      must_respond_with :redirect
      must_redirect_to root_path
      expect(Category.last.category_name).must_equal category_hash[:category][:category_name]
    end

    it "will not create a category with invalid params" do
      category_hash[:category][:category_name] = nil

      expect {
        post categories_path, params: category_hash
      }.wont_change "Category.count", 0

      must_respond_with :bad_request
    end
  end
end
