class FriendshipsController < ApplicationController
  include ApplicationHelper
  def new; end

  def create
    @friendship = Friendship.new
    @friendship.friender_id = current_user.id
    @friendship.friendee_id = params[:friendee_id]
    @friendship.friendship_id = friendship_id_generator(current_user.id, params[:friendee_id].to_i)

    @friendship.save unless Friendship.where(friendship_id: @friendship.friendship_id).exists?

    redirect_back(fallback_location: root_path)
  end

  def update
    @friendship = Friendship.find_by(friendship_id: params[:id])
    @friendship.status = true
    @friendship.save

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.find_by(friendship_id: params[:id])
    @friendship.destroy

    redirect_back(fallback_location: root_path)
    # redirect_to users_path
  end
end
