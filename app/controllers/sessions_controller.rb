class SessionsController < ApplicationController
  extend ActiveSupport::Concern

  def new
    #puts "SessionsC new"
    authenticate if params[:shop].present?
    #puts "SessionsC new end"
  end

  def create
    #puts "SessionsC create"
    authenticate
    #puts "SessionsC create end"
  end

  def callback
    puts "SessionsC callback"
    if response = request.env['omniauth.auth']
      shop_name = response.uid
      token = response['credentials']['token']
      sess = ShopifyAPI::Session.new(shop_name, token)

      # point explicitly to postgres storage vs relying on indicated local storage
      session[:shopify] = Shop.store(sess)

      current_shop_session ||= ShopifyApp::SessionRepository.retrieve(session[:shopify])
      CreateScriptTagsJob.perform_async(current_shop_session)

      #puts @all_products.to_json
      #handle
      #@shopify_products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})

      session[:shopify_domain] = shop_name
      #puts session.to_json
      if shop_name = sanitize_shop_param(params)
        # remain in shopify admin
        redirect_to "https://#{shop_name}/admin/apps/" + ENV['APP_NAME']
      else
        redirect_to return_address
      end
    else
      redirect_to login_url
    end
  end

  def destroy
    #puts "SessionsC destroy"
    session[:shopify] = nil
    session[:shopify_domain] = nil
    flash[:notice] = "Successfully logged out."
    redirect_to login_url
  end

  protected

  def authenticate
    puts params.to_json
    if shop_name = sanitize_shop_param(params)
      fullpage_redirect_to "#{main_app.root_path}auth/shopify?shop=#{shop_name}"
    else
      redirect_to return_address
    end
  end

  def return_address
    session.delete(:return_to) || main_app.root_url
  end

  def sanitized_shop_name
    @sanitized_shop_name ||= sanitize_shop_param(params)
  end

  def sanitize_shop_param(params)
    return unless params[:shop].present?
    ShopifyApp::Utils.sanitize_shop_domain(params[:shop])
  end

end
