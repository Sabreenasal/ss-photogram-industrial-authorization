class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed discover ]

  def index
    @users = @q.result
  end

  def feed
    if @user != current_user
      flash[:alert] = "You're not authorized for that"
      redirect_to root_path
    else
      @feed_photos = current_user.feed
    end
  end

  def discover
    if @user != current_user
      flash[:alert] = "You're not authorized for that"
      redirect_to root_path
    else
      @discover_photos = current_user.discover
    end
  end

  private

  def set_user
    if params[:username]
      @user = User.find_by!(username: params.fetch(:username))
    else
      @user = current_user
    end
  end
end
