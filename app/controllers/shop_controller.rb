# frozen_string_literal: true

class ShopController < ShopifyApp::AuthenticatedController
  include ShopifyApp::EmbeddedApp
  before_action :set_cors_headers

  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def mautic_get(model, id)
    url = URI.parse('https://email.websiteondemand.ca/api/' + model + '/' + id)
    req = Net::HTTP::Get.new(url.to_s)
    req['Authorization'] = 'Basic c2hvcGlmeTohNVpMZkQ2OEBzOEk='
    res = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
      http.request(req)
    end

    hash = JSON.parse res.body

    if res.code == 200.to_s
      hash['contact']
    else
      false
    end
  end

  def mautic_new(model, data)
    # Full control - IT WORKS!!
    uri = URI.parse('https://email.websiteondemand.ca/api/' + model + '/new')

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Authorization'] = 'Basic c2hvcGlmeTohNVpMZkQ2OEBzOEk='
    request.set_form_data(data)

    response = http.request(request)
    response.body

    return unless [200..201].include?(response.code.to_i)

    hash = JSON.parse response.body

    puts 'CREATE CONTACT RESPONSE CODE: ' + response.code
    puts hash['contact']['id']

    hash['contact']['id']
  end

  def mautic_add_to_segment(segment_id, contact_id)
    # Full control - IT WORKS!!
    uri = URI.parse('https://email.websiteondemand.ca/api/segments/' + segment_id.to_s + '/contact/add/' + contact_id.to_s)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Authorization'] = 'Basic c2hvcGlmeTohNVpMZkQ2OEBzOEk='

    response = http.request(request)

    puts 'ADD TO SEGMENT RESPONSE CODE: ' + response.code

    response.code == 200.to_s
  end

  def break_name(shop_owner)
    full_name = []

    if shop_owner.index(' ')
      full_name[0] = shop_owner.split(' ')[0]
      full_name[1] = shop_owner.split(' ')[1]
    else
      full_name[0] = shop_owner
      full_name[1] = ''
    end

    full_name
  end

  def installapp(_shop)
    # install web hook to send email on uninstall
    webhooks = ShopifyAPI::Webhook.create(topic: 'app/uninstalled', address: ENV['APP_URL'] + '/uninstallapp', format: 'json')
    webhooks.save
  end

  def process_charge_id(charge_id)
    puts '===============PROCESSING CHARGE'
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(charge_id)
    if recurring_application_charge.status == 'accepted'
      puts '===============CHARGE ACCEPTED'
      recurring_application_charge.activate
      @shop = Shop.find_by shopify_domain: ShopifyAPI::Shop.current.myshopify_domain

      # store store details
      @shop.shop_owner = ShopifyAPI::Shop.current.shop_owner
      full_name = break_name(@shop.shop_owner)
      @shop.phone = ShopifyAPI::Shop.current.phone
      @shop.email = ShopifyAPI::Shop.current.email
      @shop.country_code = ShopifyAPI::Shop.current.country_code
      @shop.province_code = ShopifyAPI::Shop.current.province_code
      @shop.city = ShopifyAPI::Shop.current.city

      # add or merge details on mautic
      mautic_data = { 'firstname' => full_name[0],
                      'lastname' => full_name[1],
                      'phone' => @shop.phone,
                      'email' => @shop.email,
                      'website' => @shop.shopify_domain,
                      'city' => @shop.city }

      mautic_id = mautic_new('contacts', mautic_data)

      puts 'MAUTIC ID: ' + mautic_id.to_s

      if mautic_id != false
        @shop.mautic_id = mautic_id
        mautic_add_to_segment(7, mautic_id)
      end

      # TODO: Comment this one first to follow Shopify ask review guidelines.
      UserMailer.install_email('support@websiteondemand.ca', @shop.shopify_domain).deliver_now

      @shop.charge_active = true
      @shop.account_status = 'installed'
      @shop.monthly_fee = 3.95 * 0.8
      @shop.save
      installapp(@shop)
    elsif recurring_application_charge.status == 'active'
      @status = 'active'
    else
      @status = recurring_application_charge.status
      render 'inactive'
    end
  end

  def create_charge(test_flag, plan_fee, shop)
    trial_length = 7

    trial_length = 37 if shop.account_status == 'uninstalled'

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
      name: 'Sticky Buy Now Button',
      price: plan_fee,
      return_url: ENV['APP_URL'],
      test: test_flag,
      trial_days: trial_length
    )

    if recurring_application_charge.save && @status != 'declined'
      @confirm_url = recurring_application_charge.confirmation_url
      @status = 'redirecting'
      render 'redirect'
    end
  end

  def edit
    if request.params['charge_id']
      process_charge_id(request.params['charge_id'])
    else
      puts '===============NO CHARGE ID FOUND'
    end

    shopify_shop = ShopifyAPI::Shop.current

    # if they already have an account (e.g., signed up while it was free), set account exists var
    myshopify_domain = shopify_shop.myshopify_domain
    account_exists = false

    if Shop.exists?(shopify_domain: myshopify_domain, account_status: 'installed')
      account_exists = true
      puts '===============ACCOUNT EXISTS'
    else
      puts '===============ACCOUNT DOES NOT EXIST'
    end

    # search for charge
    # if charge not found, send to recurring charge controller, create function
    if ShopifyAPI::RecurringApplicationCharge.current || account_exists
      puts '===============RENDERING OUTPUT'

      scriptTags = ShopifyAPI::ScriptTag.all
      scriptTags.each(&:destroy)
      s = ShopifyAPI::ScriptTag.create(event: 'onload', src: ENV['APP_URL'] + '/assets/sticky-buy-now-button.js')

      @shop = Shop.find_by shopify_domain: myshopify_domain

      @shop.currency_symbol = ShopifyAPI::Shop.current.money_format
      @shop.save

      unless params['message'].blank?

        puts 'SENDING HELP EMAIL'

        message = 'Shop ID: ' + params['shop_id'] + '<br />' + 'Email: ' + params['email'] + '<br />' + 'Shopify Domain: ' + params['shopify_domain'] + '<br />' + 'Shopify App: ' + params['shopify_app'] + '<br />' + 'Owner Name: ' + params['owner_name'] + '<br /><br />' + 'Message: ' + params['message']

        UserMailer.support_request(message, params['email']).deliver_now

        @flash = 'Thank You! Your support request has been received. We respond to all requests within one business day Monday to Friday (Bangkok Time.)'

      end

    else

      @shop = Shop.find_by shopify_domain: myshopify_domain

      puts '===============CREATING CHARGE'

      free_shops = ['websiteondemand.myshopify.com', 'solid-tool-chests-and-cabinets.myshopify.com', 'crazyappsfactory.myshopify.com', 'mamaybebeargentina.myshopify.com', 'crazy-apps-house.myshopify.com', 'wholesale-demo-store.myshopify.com', 'preorder-tagging.myshopify.com', 'first-solid-store.myshopify.com']
      discount_shops = ['risegear-canada.myshopify.com', 'risegear-europe.myshopify.com']

      monthly_fee = if discount_shops.include? myshopify_domain
                      3.71
                    else
                      3.95
                    end

      if free_shops.include? myshopify_domain
        create_charge(true, monthly_fee, @shop)
      else
        create_charge(false, monthly_fee, @shop)
      end
    end
  end

  def update
    @shop = Shop.find(params[:id])
    myshopify_domain = ShopifyAPI::Shop.current.myshopify_domain
    if myshopify_domain == @shop.shopify_domain && @shop.update_attributes(shop_params)
      flash[:success] = 'Settings updated'
      puts 'VALID - UPDATING'
      redirect_to root_path
    else
      flash[:error] = 'Validation errors'
      render 'edit'
    end
  end

  private

  def shop_params
    params.require(:shop).permit!
  end
end
