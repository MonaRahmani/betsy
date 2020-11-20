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
    @product = Product.new(products_param)

    if @product.save
      flash[:success] = "#{@product.name} was successfully added!"
      redirect_to product_path(@product.id)
      return
    else
      flash.now[:error] = "Oh no! Unable to save."
      render :new
      return
    end
  end

  def edit
    if @product.nil?
      flash.now[:error] = "Product doesn't exist, please select another... (nil)"
      redirect_to products_path
      return
    end
  end

  def update
    if @product.nil?
      flash.now[:error] = "Product doesn't exist, please select another... (nil)"
      redirect_to products_path
      return
    elsif @product.update(product_params)
      flash.now[:success] = "Update complete!"
      redirect_to product_path(@product)
    else # save failed
      flash.now[:error] = "A problem occurred: Could not update #{@product.name}"
      render :edit
      return
    end
  end

  def destroy
    if @product.nil?
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
