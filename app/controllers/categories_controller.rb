class CategoriesController < ApplicationController
  # before_action :require_login, only: [:create]
  before_action :find_category, only: [:create]


  def new
    @category = Category.new
  end

  # def show
  #   @category = Category.find_by(id: params[:id])
  #
  #   if @category.nil?
  #     head :not_found
  #     return
  # end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Successfully added #{@category.category_name} category"
      redirect_to root_path
    else
      flash[:error] = "Could not create category"
      render :new, status: :bad_request
    end
  end

    private

  def category_params
    params.require(:category).permit(:category_name)
  end

  def find_category
    @category = Category.find_by(id: params[:id])
  end

end




