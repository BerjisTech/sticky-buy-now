class AddStyleFieldsToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :style_bar_background_color, :string
    add_column :shops, :style_button_background_color, :string
    add_column :shops, :style_bar_text_color, :string
    add_column :shops, :style_button_text_color, :string
  end
end
