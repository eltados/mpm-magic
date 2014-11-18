
class MistmoonGriffin < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Mistmoon Griffin"

    @strength = 2
    @toughness = 2
    @cost = 4 # 3W
    @description =  "Flying When Mistmoon Griffin is put into a graveyard from the battlefield, exile Mistmoon Griffin, then return the top creature card of your graveyard to the battlefield."
    @img = "cards/4583.png"
    @mtg_id = 4583
  end

  def self.disabled?; true end

end
    