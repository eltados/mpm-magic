
class PhyrexianArena < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Phyrexian Arena"

    @cost = 3 # 1BB
    @description =  "At the beginning of your upkeep, you draw a card and you lose 1 life."
    @img = "cards/45339.png"
    @mtg_id = 45339
    add_abilities [InnerAbility]
  end


  class InnerAbility < Ability

    def when_phase_ends
      return if !card.in_play? || world.turn.phase != Upkeep || !player.active?
      player.hits_player!(1, card)
      player.draw!(1, card)
    end


  end

end
