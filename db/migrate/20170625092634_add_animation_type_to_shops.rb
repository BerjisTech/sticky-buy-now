class AddAnimationTypeToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :animation_type, :string,   :default => "shake"
  end
end