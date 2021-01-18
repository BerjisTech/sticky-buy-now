class AddNewFieldsToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :button_animation, :string,   :default => "pulse"
    add_column :shops, :desktop_padding_left, :integer,   :default => 5
    add_column :shops, :desktop_padding_right, :integer,   :default => 5
    add_column :shops, :desktop_show_quantity, :boolean,   :default => false
    add_column :shops, :desktop_show_compare_at, :boolean,   :default => true
    add_column :shops, :desktop_show_sticky_cart, :boolean,   :default => false
    add_column :shops, :desktop_sticky_cart_position, :string,   :default => "topright"
    add_column :shops, :mobile_show_compare_at, :boolean,   :default => true
  end
end
