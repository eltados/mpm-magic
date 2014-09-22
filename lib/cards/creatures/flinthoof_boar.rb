class FlinthoofBoar < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Flinthoof Boar"
    @strength = 2
    @toughness = 2
    @type = "Creature"
    @cost = 2 # 1G
    @description =  "Flinthoof Boar gets +1/+1 as long as you control a Mountain. {Red}: Flinthoof Boar gains haste until end of turn. (It can attack and {Tap} this turn.)"
    @img = "http://4.bp.blogspot.com/_YPFDDjQ_y_Y/RztpC9oHWqI/AAAAAAAAAj0/9hZrZ2-DHKs/s400/speedcreature_boar.jpg"
    @mtg_id = 249712
  end

end
