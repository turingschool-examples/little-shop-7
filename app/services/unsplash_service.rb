class UnsplashService
  
  # base_uri 'https://api.unsplash.com'
  # headers 'Authorization' => "rm4CWeBAPX4THdCc9uEI7Gkzn9MSkzvnkcsb4U1Aeew"


  # def random_photo
  #   response = self.class.get('/photos/random')
  #   JSON.parse(response.body)
  # end

  def get_logo_photo
    response = connection.get("/photos/frlKR1JfDok")
    parsed_body = JSON.parse(response.body)
    Photo.new(parsed_body)
  end

  def get_random_photo
    response = connection.get("/photos/random")
    parsed_body = JSON.parse(response.body)
    Photo.new(parsed_body)
  end

  def connection
    Faraday.new(url:'https://api.unsplash.com', params: {"client_id" => ENV["UNSPLASH_KEY"]})
  end
end