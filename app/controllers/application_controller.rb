class ApplicationController < ActionController::Base
  before_action :get_logo
  
  def get_logo
    @logo_image = UnsplashFacade.get_logo
  end

end
