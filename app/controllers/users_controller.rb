class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def avatar
    if request.env["HTTP_REFERER"].present?
      user_id = request.env["HTTP_REFERER"].match(/\/(\d+)\/?/)[1]
      user = User.find_by_id(vgc_id)
    end
    size = params[:size]
    if user.present?
      redirect_to user.avatar.url(size), :status => :found
    else
      render :status => :not_found, :text => "not found"
    end
  end
end
