class AddSoldOutTextToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :sold_out_text, :string, :default => "SOLD OUT"
  end
end
