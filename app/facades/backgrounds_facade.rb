class BackgroundsFacade
  def self.get_background(location)
    background = BackgroundsService.get_background(location)
    return 'No image' if location.blank?
    Image.new(Background.new(location, background))
  end
end
