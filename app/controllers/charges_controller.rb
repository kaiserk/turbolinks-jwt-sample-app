class ChargesController < AuthenticatedController
  before_action :set_shop
  # before_action :init_webhooks, only: [:new]
  before_action :set_terms, only: [:new]
  before_action :get_extra_details, only: [:new]

  def new
    puts "ChargesC new start"
    charge = ShopifyAPI::RecurringApplicationCharge.create(
      name: "Pro Subscription",
      price: @price,
      test: test_charge?,
      trial_days: @trial_days,
      return_url: create_url
      )
    @url = charge.confirmation_url
  end

  def create
    puts "ChargesC new create"
    @charge_id = params[:charge_id]
    charge = ShopifyAPI::RecurringApplicationCharge.find(@charge_id)

    c_status = charge.status.to_s

    puts '*** Charge status ===' + c_status

    if charge.status == "accepted"
      save_charge
      charge.activate
      redirect_to thanks_path
      # redirect_to "https://#{@shop.shopify_domain}/admin/apps/" + ENV['APP_NAME'] + "/thanks"
    else
      redirect_to root_path
    end
  end

  def thanks
    puts "ChargesC new thanks"
    # disable Slack notify until Slack account is created
    # SlackBot.ping "Unit Pricing charge activated: #{@shop.shopify_domain}"
  end

  private

  def get_extra_details
    shop = ShopifyAPI::Shop.current
    @shop.first_name = shop.shop_owner.split.first
    @shop.last_name = shop.shop_owner.split.last
    @shop.email_address = shop.email
    @shop.save
  end

  def init_webhooks
    # ShopifyAPI::Base.activate_session(shop_session)
    # CreateWebhooksJob.perform_async(@shop_session)
    # CreateScriptTagsJob.perform_async(@shop_session)
    # CreateThemeSnippetJob.perform_async(@shop)
  end

  def test_charge?
    shop = ShopifyAPI::Shop.current
    return true if shop.plan_name == "affiliate" || shop.plan_name == "partner_test"
    false
  end

  def save_charge
    @shop.update(charge_id: @charge_id)
  end

  def set_terms
    @price = 30
    @trial_days = @shop.created_at > 8.days.ago ? 7 : 0 # no free trial for shops 8+ days old
  end

end
