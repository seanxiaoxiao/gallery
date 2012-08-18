class HomeController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @data = APP_CONFIG['auth_users']
  end
end
