require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SlidesController do

  include Devise::TestHelpers

  # This should return the minimal set of attributes required to create a valid
  # Slide. As you add validations to Slide, be sure to
  # update the return value of this method accordingly.
  before do
    @user = User.create(:email => 'seanxiaoxiao@hotmail.com', :password => '111111', :password_confirmation => '111111')
    sign_in @user
    @photo = Photo.new()
    @photo.name = "photo"
    file = fixture_file_upload("/test.png")
    @photo.create_photo(file, "desc")
  end

  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SlidesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all slides as @slides" do
      slides = Slide.all
      get :index
      assigns(:slides).should eq(slides)
    end
  end

  describe "GET show" do
    it "assigns the requested slide as @slide" do
      slide = Slide.create! valid_attributes
      get :show, {:id => slide.to_param}
      assigns(:slide).should eq(slide)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested slide" do
      slide = Slide.create! valid_attributes
      expect {
        delete :destroy, {:id => slide.to_param}
      }.to change(Slide, :count).by(-1)
    end

    it "redirects to the slides list" do
      slide = Slide.create! valid_attributes
      delete :destroy, {:id => slide.to_param}
      response.should redirect_to(slides_url)
    end
  end

  describe "New slide" do
    it "Save a slide after new a slide" do
      get :new
      assigns(:slide).should be_a(Slide)
      assigns(:slide).should be_persisted
    end
  end

  describe "Upload Image Slide Action" do
    it "Return the image of the slide if get" do
      slide = Slide.create!
      slide.photo = @photo
      get :upload_photo, { :id => slide.to_param }
      response.body.should eq([@photo.upload_response].to_json)
    end

    it "Return empty array if the slide do not have a photo" do
      slide = Slide.create!
      get :upload_photo, { :id => slide.to_param }
      response.body.should eq([].to_json)
    end

    it "Return the upload response of photo if upload one" do
      slide = Slide.create!
      post :upload_photo, { :id => slide.to_param, :files => [fixture_file_upload("/test.png")] }
      response.body.should eq([slide.photo.upload_response].to_json)
      Photo.any_instance.stub(:create_photo).and_return(false)
      Photo.any_instance.stub(:save).and_return(false)

      slide.photo.should be_persisted
    end

  end

end
