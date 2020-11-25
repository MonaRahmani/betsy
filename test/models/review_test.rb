require "test_helper"

describe Review do
  describe "relations" do

    it "has a product" do
      test_review = review(:review1)
      expect(test_review).must_respond_to :product
      test_product = products(:product1)
      test_review.product_id = test_product.id
      expect(test_review.product).must_be_kind_of Product
    end
    describe "validations" do
      let(:review4) {
        Review.new(
            rating: 4,
            review_content: "good",
            name: "test",
            product: products(:product1)
        )
      }
      it "is valid when all required fields completed" do
        expect(review4.valid?).must_equal true
      end

      it "has the required fields" do
        review4.save
        new_test_review = Review.last

        [:rating, :review_content, :name].each do |field|
          expect(new_test_review).must_respond_to field
        end
      end

      it "is not valid if rating is missing" do
        review4.rating = nil

        expect(review4.valid?).must_equal false
        expect(review4.errors.messages).must_include :rating
      end

      it "is not valid if name is missing" do
        review4.name = nil

        expect(review4.valid?).must_equal false
        expect(review4.errors.messages).must_include :name
      end

      it "cannot review with a rating other than 1 to 5" do
        review4.rating = 6

        expect(review4.valid?).must_equal false
        expect(review4.errors.messages).must_include :rating
      end

      it "cannot review with a non integer rating" do
        review4.rating = 3.4

        expect(review4.valid?).must_equal false
        expect(review4.errors.messages).must_include :rating
      end

    end
  end
end
