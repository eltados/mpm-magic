class Elephant < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Elephant"
    @strength = 3
    @toughness = 3
    @cost = 4
    @img = "http://i.dailymail.co.uk/i/pix/2008/08/15/article-1045768-024BAE3F00000578-39_468x490.jpg";
    end

end
