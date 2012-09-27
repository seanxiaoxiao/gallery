

class AlbumsController < AdminController
  # GET /albums
  # GET /albums.json
  before_filter :authenticate_user!

  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  def upload_photo
    @album = Album.find(params[:id])
    if request.post?
      files = params[:files]
      upload_response_list = []
      files.each do |file|
        photo = Photo.new
        desc = ""
        photo.create_photo(file, desc)
        @album.add_photo(photo)
        upload_response_list << photo.upload_response()
      end
      render :json => upload_response_list
    elsif request.get?
      upload_response_list = []
      @album.photos.each do |photo|
        upload_response_list << photo.upload_response
      end
      render :json => upload_response_list
    end

  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  def show_by_page
    @album = Album.find(params[:id])
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new
    @portfolios = Portfolio.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @portfolios = Portfolio.all
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new()
    @album.name = params[:album][:name]
    @album.portfolio = Portfolio.find(params[:album][:portfolio])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
