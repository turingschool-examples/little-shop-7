class ApplicationController < ActionController::Base
  def get_logo
    UnsplashFacade.get_logo
  end
end
