class AddFeeToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :monthly_fee, :money
  end
end
