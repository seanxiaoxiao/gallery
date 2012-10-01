require 'spec_helper'

include Devise::TestHelpers


describe "Integration test for album page" do

  subject { page }

  before do
    sign_in_user
    @portfolio = Portfolio.new(:name => 'wedding')
    @portfolio.save
    @album = Album.new(:name => 'Test album')
    @album.portfolio = @portfolio
    @album.save
    visit albums_path
  end

  def sign_in_user
    user = User.create(:email => 'seanxiaoxiao@hotmail.com', :password => '111111', :password_confirmation => '111111')
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

  it { should have_content('Listing albums') }
  it { should have_link('Sign out') }
  it { should have_link('New Album') }
  it { should have_selector('table', :count => 1) }


  describe "When click the new album link" do

    before { click_link 'New Album' }
    it { should have_content('New album') }
    it { should have_content('Portfolio') }
    it { should have_link('Back') }
    it { should have_link('Sign out') }

    describe "with invalid information" do

      it "should not create a album if the name is blank" do
        expect { click_on "Create Album" }.not_to change(Album, :count)
      end

      describe "error messages" do
        before { click_on "Create Album" }
        it { should have_content('error') }
      end
    end

    describe "Click Create Album and Create" do
      before do
        fill_in 'Name', with: "Test Album"
        save_page
        select(@portfolio.name, :from => 'album_portfolio_id')
      end
      it "should create the album" do
        expect { click_on 'Create Album' }.to change(Album, :count).by(1)
      end
    end

  end

  describe "Delete Album" do
    it { should have_content('Listing albums') }
    it "should delete the album" do
      expect { click_link 'Destroy' }.to change(Album, :count).by(-1)
    end
  end

end