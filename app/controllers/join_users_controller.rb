class JoinUsersController < ApplicationController
	before_action :authenticate_user!

  def create
    @join_user = current_user.join_users.create(event_id: params[:event_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @join_user = JoinUser.find_by(event_id: params[:event_id], user_id: current_user.id)
    @join_user.destroy
    redirect_back(fallback_location: root_path)
  end
end
