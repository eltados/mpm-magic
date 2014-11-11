
class RuthlessCullblade < Creature


  def initialize(owner=nil)
    super(owner)
    @name = "Ruthless Cullblade"

    @strength = 2
    @toughness = 1
    @cost = 2 # 1B
    @description =  "Ruthless Cullblade gets +2/+1 as long as an opponent has 10 or less life."
    @img = "cards/194678.png"
    @mtg_id = 194678
    add_abilities [InnerAbility]
  end


  class InnerAbility < Ability

    def value
      opponent_has_less_than_10_hp? ? 0 : 2
    end

    def toughness(original)
      opponent_has_less_than_10_hp? ? original : original + 2
    end

    def strength(original)
      opponent_has_less_than_10_hp? ? original : original + 1
    end

    def opponent_has_less_than_10_hp?
      card.player.nil? || card.opponent.nil? || card.opponent.health > 10
    end

  end
end
