class AddMauticIdToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :mautic_id, :integer
  end
end
