class AddCurrencySymbolToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :currency_symbol, :string,   :default => "$"
  end
end
