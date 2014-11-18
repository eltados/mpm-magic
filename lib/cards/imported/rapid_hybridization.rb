
class RapidHybridization < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Rapid Hybridization"

    @cost = 1 # U
    @description =  "Destroy target creature. It can't be regenerated. That creature's controller puts a 3/3 green Frog Lizard creature token onto the battlefield."
    @img = "cards/366388.png"
    @mtg_id = 366388
  end

  def self.disabled?; true end

end
    