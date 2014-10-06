
class Rancor < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Rancor"

    @cost = 1 # G
    @description =  "Enchant creature Enchanted creature gets +2/+0 and has trample. When Rancor is put into a graveyard from the battlefield, return Rancor to its owner's hand."
    @img = "cards/12433.png"
    @mtg_id = 12433
  end

  def disabled?; true end

end
    