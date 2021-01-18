class ChangeDefaultsForRevealAt < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :desktop_reveal_at,  :string, :default => "150"      
    change_column :shops, :mobile_reveal_at,  :string, :default => "100"      
  end
end
