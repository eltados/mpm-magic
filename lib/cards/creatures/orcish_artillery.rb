class OrcishArtillery < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Orcish Artillery"
    @strength = 1
    @toughness = 3
    @type = "Creature"
    @cost = 3 # 1RR
    @description =  "{Tap}: Orcish Artillery deals 2 damage to target creature or player and 3 damage to you."
    @img = "http://farm9.staticflickr.com/8187/8104775815_a3f58d18d9_z.jpg"
    @mtg_id = 213
  end

end
