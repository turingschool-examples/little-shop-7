require "./app/services/photo_service"
require "./app/poros/photo"
require "httparty"
require "json"

class PhotoBuilder
  def self.service
    PhotoService.new
  end

  def self.app_logo_info
    Photo.new(service.app_logo)
  end
end