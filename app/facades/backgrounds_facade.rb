class BackgroundsFacade
  def self.get_background(location)
    background = BackgroundsService.get_background(location)
    Image.new(Background.new(location, background))
  end
end
