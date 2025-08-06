class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed discover ]

  def index
    @q = policy_scope(User).ransack(params[:q])
    @users = @q.result
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
