class UnsplashService
  def self.find_logo
    photo = Unsplash::Photo.find("kOGDVpRl3RE")
  end
end