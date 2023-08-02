class ApplicationController < ActionController::Base
  before_action :logo, :logo_likes
  def logo 
    photo_service = PhotoService.new
    @logo = photo_service.logo
  end
  def logo_likes
    photo_service = PhotoService.new
    @logo_likes = photo_service.logo_likes
  end
end
