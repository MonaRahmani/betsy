class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @products = @user.products
    else
      @products = Product.all
    end

    if params[:category_id].nil?
      @products = Product.all
    else
      @products = Category.find_by(id: params[:category_id]).products
      @category = Category.find_by(id: params[:category_id])

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
    # if params[:product][:retired]
    #   @product.retired = true
    # else
    #   @product.retired = false
    # end
    # raise
    if @product.save
      flash[:success] = "#{@product.name} added to inventory."
      redirect_to user_path(session[:user_id])
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

  def update # updated of check box and category field isnt working
    if @product.nil?
      flash[:error] = "Product doesn't exist, please select another..."
      redirect_to products_path
      return
    elsif @product.update(product_params)
      @product.user_id = session[:user_id]
      params[:product][:categories].each do |category_id| # update category
        if category_id != ""
          @product.categories << Category.find_by(id: category_id)
        end
      end
      # if params[:product][:retired] == true # update retired
      #   @product.retired = true
      # else
      #   @product.retired = false
      # end
      flash[:success] = "Updated #{@product.name}"
      redirect_to user_path(session[:user_id])
      return
    else # save failed
      flash[:error] = "A problem occurred: Could not update #{@product.name}"
      render :edit
      return
    end
  end

  def destroy
    if @product.nil?
      flash[:error] = "Product doesn't exist, please select another..."
      redirect_to user_path(session[:user_id])
      return
    else
      @product.destroy
      flash[:success] = "Poof! Successfully relinquished the entire stock of #{@product.name}!"
      redirect_to user_path(session[:user_id])
    end
  end

  private

  def product_params
    return params.require(:product).permit(:name, :description, :price, :photo_url, :stock, :retired, :category_id)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
