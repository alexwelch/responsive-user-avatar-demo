class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def avatar
    user = get_user
    size = params[:size]
    if user.present?
      redirect_to user.avatar.url(size), :status => :found
    else
      render :status => :not_found, :text => "not found"
    end
  end

  private

  def get_user
    if request.env["HTTP_REFERER"].present?
      user_id = request.env["HTTP_REFERER"].match(/\/(\d+)\/?/)[1]
      user = User.find_by_id(user_id)
    end
  end
end
