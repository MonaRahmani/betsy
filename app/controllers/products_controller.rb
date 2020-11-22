class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @products = @user.products
    else
      @products = Product.all
    end
  end

  def show
    if @product.nil?
      redirect_to products_path
      return
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = session[:user_id]
    params[:product][:categories].each do |category_id|
      if category_id != ""
        @product.categories << Category.find_by(id: category_id)
      end
    end
    # raise
    if @product.save
      flash[:success] = "#{@product.name} was successfully added!"
      redirect_to product_path(@product)
      return
    else
      # p @product.errors.messages
      flash[:error] = "Oh no! Unable to save."
      flash[:reasons] = @product.errors.messages
      render :new
      return
    end
  end

  def edit
    if @product.nil?
      flash.now[:error] = "Product doesn't exist, please select another..."
      redirect_to products_path
      return
    end
  end

  def update
    # @product.user_id = session[:user_id]
    if @product.nil?
      flash[:error] = "Product doesn't exist, please select another..."
      redirect_to products_path
      return
    elsif @product.update(product_params)
      flash[:success] = "Update successful"
      render :show
    else # save failed
      flash[:error] = "A problem occurred: Could not update #{@product.name}"
      render :edit
      return
    end
  end

  def destroy
    if @product.nil?
      flash[:error] = "Product doesn't exist, please select another..."
      redirect_to products_path
      return
    else
      @product.destroy
      flash[:success] = "Poof! Successfully relinquished the entire stock of #{@product.name}!"
      redirect_to products_path
    end
  end

  private

  def product_params
    return params.require(:product).permit(:name, :description, :price, :photo_url, :stock, :retired, :categories)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
