class AddAccountStatusToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :account_status, :string
  end
end
