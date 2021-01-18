# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shop.create!(shopify_domain: "websiteondemand.myshopify.com",
shopify_token: "abc123",
app_enabled: "true",
html_prices: "true",
custom_css: "",
price_selector: "",
original_price_selector: "",
buy_button_selector: "",
review_stars_selector: "",
form_selector: "",
variant_selector: "",
desktop_enabled: "true",
desktop_social_share: "false",
desktop_payment_options: "false",
desktop_direct_to_cart: "true",
desktop_add_to_cart: "true",
desktop_bar_position: "top",
desktop_variants: "true",
desktop_design_template: "",
desktop_position_offset: "",
desktop_reveal_at: "",
desktop_z_index: "",
mobile_enabled: "true",
mobile_direct_to_checkout: "true",
mobile_bar_position: "bottom",
mobile_design_template: "",
mobile_position_offset: "",
mobile_reveal_at: "",
mobile_z_index: "")