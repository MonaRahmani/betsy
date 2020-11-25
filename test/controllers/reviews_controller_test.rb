require "test_helper"

describe ReviewsController do
  let(:product_id) { products(:product1).id }
  let(:review_data) {
    {
        review: {
            rating: 3,
            review_content: "A good product!",
            name: "test name",
        }
    }
  }
  describe "users(Guest)" do
    describe "create" do
      it "can write a new reveiw" do
        route = product_reviews_path(product_id)
        expect {
          post route, params: review_data
        }.must_differ 'Review.count', 1
        saved_review = Review.last
        must_redirect_to product_path(product_id)
        expect(saved_review.rating).must_equal review_data[:review][:rating]
        expect(saved_review.review_content).must_equal review_data.dig(:review, :review_content)
        expect(saved_review.name).must_equal review_data[:review][:name]
      end

      it "does not create a review if data is missing" do
        review_data[:review][:rating] = nil
        expect {
          post product_reviews_path(product_id), params: review_data
        }.must_differ "Review.count", 0
        must_respond_with :redirect
      end
    end
  end
  describe "logged in users" do
    describe "create" do

      it "can create a new reveiw for other users products" do
        perform_login(users(:user2))
        routes = product_reviews_path(product_id)

        expect {
          post routes, params: review_data
        }.must_differ 'Review.count', 1

        saved_review = Review.last
        must_redirect_to product_path(product_id)
        expect(saved_review.rating).must_equal review_data[:review][:rating]
        expect(saved_review.review_content).must_equal review_data.dig(:review, :review_content)
        expect(saved_review.name).must_equal review_data[:review][:name]
      end

      it "can not create a review for their own product" do
        perform_login(users(:user1))
        routes = product_reviews_path(product_id)
        expect {
          post routes, params: review_data
        }.wont_differ 'Review.count'

        must_respond_with :redirect
      end
    end
  end

end
