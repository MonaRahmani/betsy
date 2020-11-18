class CategoriesController < ApplicationController

  def new
    @category = category.new
  end

  def create
    @category = category.create(category_params)
    if @category.id?
      flash[:success] = "Successfully added #{@category.category_name} category"
      redirect_to user_path(session[:user_id])
    else
      flash[:result_text] = "Could not create category"
    end

    def category_params
      params.require(:category).permit(:category_name)
    end

  end
end



