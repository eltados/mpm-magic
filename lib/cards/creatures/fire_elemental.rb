class FireElemental < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Fire Elemental"
    @strength = 5
    @toughness = 4
    @type = "Creature"
    @cost = 5 # 3RR
    @description =  ""
    @img = "https://deniselefay.files.wordpress.com/2009/03/fire_elemental.jpg"
    @mtg_id = 196
  end

end
