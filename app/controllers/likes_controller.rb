class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def create
    like = Like.new(like_params)
    if like.save
      render json: { id: like.id }
    else
      # render json: { count: like.errors.full_messages }
    end
  end

  def destroy
    like = Like.find(params[:like_id])
    like.destroy
    render json: {content: "delete successfully"}
  end

  private

  def like_params
    params.require(:like).permit(:product_id).merge(user_id: current_user.id)
  end
end
