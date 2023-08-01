class UnsplashService
  def self.find_logo
    photo = Unsplash::Photo.find("kOGDVpRl3RE")
  end

  def self.find_likes
    likes = Unsplash::Photo.find("kOGDVpRl3RE").likes
  end
end