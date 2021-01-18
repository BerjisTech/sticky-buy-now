class ChangeRevealAtDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :desktop_reveal_at,  :string, :default => "0"        
    change_column :shops, :mobile_reveal_at,  :string, :default => "0"       
  end
end
