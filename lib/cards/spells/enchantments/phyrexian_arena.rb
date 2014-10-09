
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

    def when_phase_ends(*args)
      if card.in_play? && world.turn.phase.name.to_s  == 'Unkeep' &&  world.playing_player == card.player
        player.hits_player!(1, card)
        player.draw!(card)
      end
    end
  end

end
