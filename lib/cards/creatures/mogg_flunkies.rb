class MoggFlunkies < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Mogg Flunkies"
    @strength = 3
    @toughness = 3
    @type = "Creature"
    @cost = 3 # 1R
    @description =  "Mogg Flunkies can't attack or block alone."
    @img = "http://mtgimage.com/set/pd2/mogg flunkies.crop.jpg"
    @mtg_id = 5100

    add_abilities [InnerAbility]
    end


  class InnerAbility < Ability

    def can_attack(original)
      original && player.creatures.any?{ |c| c.flags[:attacking] }
    end

    def can_block(original)
      original && player.creatures.any?{ |c|  c.flags[:blocking] }
    end
  end

end
