class AddChargeActiveToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :charge_active, :string,   :default => false
  end
end
