class UpdateReviewStarDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :review_stars_selector, :string,   :default => ".yotpo-stars:first, .spr-badge-starrating:first, .spr-starrating:first, .jdgm-prev-badge__stars:first"    
  end
end
