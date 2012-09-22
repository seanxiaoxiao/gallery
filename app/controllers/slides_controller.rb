class SlidesController < ApplicationController
  # GET /slides
  # GET /slides.json
  def index
    @slides = Slide.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slides }
    end
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
    @slide = Slide.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slide }
    end
  end

  # GET /slides/new
  # GET /slides/new.json
  def new
    @slide = Slide.new
    @slide.save()
    respond_to do |format|
      format.html { redirect_to :action => "show", :id => @slide.id }
      format.json { render json: @slide }
    end
  end

  # GET /slides/1/edit
  def edit
    @slide = Slide.find(params[:id])
  end

  # PUT /slides/1
  # PUT /slides/1.json
  def update
    @slide = Slide.find(params[:id])

    respond_to do |format|
      if @slide.update_attributes(params[:slide])
        format.html { redirect_to @slide, notice: 'Slide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide = Slide.find(params[:id])
    @slide.destroy

    respond_to do |format|
      format.html { redirect_to slides_url }
      format.json { head :no_content }
    end
  end

  def upload_photo
    @slide = Slide.find(params[:id])
    files = params[:files]

    upload_response_list = []

    files.each do |file|
      photo = Photo.new
      desc = ""
      photo.create_photo(file, desc)
      photo.slide = @slide
      photo.save()
      upload_response_list << photo.upload_response()
    end

    render :json => upload_response_list

  end
end
