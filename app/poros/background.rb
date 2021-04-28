class Background
  attr_reader :location,
              :image_url,
              :credits

  def initialize(location, data)
    @location = "downtown #{location}"
    @image_url = data[:url]
    @credits = get_credits(data)
  end

  def get_credits(data)
    {
      source: 'https://www.pexels.com',
      photographer: "Photo by #{data[:photographer]} on Pexels",
      photographer_url: data[:photographer_url],
      logo: 'https://images.pexels.com/lib/api/pexels.png'
    }
  end
end
