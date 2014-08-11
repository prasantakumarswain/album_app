class AlbumsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  def index
    @albums = Album.order('comments_count DESC').all.paginate(:page => params[:page], :per_page => 20)
    #@image = Image.new
  end

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.new(album_params)
    if @album.save
      redirect_to root_path
      flash[:notice] = "album created successfully"
    else
      render :new
      flash[:alert] = "name should not blank"
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = current_user!
    @album = Album.find(params[:id])
    if @album.update!(album_params)
      redirect_to home_index_path
      flash[:notice]= "album updated successfully"
    else
      render action: "edit"
      flash[:notice]= "album not updated sucessfully"
    end
  end

  def show
    #render :text => params and return
    @album = Album.find(params[:id])
    @image = Image.new
    @album_images  = @album.images.paginate(:page => params[:page], :per_page => 20)
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to home_index_path
    flash[:notice] = "album deleted successfully"
  end

  private
  def album_params
    params.require(:album).permit(:name, :description, :user_id, :comments_count)
  end
end
