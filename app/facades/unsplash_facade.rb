class UnsplashFacade
  def self.get_logo
    logo_image = UnsplashService.find_logo
    Image.new(logo_image)
  end

  def self.get_item_image(item_name)
    item_image = UnsplashService.find_item_image(item_name)
    Image.new(item_image[:results].first)
  end
end