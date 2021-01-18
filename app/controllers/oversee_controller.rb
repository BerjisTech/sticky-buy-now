class OverseeController < AdminapplicationController
  before_action :logged_in_user


  def net_income_chart
    
#    Get first paid sign-up, get created date
#    start date = created date
#    labelArray = []
#    statArray = []
#    graphArray = []
#    get last paid signup, get that one's created date    
    start_date = Shop.all.where("monthly_fee IS NOT NULL").order("id ASC").limit(1).first.created_at.to_s.at(0..9)
    end_date = Shop.all.where("monthly_fee IS NOT NULL").order("id DESC").limit(1).first.created_at.to_s.at(0..9)
    graph_array = []
    label_array = []
    stat_array = []
    stat_array_2 = []
    revenue_sum = 0.00
    daily_net_revenue = 0.00
    daily_install_revenue = 0.00
    daily_uninstall_revenue = 0.00
    counter = 0

    # while start date < last paid signup{
    while start_date <= end_date
    
      daily_net_revenue = 0.00
      daily_install_revenue = 0.00
      daily_uninstall_revenue = 0.00      
      
      # labelArray += start date
      label_array[counter] = start_date
      
      # period signups += count signups on that (start date + x)
      # period uninstalls += count the number of those signups that uninstalled        
      rev_shops = Shop.all.where("monthly_fee IS NOT NULL").where("created_at::text LIKE '%" + start_date +  "%'")
      
      rev_shops.each do |shop|
        daily_install_revenue += shop.monthly_fee.to_f
      end
      
      lost_rev_shops = Shop.all.where("monthly_fee IS NOT NULL").where("account_status = 'uninstalled'").where("updated_at::text LIKE '%" + start_date +  "%'")      
      
      lost_rev_shops.each do |shop|
        daily_uninstall_revenue -= shop.monthly_fee.to_f
      end      
      
      daily_net_revenue = daily_install_revenue + daily_uninstall_revenue
      
      stat_array[counter] = daily_net_revenue
      if counter > 0
        stat_array_2[counter] = stat_array_2[counter-1] + daily_net_revenue
      else
        stat_array_2[counter] = daily_net_revenue
      end

      # start date += daysInPeriod
      start_date = DateTime.parse(start_date) + 1.days
      start_date = start_date.strftime('%Y-%m-%d')
      start_date = start_date.to_s
      counter += 1
    end

    graph_array[0] = label_array
    graph_array[1] = stat_array
    graph_array[2] = stat_array_2
    
    puts "GRAPHARRAY: " + graph_array.inspect
    
    return graph_array
  end  
  
  def install_uninstall_table
    
#    Get first paid sign-up, get created date
#    start date = created date
#    labelArray = []
#    statArray = []
#    graphArray = []
#    get last paid signup, get that one's created date    
    start_date = Shop.all.where("monthly_fee IS NOT NULL").order("id ASC").limit(1).first.created_at.to_s.at(0..9)
    end_date = Shop.all.where("monthly_fee IS NOT NULL").order("id DESC").limit(1).first.created_at.to_s.at(0..9)
    graph_array = []
    label_array = []
    stat_array = []
    stat_array_2 = []
    counter = 0

    # while start date < last paid signup{
    while start_date <= end_date

      # labelArray += start date
      label_array[counter] = start_date
      installs = ""
      uninstalls = ""
      
      # period signups += count signups on that (start date + x)
      # period uninstalls += count the number of those signups that uninstalled        
      rev_shops = Shop.all.where("monthly_fee IS NOT NULL").where("created_at::text LIKE '%" + start_date +  "%'")
      
      rev_shops.each do |shop|
        if shop.shop_owner == nil
          shop.shop_owner = ""
        end
        if shop.email == nil
          shop.email = ""
        end
        if shop.phone == nil
          shop.phone = ""
        end             
        installs = installs + shop.shopify_domain + "<br />(" + shop.shop_owner + " - " + shop.email + " - " + shop.phone + ")<br /><br />"
      end
      
      stat_array[counter] = installs
      
      lost_rev_shops = Shop.all.where("monthly_fee IS NOT NULL").where("account_status = 'uninstalled'").where("updated_at::text LIKE '%" + start_date +  "%'")      
      
      lost_rev_shops.each do |shop|
        if shop.shop_owner == nil
          shop.shop_owner = ""
        end
        if shop.email == nil
          shop.email = ""
        end
        if shop.phone == nil
          shop.phone = ""
        end  
        if shop.country_code == nil
          shop.country_code = ""
        end            
        uninstalls = uninstalls + shop.shopify_domain + "<br />(" + shop.shop_owner + " - " + shop.email + " - " + shop.phone + " - " + shop.country_code + ")<br /><br />"
      end   
      
      stat_array_2[counter] = uninstalls

      # start date += daysInPeriod
      start_date = DateTime.parse(start_date) + 1.days
      start_date = start_date.strftime('%Y-%m-%d')
      start_date = start_date.to_s
      counter += 1
    end

    graph_array[0] = label_array
    graph_array[1] = stat_array
    graph_array[2] = stat_array_2

    return graph_array
  end        
  
  def cohort_chart(days_in_period)
    
#    Get first paid sign-up, get created date
#    start date = created date
#    labelArray = []
#    statArray = []
#    graphArray = []
#    get last paid signup, get that one's created date    
    start_date = Shop.all.where("monthly_fee IS NOT NULL").order("id ASC").limit(1).first.created_at.to_s.at(0..9)
    end_date = Shop.all.where("monthly_fee IS NOT NULL").order("id DESC").limit(1).first.created_at.to_s.at(0..9)
    label_array = []
    stat_array = []
    graph_array = []
    install_array = []
    uninstall_array = []
    counter = 0

    # while start date < last paid signup{
    while start_date <= end_date
    
      period_signups = 0
      period_uninstalls = 0  
      
      # labelArray += start date
      label_array[counter] = start_date
      
      # for (x=0;x<daysInPeriod;x++){
      for current_iteration_number in 0..(days_in_period-1) do
        #puts "current iteration number: " + current_iteration_number.to_s        
        loop_date = DateTime.parse(start_date) + current_iteration_number.days
        loop_date = loop_date.strftime('%Y-%m-%d')
        loop_date = loop_date.to_s      
        
        # period signups += count signups on that (start date + x)
        # period uninstalls += count the number of those signups that uninstalled        
        period_signups += Shop.all.where("monthly_fee IS NOT NULL").where("created_at::text LIKE '%" + loop_date +  "%'").count
        period_uninstalls += Shop.all.where("monthly_fee IS NOT NULL").where("created_at::text LIKE '%" + loop_date +  "%'").where("account_status = 'uninstalled'").count
        
        #puts "RECORDING FOR " + loop_date + " there was " + period_signups.to_s + ":" + period_uninstalls.to_s
        
      end
      
      install_array[counter] = period_signups
      uninstall_array[counter] = period_uninstalls

      # start date += daysInPeriod
      start_date = DateTime.parse(start_date) + days_in_period.days
      start_date = start_date.strftime('%Y-%m-%d')
      start_date = start_date.to_s
      counter += 1
    end

    stat_array[0] = install_array
    stat_array[1] = uninstall_array

    graph_array[0] = label_array
    graph_array[1] = stat_array
    
    return graph_array
  end  
  
  def install_chart(days_in_period)
    
#    Get first paid sign-up, get created date
#    start date = created date
#    labelArray = []
#    statArray = []
#    graphArray = []
#    get last paid signup, get that one's created date    
    start_date = Shop.all.where("monthly_fee IS NOT NULL").order("id ASC").limit(1).first.created_at.to_s.at(0..9)
    end_date = Shop.all.where("monthly_fee IS NOT NULL").order("id DESC").limit(1).first.created_at.to_s.at(0..9)
    label_array = []
    stat_array = []
    graph_array = []
    install_array = []
    uninstall_array = []
    counter = 0

    # while start date < last paid signup{
    while start_date <= end_date
    
      period_signups = 0
      period_uninstalls = 0  
      
      # labelArray += start date
      label_array[counter] = start_date
      
      # for (x=0;x<daysInPeriod;x++){
      for current_iteration_number in 0..(days_in_period-1) do
        #puts "current iteration number: " + current_iteration_number.to_s        
        loop_date = DateTime.parse(start_date) + current_iteration_number.days
        loop_date = loop_date.strftime('%Y-%m-%d')
        loop_date = loop_date.to_s      
        
        # period signups += count signups on that (start date + x)
        # period uninstalls += count the number of those signups that uninstalled        
        period_signups += Shop.all.where("monthly_fee IS NOT NULL").where("created_at::text LIKE '%" + loop_date +  "%'").count
        period_uninstalls += Shop.all.where("monthly_fee IS NOT NULL").where("updated_at::text LIKE '%" + loop_date +  "%'").where("account_status = 'uninstalled'").count
        
        #puts "RECORDING FOR " + loop_date + " there was " + period_signups.to_s + ":" + period_uninstalls.to_s
        
      end
      
      install_array[counter] = period_signups
      uninstall_array[counter] = period_uninstalls

      # start date += daysInPeriod
      start_date = DateTime.parse(start_date) + days_in_period.days
      start_date = start_date.strftime('%Y-%m-%d')
      start_date = start_date.to_s
      counter += 1
    end

    stat_array[0] = install_array
    stat_array[1] = uninstall_array

    graph_array[0] = label_array
    graph_array[1] = stat_array
    
    return graph_array
  end
  
  def churn_chart(days_in_period)
    
#    Get first paid sign-up, get created date
#    start date = created date
#    labelArray = []
#    statArray = []
#    graphArray = []
#    get last paid signup, get that one's created date    
    start_date = Shop.all.where("monthly_fee IS NOT NULL").order("id ASC").limit(1).first.created_at.to_s.at(0..9)
    end_date = Shop.all.where("monthly_fee IS NOT NULL").order("id DESC").limit(1).first.created_at.to_s.at(0..9)
    label_array = []
    stat_array = []
    graph_array = []
    counter = 0

    # while start date < last paid signup{
    while start_date <= end_date
    
      period_signups = 0
      period_uninstalls = 0  
      
      # labelArray += start date
      label_array[counter] = start_date
      
      # for (x=0;x<daysInPeriod;x++){
      for current_iteration_number in 0..(days_in_period-1) do
        
        loop_date = DateTime.parse(start_date) + current_iteration_number.days
        loop_date = loop_date.strftime('%Y-%m-%d')
        loop_date = loop_date.to_s      
        
        # period signups += count signups on that (start date + x)
        # period uninstalls += count the number of those signups that uninstalled        
        period_signups += Shop.all.where("monthly_fee IS NOT NULL").where("created_at::text LIKE '%" + loop_date +  "%'").count
        period_uninstalls += Shop.all.where("monthly_fee IS NOT NULL").where("updated_at::text LIKE '%" + loop_date +  "%'").where("account_status = 'uninstalled'").count
      end
      
      if period_signups == 0
        uninstall_rate = 0
      else
        uninstall_rate = (period_uninstalls.to_f / period_signups.to_f) * 100
      end
      
      stat_array[counter] = uninstall_rate

      # start date += daysInPeriod
      start_date = DateTime.parse(start_date) + days_in_period.days
      start_date = start_date.strftime('%Y-%m-%d')
      start_date = start_date.to_s
      counter += 1
    end

    graph_array[0] = label_array
    graph_array[1] = stat_array
    
    return graph_array
  end    

  def login_as
    
    shop = Shop.find(params[:id])
    
    session = ShopifyAPI::Session.new(domain: shop.shopify_domain, token: shop.shopify_token, api_version: '2020-01')
    ShopifyAPI::Base.activate_session(session)
    
    redirect_to root_path

  end
  
  def install_uninstall_report
    
    @install_uninstall_data = install_uninstall_table
    
    render 'install_uninstall_report'
  end    
  
  
  def other_reports
  
    @churn_array = churn_chart(3)
    @install_array = install_chart(1) 
    @cohort_array = cohort_chart(1) 
    @weekly_install_array = install_chart(7)    
    @net_income_array = net_income_chart      
  
  end
  
  def index
    num_of_pages = Shop.count.to_f / 250.to_f
    
    counter=1
    
    @shops = Shop.where(account_status: 'installed').limit(250).order("id ASC")
    
    while counter < num_of_pages do
      @shops += Shop.where(account_status: 'installed').limit(250).offset((counter) * 250).order("id ASC")
      counter += 1  
    end
    
    @paid_total_users = Shop.where("monthly_fee IS NOT NULL").count
    @paid_installed_users = Shop.where(account_status: 'installed').where("monthly_fee IS NOT NULL").count
    @paid_uninstalled_users = Shop.where(account_status: 'uninstalled').where("monthly_fee IS NOT NULL").count
    @paid_installed_percent = (@paid_installed_users.to_f / @paid_total_users) * 100
    
    @free_total_users = Shop.where("monthly_fee IS NULL").count
    @free_installed_users = Shop.where(account_status: 'installed').where("monthly_fee IS NULL").count
    @free_uninstalled_users = Shop.where(account_status: 'uninstalled').where("monthly_fee IS NULL").count
    @free_installed_percent = (@free_installed_users.to_f / @free_total_users) * 100
    
    
    @total_fees = 0
    
    count_fee_shops = Shop.where(account_status: 'installed').where("monthly_fee IS NOT NULL")
    count_fee_shops.each do |count_fee_shop|
      @total_fees += count_fee_shop.monthly_fee.to_f
    end

    
    
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update_attributes(shop_params)
      flash[:success] = "Settings updated"      
      render 'edit'
    else
      render 'edit'
    end    
  end
  
  private
    def shop_params
      params.require(:shop).permit!
    end    
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to ologin_path
      end
    end    
end
