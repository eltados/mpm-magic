
class Fling < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Fling"

    @cost = 2 # 1R
    @description =  "As an additional cost to cast Fling, sacrifice a creature. Fling deals damage equal to the sacrificed creature's power to target creature or player."
    @img = "cards/271225.png"
    @mtg_id = 271225
  end

  def self.disabled?; true end

end
    