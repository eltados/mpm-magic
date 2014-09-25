class FleecemaneLion < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Fleecemane Lion"
    @strength = 3
    @toughness = 3
    @cost = 4 # GW
    @description =  "{3}{Green}{White}: Monstrosity 1. (If this creature isn't monstrous, put a +1/+1 counter on it and it becomes monstrous.) As long as Fleecemane Lion is monstrous, it has hexproof and indestructible."
    @img = "http://fc01.deviantart.net/fs71/f/2010/277/a/e/fantasy_lion_by_liontooth-d302q4s.jpg"
    @mtg_id = 373562
  end

end
