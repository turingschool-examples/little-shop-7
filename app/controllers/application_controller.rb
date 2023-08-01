class ApplicationController < ActionController::Base
  def get_logo
    UnsplashFacade.get_logo
  end

  def get_likes
    UnsplashFacade.get_likes
  end
end
