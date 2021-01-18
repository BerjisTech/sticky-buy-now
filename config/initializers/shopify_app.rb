ShopifyApp.configure do |config|
  config.application_name = "Sticky Buy Now Button"
  config.api_key = ENV['SHOPIFY_API_KEY']
  config.secret = ENV['SHOPIFY_API_KEY_SECRET']
  config.scope = "read_products, read_script_tags, write_script_tags"
  config.embedded_app = true
  config.scripttags = [
  {event:'onload', src: ENV['JS_SCRIPT_URL'], display_scope: 'all'}
  ]
  config.session_repository = Shop
  config.api_version = '2020-01'
end
