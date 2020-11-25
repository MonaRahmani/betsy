require "test_helper"

describe Category do
  let (:category) {
    Category.new(
        category_name: "test name"
    )
  }

  describe "relations" do
    it "can access the products related to the category throug join table" do
      products = [products(:product1), products(:product2), products(:product3), products(:product4)]
      products.each do |product|
        category.products << product
      end

      category.save

      expect(category).must_respond_to :products
      expect(category.products.count).must_equal 4
      category.products.each do |product|
        expect(product).must_be_instance_of Product
      end
    end

    it "might have zero products" do
      expect(categories(:category2).products.count).must_equal 0
    end
  end

  describe "validations" do

    it "is valid for a category with all required fields" do
      expect(category.valid?).must_equal true
    end

    it "has the required fields" do
      category.save
      new_category = Category.last

      [:category_name].each do |field|
        expect(new_category).must_respond_to field
      end
    end

    it "is invalid without a name" do
      category.category_name = nil

      expect(category.valid?).must_equal false
      expect(category.errors.messages).must_include :category_name
    end

    it "cannot creat a new category with the same name" do
      category.save
      test_category_2 = Category.new(category_name: "test name")
      expect(test_category_2.valid?).must_equal false
      expect(test_category_2.errors.messages).must_include :category_name
    end
  end

end
