class DarkMonk < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Dark Monk"
    @strength = 3
    @toughness = 1
    @cost = 4
    @img = "http://fc02.deviantart.net/fs25/f/2008/183/6/0/DArk_monk_by_DjLewis.jpg"
    add_abilities  [ LifeLink, Hit ]
  end


end
