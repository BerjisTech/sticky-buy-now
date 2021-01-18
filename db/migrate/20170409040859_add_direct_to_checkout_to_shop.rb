class AddDirectToCheckoutToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :direct_to_checkout, :string,   :default => true
  end
end
