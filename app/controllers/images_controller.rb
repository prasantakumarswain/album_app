class ImagesController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :like]
  def index
    @images = Image.all
  end
  def new
    @image = Image.new
    @like = Like.new
  end
  def create
    #render :text => params and return
    #@image = Image.new(image_params)
    #@image.album_id = params[:album_id]
    @album = Album.find(params[:album_id])
    if @album.user_id == current_user.id
      @image = @album.images.create(image_params)
      if @image.save!
        redirect_to album_path(@image.album.id)
        flash[:notice]= "image created successfully"
      else
        render :new
        flash[:alert] = "image not created successfully"
      end
    else
      redirect_to root_path
      flash[:alert] = "this is not ur album"
    end
  end
  def edit
    @image = Image.find(params[:id])
  end
  def update
    @image  = Image.find(params[:id])
    if @image.update!(image_params)
      redirect_to images_path
      flash[:notice] = "image updated successfully"
    else
      render action: "new"
      flash[:alert]= "image not updated successfully"
    end
  end
  def show
    #render :text => params and return
    @image = Image.find(params[:id])
    #@like = Image.find(params[:id])
    #@unlike = Image.find(params[:id])
    @comment = Comment.new
    @image_comments = @image.comments
  end
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to images_path
    flash[:notice] = "image deleted successfully"
  end
  def like
    #render :text => params and return
    @like = current_user.images.find(params[:image_id])
    @like.update_attribute("like",@like.like+1)
    @like.save
    redirect_to album_image_path(:id => @like.id)
  end
  #def unlike
  #  @unlike = Image.find(params[:image_id])
  #  @unlike.update_attribute("unlike",@unlike.unlike+1)
  #  @unlike.save
  #  redirect_to album_image_path(:id => @unlike.id)
  #end
  private
  def image_params
    params.require(:image).permit(:name, :avatar,:like, :unlike, :album_id, :user_id)
  end
end
