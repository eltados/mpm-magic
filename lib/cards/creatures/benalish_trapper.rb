class BenalishTrapper < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Benalish Trapper"

    @strength = 1
    @toughness = 2
    @cost = 2 # 1W
    @description =  "{1}, {Tap}: Tap target creature."
    @img = "cards/22937.png"
    @mtg_id = 22937
    add_abilities [Pay1TapCreatureAbility]
  end

end
