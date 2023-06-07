require "./app/services/photo_service"
require "./app/poros/photo"

class PhotoBuilder
  def self.service
    PhotoService.new
  end

  def self.app_logo_info
    Photo.new(service.app_logo)
  end

  def self.item_photo_info(item_name)
    Photo.new(service.item(item_name))
  end
end