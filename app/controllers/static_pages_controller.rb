class StaticPagesController < ApplicationController
  before_action :logged_in_user
  
  def home
    @activities = current_user.activities.paginate page: params[:page],
      per_page: 20
  end
end
