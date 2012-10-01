require 'spec_helper'


describe Photo do

  before do
    @photo = Photo.new()
    @photo.name = "photo"
    file = fixture_file_upload("/test.png")
    @photo.create_photo(file, "desc")
  end

  subject { @photo }

  it { should respond_to(:name) }
  it { should respond_to(:desc) }
  it { should respond_to(:filename) }
  it { should be_valid }

  it "After creating, the photo file exist" do
    File.exist?(@photo.photo_path).should be_true
  end

  it "After creating, the grid thumbnail file exist" do
    File.exist?(@photo.grid_thumbnail_path).should be_true
  end

  it "After creating, the cover thumbnail file exist" do
    File.exist?(@photo.cover_thumbnail_path).should be_true
  end

  it "After creating, the slide thumbnail file exist" do
    File.exist?(@photo.slide_thumbnail_path).should be_true
  end

  it "After creating, the photo path should be correct" do
    @photo.photo_path.end_with?("public/upload/photo/1.png").should == true
  end

  it "After creating, the grid thumbnail path should be correct" do
    @photo.grid_thumbnail_path.end_with?("public/upload/thumbnail-grid/1.png").should == true
  end

  it "After creating, the slide thumbnail path should be correct" do
    @photo.slide_thumbnail_path.end_with?("public/upload/thumbnail-slide/1.png").should == true
  end

  it "After creating, the cover thumbnail path should be correct" do
    @photo.cover_thumbnail_path.end_with?("public/upload/thumbnail-cover/1.png").should == true
  end

  it "After creating, the photo url should be correct" do
    @photo.photo_url.should == "/upload/photo/1.png"
  end

  it "After creating, the grid thumbnail url should be correct" do
    @photo.grid_thumbnail_url.should == "/upload/thumbnail-grid/1.png"
  end

  it "After creating, the slide thumbnail url should be correct" do
    @photo.slide_thumbnail_url.should == "/upload/thumbnail-slide/1.png"
  end

  it "After creating, the cover thumbnail url should be correct" do
    @photo.cover_thumbnail_url.should == "/upload/thumbnail-cover/1.png"
  end

  it "After delete, all the files are deleted" do
    @photo.destroy
    File.exist?(@photo.photo_path).should be_false
    File.exist?(@photo.slide_thumbnail_path).should be_false
    File.exist?(@photo.cover_thumbnail_path).should be_false
    File.exist?(@photo.grid_thumbnail_path).should be_false
  end
end

