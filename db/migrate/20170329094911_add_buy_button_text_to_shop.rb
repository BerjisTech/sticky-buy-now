class AddBuyButtonTextToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :buy_button_text, :string, :default => "BUY NOW"
  end
end
