class AddAddedToCartTextToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :added_to_cart_text, :string, :default => "Added to Cart"
  end
end
