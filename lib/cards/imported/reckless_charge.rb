
class RecklessCharge < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Reckless Charge"

    @cost = 1 # R
    @description =  "Target creature gets +3/+0 and gains haste until end of turn. Flashback {2}{Red}(You may cast this card from your graveyard for its flashback cost. Then exile it.)"
    @img = "cards/205365.png"
    @mtg_id = 205365
  end

  def self.disabled?; true end

end
    