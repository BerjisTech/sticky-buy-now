class AddFieldsToShopTable < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :app_enabled, :boolean,   :default => true
    add_column :shops, :html_prices, :boolean,   :default => false
    add_column :shops, :custom_css, :text
    add_column :shops, :price_selector, :string,   :default => "span[itemprop=price]:first"
    add_column :shops, :original_price_selector, :string,   :default => "span.was_price:first, span.compare-price:first, s#ComparePrice:first, .product-single__price--compare-at"
    add_column :shops, :buy_button_selector, :string,   :default => "form[action^='/cart/add']:first [type=submit]:visible:first"
    add_column :shops, :review_stars_selector, :string,   :default => ".yotpo-stars:first, .spr-badge-starrating:first, .spr-starrating:first"
    add_column :shops, :form_selector, :string,   :default => "form[action^='/cart/add']"
    add_column :shops, :variant_selector, :string,   :default => "form[action^='/cart/add']:first select:visible, .radio-wrapper fieldset"
    add_column :shops, :desktop_enabled, :boolean,   :default => true
    add_column :shops, :desktop_social_share, :boolean,   :default => false
    add_column :shops, :desktop_payment_options, :boolean,   :default => false
    add_column :shops, :desktop_direct_to_cart, :boolean,   :default => true
    add_column :shops, :desktop_add_to_cart, :boolean,   :default => false
    add_column :shops, :desktop_bar_position, :string,   :default => "top"
    add_column :shops, :desktop_variants, :boolean,   :default => true
    add_column :shops, :desktop_design_template, :string,   :default => "responsive"
    add_column :shops, :desktop_position_offset, :integer,   :default => 0
    add_column :shops, :desktop_reveal_at, :integer
    add_column :shops, :desktop_z_index, :integer
    add_column :shops, :mobile_enabled, :boolean,   :default => true
    add_column :shops, :mobile_direct_to_checkout, :boolean,   :default => true
    add_column :shops, :mobile_bar_position, :string,   :default => "bottom"
    add_column :shops, :mobile_design_template, :string,   :default => "mobile"
    add_column :shops, :mobile_position_offset, :integer,   :default => 0
    add_column :shops, :mobile_reveal_at, :integer
    add_column :shops, :mobile_z_index, :integer
  end
end