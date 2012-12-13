# coding: utf-8
class SessionsController < ApplicationController
  skip_before_filter :authentication, :configure_api, :except => [:destroy]
  layout 'login'

  def show

    render :action => :new
  end

  def create
    @shop = params[:shop]
    account = account_by_params

    if account
      init_authorization account
    else
      flash.now[:error] = "Убедитесь, что адрес магазина указан правильно."
      render :action => :new
    end
  end

  def autologin
    pp current_app
    pp session
    if current_app and current_app.authorize params[:token]
      redirect_to location || root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
