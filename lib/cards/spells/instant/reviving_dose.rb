
class RevivingDose < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Reviving Dose"

    @cost = 3 # 2W
    @description =  "You gain 3 life. Draw a card."
    @img = "cards/22941.png"
    @mtg_id = 22941
  end

  def play!
    super
    player.heal_player!(3 , self)
    player.draw!
  end

end
