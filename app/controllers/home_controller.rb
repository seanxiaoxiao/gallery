class HomeController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @data = APP_CONFIG['auth_users']
    @portfolios = Portfolio.all
  end

  def portfolio
    @portfolios = Portfolio.all
    @portfolio = Portfolio.find(params[:id])
  end

  def album
    @portfolios = Portfolio.all
    @album = Album.find(params[:id])
    @portfolio = @album.portfolio
  end

end
