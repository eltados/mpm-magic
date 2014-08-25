require_relative '../card'
require_relative '../actions/produce'
class Land < Card
  attr_accessor :mana_produced

  def initialize(options={})
    super
    add_action Produce.new
    @mana_produced = 1
  end


  def produce!
    tap!
    owner.mana_pool.mana += @mana_produced
  end

  def can_be_played?
    !owner.flags[:has_played_a_land_this_turn]
  end

  def play!
    owner.flags[:has_played_a_land_this_turn] = true
  end

end
