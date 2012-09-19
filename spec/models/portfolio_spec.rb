
require "spec_helper"

describe Portfolio do

  it "New a portfolio. It should not be nil" do
    portfolio = Portfolio.new()
    portfolio.should_not be_nil
  end

  it "Assign a name to the portfolio. The name should be updated" do
    portfolio = Portfolio.new()
    portfolio.name = "Portrait"
    portfolio.name.should == "Portrait"
  end

  it "Not a valid portfolio if the name is nil" do
    portfolio = Portfolio.new()
    portfolio.valid?.should == false;
  end

  it "Not a valid portfolio if the name is an empty string" do
    portfolio = Portfolio.new()
    portfolio.name = ""
    portfolio.valid?.should == false;
  end

  it "Not a valid portfolio if the name is contains only spaces" do
    portfolio = Portfolio.new()
    portfolio.name = "    "
    portfolio.valid?.should == false;
  end

  it "Valid portfolio if the name is contains only spaces" do
    portfolio = Portfolio.new()
    portfolio.name = "Portrait"
    portfolio.valid?.should == true;
  end

end