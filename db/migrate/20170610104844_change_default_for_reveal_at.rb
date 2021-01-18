class ChangeDefaultForRevealAt < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :desktop_reveal_at,  :string, :default => "400"      
  end
end
