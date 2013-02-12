class PagesController < ApplicationController
  def main
    @profile = @account.profile.present? ? @account.profile : @account.build_profile
  end

  def description
  end
end
