
class RaiseDead < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Raise Dead"

    @cost = 1 # B
    @description =  "Return target creature card from your graveyard to your hand."
    @img = "cards/11465.png"
    @mtg_id = 11465
  end

  def self.disabled?; true end

end
    