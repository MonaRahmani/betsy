class ReviewsController < ApplicationController
  before_action :find_product

  def create
    if @product
      if @product.user_id == session[:user_id]
        flash[:error] = "Sorry! A Merchant can not review their own product"
      else
        @review = Review.new(new_review_params)
        @review.product_id = @product.id

        if @review.save
          flash[:success] = "Successful!"
        else
          flash[:error] = "Something happend! you can not review"
        end
      end
      redirect_to product_path(@product.id)
    end
  end

  private

  def find_product
    @product = Product.find_by(id: params.require(:product_id))
  end

  def new_review_params
    params.require(:review).permit(:rating, :review_content, :name)
  end
end