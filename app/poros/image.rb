class Image
  attr_reader :url,
              :likes

  def initialize(data)
    @url = create_url(data)
    @likes = data[:likes]
  end

  def create_url(data)
    if data[:urls][:thumb]
      data[:urls][:thumb]
    elsif data[:urls][:small]
      data[:urls][:small]
    else
      nil
    end 
  end
end