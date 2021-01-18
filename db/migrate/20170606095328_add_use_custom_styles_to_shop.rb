class AddUseCustomStylesToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :use_custom_styles, :boolean, :default => false
  end
end
