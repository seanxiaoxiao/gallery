require "spec_helper"

describe HomeController do

  it "routes to #index" do
    get("/").should route_to("home#index")
  end

    #it "routes to #portfolio" do
    #  get("/portfolio/1.html").should route_to("home#portfolio", :id => "1")
    #end
    #
    #it "routes to #album" do
    #  get("/album/1.html").should route_to("home#album", :id => "1")
    #end

end