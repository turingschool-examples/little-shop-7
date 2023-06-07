class PhotoService
  def get_url(url)
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def app_logo
    get_url("https://api.unsplash.com/photos/e3-WdkIYZGM?client_id=YWSBl39E4sVAW0hXNpItxxkPNEKCC9MV9J7aAs7XxKA")
  end

  def item(item_name)
    get_url("https://api.unsplash.com/photos/random?client_id=YWSBl39E4sVAW0hXNpItxxkPNEKCC9MV9J7aAs7XxKA&query=#{item_name}")
  end

  def merchant(merchant_name)
    get_url("https://api.unsplash.com/photos/random?client_id=YWSBl39E4sVAW0hXNpItxxkPNEKCC9MV9J7aAs7XxKA&query=#{merchant_name}")
  end
end
