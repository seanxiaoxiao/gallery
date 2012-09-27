class HomeController < ApplicationController

  def index
    @data = APP_CONFIG['auth_users']
    @portfolios = Portfolio.all
    @slides = Slide.all
  end

  def portfolio
    @portfolios = Portfolio.all
    @portfolio = Portfolio.find(params[:id])
    all_albums = @portfolio.albums
    @albums =  all_albums.paginate(:page => 1, :per_page => 6)
    @current_page = 1
    @page_count = all_albums.length / 6 + (all_albums.length % 6 == 0 ? 0 : 1)
  end

  def albums_in_portfolio
    @portfolio = Portfolio.find(params[:id])
    albums =  @portfolio.albums.paginate(:page => params[:page], :per_page => 6)
    response = []
    albums.each do |album|
      response << album.to_response
    end
    render :json => response
  end

  def album
    @portfolios = Portfolio.all
    @album = Album.find(params[:id])
    @portfolio = @album.portfolio
  end

end
