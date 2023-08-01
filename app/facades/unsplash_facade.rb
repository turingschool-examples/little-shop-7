class UnsplashFacade
  def self.get_logo
    image = UnsplashService.find_logo
    image.urls.full
  end

  def self.get_likes
    likes = UnsplashService.find_likes
  end
end