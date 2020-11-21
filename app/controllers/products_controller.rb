class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @products = @user.products
      @orderitems = OrderItem.find_by()
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
      flash.now[:error] = "Oh no! Your product already exists."
      render :new
      return
    end
  end

  def edit
    if @product.nil?
      redirect_to products_path
      return
    end
  end

  def update
    if @product.nil?
      redirect_to products_path
     return
    else
      @product.update(products_param)
      redirect_to products_path
    end
  end

  def destroy
    if @product.nil?
      redirect_to products_path
      return
    else
      @product.destroy
      flash[:success] = "Successfully deleted"
      redirect_to products_path
    end
  end

  private

  def products_param
    return params.require(:product).permit(:id, :name, :description, :price, :photo_url, :stock, :retired)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
