require "httparty"

class PhotoService
  def get_url(url)
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def app_logo
    get_url("https://api.unsplash.com/photos/e3-WdkIYZGM?client_id=j8oWefxGCFshebJlQERPxc22eBQyhl1akC54iCZj6bI")
  end
end