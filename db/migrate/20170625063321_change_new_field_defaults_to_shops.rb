class ChangeNewFieldDefaultsToShops < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :desktop_show_quantity, :boolean,   :default => false
    change_column :shops, :desktop_show_sticky_cart, :boolean,   :default => false
  end
end
