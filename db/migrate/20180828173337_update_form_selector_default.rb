class UpdateFormSelectorDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :form_selector, :string, :default => "form[action^='/cart/add']:first"    
  end
end
