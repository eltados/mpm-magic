
class FerventCharge < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Fervent Charge"

    @cost = 4 # 1WBR
    @description =  "Whenever a creature you control attacks, it gets +2/+2 until end of turn."
    @img = "cards/28011.png"
    @mtg_id = 28011
  end

  def affects(card)
    card.is_a?(Creature) && card.player == self.player && card.in_play? && card.flags[:attacking]
  end

  def provided_abilities
    [PlusTwoPlusTwo]
  end


end
