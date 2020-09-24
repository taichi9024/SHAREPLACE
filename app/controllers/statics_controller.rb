class StaticsController < ApplicationController
  def home
    if logged_in?
      @post  = current_user.posts.new
    end
  end
  def about
  end

end
