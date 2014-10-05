
class Exile < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Exile"

    @cost = 3 # 2W
    @description =  "Exile target nonwhite attacking creature. You gain life equal to its toughness."
    @img = "cards/15350.png"
    @mtg_id = 15350
  end

  def disabled?; true end

end
    