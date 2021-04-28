class Image
  attr_reader :id,
              :image

  def initialize(data)
    @image = data
  end
end
