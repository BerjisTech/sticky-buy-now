class AddPulseButtonToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :pulse_button, :string,   :default => false
  end
end
