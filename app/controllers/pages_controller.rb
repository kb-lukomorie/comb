class PagesController < ApplicationController
  skip_before_filter :authentication, :configure_api
  def main
    if @account.present?

      @profile = @account.profile.present? ? @account.profile : @account.build_profile
    end
  end

  def description
  end
end
