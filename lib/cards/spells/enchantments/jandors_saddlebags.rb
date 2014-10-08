
class JandorsSaddlebags < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Jandor's Saddlebags"

    @cost = 2 # 2
    @description =  "{3}, {Tap}: Untap target creature."
    @img = "cards/11357.png"
    @mtg_id = 11357
    add_action Pay2TapCreature.new(self)
  end


end
