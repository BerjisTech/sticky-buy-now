# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_28_173337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "app_enabled", default: true
    t.boolean "html_prices", default: false
    t.text "custom_css"
    t.string "price_selector", default: "span[itemprop=price]:first"
    t.string "original_price_selector", default: "span.was_price:first, span.compare-price:first, s#ComparePrice:first, .product-single__price--compare-at"
    t.string "buy_button_selector", default: "form[action^='/cart/add']:first [type=submit]:visible:first"
    t.string "review_stars_selector", default: ".yotpo-stars:first, .spr-badge-starrating:first, .spr-starrating:first, .jdgm-prev-badge__stars:first"
    t.string "form_selector", default: "form[action^='/cart/add']:first"
    t.string "variant_selector", default: "form[action^='/cart/add']:first select:visible, .radio-wrapper fieldset"
    t.boolean "desktop_enabled", default: true
    t.boolean "desktop_social_share", default: false
    t.boolean "desktop_payment_options", default: false
    t.boolean "desktop_direct_to_cart", default: true
    t.boolean "desktop_add_to_cart", default: false
    t.string "desktop_bar_position", default: "top"
    t.boolean "desktop_variants", default: true
    t.string "desktop_design_template", default: "responsive"
    t.integer "desktop_position_offset", default: 0
    t.string "desktop_reveal_at", default: "150"
    t.integer "desktop_z_index"
    t.boolean "mobile_enabled", default: true
    t.boolean "mobile_direct_to_checkout", default: true
    t.string "mobile_bar_position", default: "bottom"
    t.string "mobile_design_template", default: "mobile"
    t.integer "mobile_position_offset", default: 0
    t.string "mobile_reveal_at", default: "100"
    t.integer "mobile_z_index"
    t.string "buy_button_text", default: "BUY NOW"
    t.string "direct_to_checkout", default: "t"
    t.string "charge_active", default: "f"
    t.string "pulse_button", default: "f"
    t.string "style_bar_background_color"
    t.string "style_button_background_color"
    t.string "style_bar_text_color"
    t.string "style_button_text_color"
    t.string "currency_symbol", default: "$"
    t.string "account_status"
    t.boolean "use_custom_styles", default: false
    t.string "shop_owner"
    t.string "phone"
    t.string "email"
    t.string "country_code"
    t.string "province_code"
    t.string "city"
    t.integer "mautic_id"
    t.string "button_animation", default: "pulse"
    t.integer "desktop_padding_left", default: 5
    t.integer "desktop_padding_right", default: 5
    t.boolean "desktop_show_quantity", default: false
    t.boolean "desktop_show_compare_at", default: true
    t.boolean "desktop_show_sticky_cart", default: false
    t.string "desktop_sticky_cart_position", default: "topright"
    t.boolean "mobile_show_compare_at", default: true
    t.string "animation_type", default: "shake"
    t.string "monthly_fee"
    t.float "desktop_opacity", default: 0.95
    t.float "mobile_opacity", default: 0.95
    t.boolean "show_variants_on_mobile", default: true
    t.boolean "show_quantity_on_mobile", default: true
    t.string "sold_out_text", default: "Sold Out"
    t.boolean "hide_bar_after_click", default: false
    t.string "added_to_cart_text", default: "Added to Cart"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
