class DesecrationElemental < Creature

  def initialize(owner=nil)
    super(owner)
    @name = 'Desecration Elemental'
    @strength = 8
    @toughness = 8
    @type = "Creature"
    @cost = 8 # 3B
    @description =  "Fear (This creature can't be blocked except by artifact creatures and/or black creatures.) Whenever a player casts a spell, sacrifice a creature."
    @img = "http://bogleech.com/mtg/elemental-spawnwrithe.jpg"
    @mtg_id = 50204
  end

end
