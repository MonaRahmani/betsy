class Category < ApplicationRecord
  has_and_belongs_to_many :products

  def self.products_by_category(category_name)
    product_list = Category.find_by(name: category_name).products

    return product_list.includes(:user).order("user.username")
  end

end
