class UnsplashFacade
  def self.get_logo
    image = UnsplashService.find_logo
    image.urls.full
  end
end