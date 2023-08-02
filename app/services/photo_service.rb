class PhotoService 
  def logo
    response = HTTParty.get("https://api.unsplash.com/photos/STETfTufvFM/?client_id=IveUAmH42hR3-1YAgCY5L1kIiOTEs9d3pxTqmbi3u-o")
    JSON.parse(response.to_s)["urls"]["thumb"]
  end
  def random
    response = HTTParty.get("https://api.unsplash.com/photos/random/?client_id=IveUAmH42hR3-1YAgCY5L1kIiOTEs9d3pxTqmbi3u-o")
    JSON.parse(response.to_s)["urls"]["thumb"]
  end
  def search(query)
    response = HTTParty.get("https://api.unsplash.com/search/photos/?client_id=IveUAmH42hR3-1YAgCY5L1kIiOTEs9d3pxTqmbi3u-o&query=#{query}")
    JSON.parse(response.to_s)["results"][0]["urls"]["thumb"]
  end
  def logo_likes
    response = HTTParty.get("https://api.unsplash.com/photos/STETfTufvFM/?client_id=IveUAmH42hR3-1YAgCY5L1kIiOTEs9d3pxTqmbi3u-o")
    JSON.parse(response.to_s)["likes"]
  end
end