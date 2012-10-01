class ApisController < ApplicationController

  def album
    album = Album.find(params[:album_id])
    respond_to do |format|
      format.xml { render :xml => album.to_xml(:include => :photos) }
      format.json { render :json => album.to_json(:include => :photos) }
    end
  end

  def portfolio
    portfolio = Portfolio.find(params[:portfolio_id])
    respond_to do |format|
      format.xml { render :xml => portfolio.to_xml(:include => :photos) }
      format.json { render :json => portfolio.to_json(:include => :photos) }
    end
  end

end