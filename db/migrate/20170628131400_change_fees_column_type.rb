class ChangeFeesColumnType < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :monthly_fee,  :string
  end
end
