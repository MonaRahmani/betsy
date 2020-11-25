class Order < ApplicationRecord
  has_many :order_items

  validates :credit_card_name, presence: { message: "Name required" }, :on => :update
  validates :credit_card_num, length: { is: 16, message: "Enter valid 16-digit credit card number" }, :on => :update # doesn't check for digits only
  validates :cvv_num, length: { is: 3, message: "Enter valid 3-digit cvv" }, :on => :update # doesn't check for digits only
  validates :cc_exp_month, numericality: { in: 1..12, message: "Enter valid expiration month (1-12)" }, :on => :update # date validation could be improved with time
  validates :cc_exp_year, numericality: { in: 2020..2030, message: "Enter valid expiration year (2020-2030)" }, :on => :update
  validates :email, email: true, :on => :update
  validates :street_address, presence: { message: "Street address required" }, :on => :update
  validates :city, presence: { message: "City is required" }, :on => :update
  validates :state, presence: { message: "State is required" }, :on => :update
  validates :zip_code, length: { is: 5, message: "Enter valid 5-digit zip code" }, :on => :update# doesn't check for digits only


  # after_initialize :init
  #
  # def init
  #   self.status ||= "paid" # will set the default value only if it's nil
  # end

  def add_product(product, quantity)
    current_item = OrderItem.find_by(product_id: product.id, order_id: self.id )

    if current_item
      current_item.quantity = quantity
      current_item.save
    else
      new_item = OrderItem.new(product_id: product.id, quantity: quantity, order_id: self.id)
      new_item.save
    end
  end

  def display_items
    current_items = {}
    self.order_items.each do |item|
      product = Product.find_by(id: item["product_id"])
      current_items[product] = item["quantity"]
    end
    return current_items
  end


  def total
    total = 0
    self.order_items.each do |item|
      total += item.order_item_subtotal
    end
    return total
  end

  def update_order_status
    if self.status == 'pending'
      self.update_attribute(:status, 'paid')
    end
  end

  def update_stock
    self.order_items.each do |item|
      matching_product = item.product
      matching_product.stock -= item.quantity
      matching_product.update_attribute(:stock, item.product.stock)
    end
  end
end

