class BarController < WidgetappController
  include ShopifyApp::WebhookVerification
  skip_before_action :verify_request, only: [:set_cors_headers, :show, :mautic_remove_from_campaign]

  before_action :set_cors_headers
  
  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def show
    @shop = Shop.where(:shopify_domain => params[:shopify_domain], :charge_active => true).select("shopify_domain,style_bar_text_color,style_button_text_color,style_bar_background_color,style_button_background_color,pulse_button,charge_active,app_enabled,html_prices,custom_css,price_selector,original_price_selector,buy_button_selector,review_stars_selector,form_selector,variant_selector,desktop_enabled,desktop_social_share,desktop_payment_options,desktop_direct_to_cart,desktop_add_to_cart,desktop_bar_position,desktop_variants,desktop_design_template,desktop_position_offset,desktop_reveal_at,desktop_z_index,mobile_enabled,mobile_direct_to_checkout,mobile_bar_position,mobile_design_template,mobile_position_offset,mobile_reveal_at,mobile_z_index,buy_button_text,direct_to_checkout,currency_symbol,use_custom_styles,desktop_padding_left,desktop_padding_right,desktop_show_quantity,desktop_show_compare_at,mobile_show_compare_at,animation_type,mobile_opacity,desktop_opacity,show_variants_on_mobile,show_quantity_on_mobile,sold_out_text,hide_bar_after_click,added_to_cart_text")
    
    if @shop
      render json: @shop.first
    end
  end  
  
  def mautic_remove_from_campaign(campaign_id, contact_id)

    # Full control -   IT WORKS!!
    uri = URI.parse("https://email.websiteondemand.ca/api/campaigns/" + campaign_id.to_s + "/contact/remove/" + contact_id.to_s)
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Authorization'] = 'Basic c2hvcGlmeTohNVpMZkQ2OEBzOEk='
    
    response = http.request(request)
    
    puts "REMOVE FROM CAMPAIGN RESPONSE CODE: " + response.code
    
    if response.code == 200.to_s
      return true
    else
      return false
    end    
    
  end  
  
  def uninstallapp
    
    shop = Shop.find_by shopify_domain: params[:myshopify_domain]

    #Get shop owner's name
    shop_owner = params[:shop_owner]
    
    if shop_owner.index(" ")
      first_name = shop_owner.split(' ')[0]
      last_name = shop_owner.split(' ')[1]
    else
      first_name = shop_owner
      last_name = ""  
    end          
    
    # TODO: Comment this one first to follow Shopify ask review guidelines.
    # if shop.account_status != "uninstalled"
    #   UserMailer.uninstall_email(params[:email], first_name).deliver_now
    # end
    
    shop.account_status = "uninstalled"
    shop.save    
    
    #mautic - remove from campaign
    mautic_remove_from_campaign(3,shop.mautic_id)
    
  end  
  
  def delete
    #if params[:shop_domain].present?
    #  @shop = Shop.find_by shopify_domain: params[:shop_domain]
    #  if @shop.present?
    #    @shop.delete
    #  end
    #end
    render status: 200, json: {}
  end
  
  def redact_customers
    render status: 200, json: {}
  end
  
  def data_request
    if params[:shop_domain].present?
      @shop = Shop.find_by shopify_domain: params[:shop_domain]
      UserMailer.data_request(params, @shop.email).deliver_now
    end
    render status: 200, json: {}
  end   
  
end