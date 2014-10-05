
class Island < Land

  def initialize(owner=nil)
    super(owner)
    @name = "Island"

    @cost = 0 #
    @description =  "U"
    @img = "cards/14738.png"
    @mtg_id = 14738
  end

  def disabled?; true end

end
