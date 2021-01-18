class AddHideBarAfterClickToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :hide_bar_after_click, :boolean, :default => false
  end
end
