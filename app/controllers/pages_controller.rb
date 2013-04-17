class PagesController < ApplicationController
  skip_before_filter :authentication, :configure_api, except: :main
  def main
    if @account.present?
      @account = Account.first
      @profile = @account.profile.present? ? @account.profile : @account.build_profile
    end
  end

  def description
  end
end
