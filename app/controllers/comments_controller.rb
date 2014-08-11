class CommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  def create
    @album = Album.find(params[:album_id])
    @image  = Image.find(params[:image_id])
    @comment = current_user.comments.create(content: params[:content],album_id: params[:album_id], image_id: params[:image_id], user_id: params[:user_id])
    if  @comment.save
      redirect_to album_image_path(:album_id => @album.id,:id => @comment.image.id)
    else
      redirect_to album_image_path(:album_id => @album.id,:id => @comment.image.id)
      flash[:alert] = "sorry U can't enter blank "
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to album_image_path(:album_id => @comment.image.album.id,:id => @comment.image.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:content,:image_id, :album_id, :user_id)
  end
end
