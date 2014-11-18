
class BeaconofImmortality < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Beacon of Immortality"

    @cost = 6 # 5W
    @description =  "Double target player's life total. Shuffle Beacon of Immortality into its owner's library."
    @img = "cards/50141.png"
    @mtg_id = 50141
  end

  def self.disabled?; true end

end
    