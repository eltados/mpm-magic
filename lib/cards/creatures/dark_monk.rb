class DarkMonk < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Dark Monk"
    @strength = 3
    @toughness = 1
    @type = "Monk"
    @cost = 3
    @img = "http://fc02.deviantart.net/fs25/f/2008/183/6/0/DArk_monk_by_DjLewis.jpg"
    add_abilities  [ LifeLink ] 
  end


end
