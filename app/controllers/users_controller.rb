class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @friends = sorted_friends
  end

  private

  def sorted_friends
    if sort_column == 'birthday'
      current_user.friends.order(:birthday)
    else
      current_user.friends.sort_by{|p| p.name.split(" ").last}
    end
  end

  def sort_column
    params[:sort].presence || 'name'
  end
  helper_method :sort_column

end
