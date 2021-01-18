class AddShopOwnerToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :shop_owner, :string
    add_column :shops, :phone, :string
    add_column :shops, :email, :string
    add_column :shops, :country_code, :string
    add_column :shops, :province_code, :string
    add_column :shops, :city, :string
  end
end
