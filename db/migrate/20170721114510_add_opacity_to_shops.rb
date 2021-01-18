class AddOpacityToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :desktop_opacity, :real, :default => 0.95
    add_column :shops, :mobile_opacity, :real, :default => 0.95
  end
end
