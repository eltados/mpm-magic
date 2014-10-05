
class Island < Land

  def initialize(owner=nil)
    super(owner)
    @name = "Island"
    @img = "cards/14738.png"
    @mtg_id = 14738
  end

end
