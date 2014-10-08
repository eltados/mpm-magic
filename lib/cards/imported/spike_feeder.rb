
class SpikeFeeder < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Spike Feeder"

    @strength = 0
    @toughness = 0
    @cost = 3 # 1GG
    @description =  "Spike Feeder enters the battlefield with two +1/+1 counters on it. {2}, Remove a +1/+1 counter from Spike Feeder: Put a +1/+1 counter on target creature. Remove a +1/+1 counter from Spike Feeder: You gain 2 life."
    @img = "cards/108924.png"
    @mtg_id = 108924
  end

  def self.disabled?; true end

end
    