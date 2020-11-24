class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :review_content
      t.string :name
      t.integer :product_id

      t.timestamps
    end
  end
end
