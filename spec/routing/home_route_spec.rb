require "spec_helper"

describe HomeController do

  it "routes to #index" do
    get("/").should route_to("home#index")
  end

  it "routes to #portfolio" do
    get("/portfolio/1.html").should route_to("home#portfolio", :id => "1")
  end

  it "routes to #album" do
    get("/album/1.html").should route_to("home#album", :id => "1")
  end

  it "routes to get albums in a portfolio by page" do
    get("portfolio/1/albums/2").should route_to("home#albums_in_portfolio", :id => "1", :page => "2")
  end



end