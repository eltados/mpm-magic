
class Mobilize < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Mobilize"

    @cost = 1 # G
    @description =  "Untap all creatures you control."
    @img = "cards/4303.png"
    @mtg_id = 4303
  end



end
