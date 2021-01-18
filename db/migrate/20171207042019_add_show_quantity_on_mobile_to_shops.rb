class AddShowQuantityOnMobileToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :show_quantity_on_mobile, :boolean, :default => true
  end
end
