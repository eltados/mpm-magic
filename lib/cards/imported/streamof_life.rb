
class StreamofLife < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Stream of Life"

    @cost = 2 # XG
    @description =  "Target player gains X life."
    @img = "cards/1266.png"
    @mtg_id = 1266
  end

  def self.disabled?; true end

end
    