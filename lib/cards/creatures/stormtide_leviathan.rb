class StormtideLeviathan < Creature

  def initialize(owner=nil)
    super(owner)
    @name = 'Stormtide Leviathan'
    @strength = 8
    @toughness = 8
    @cost = 8 # 5UUU
    @description =  "Islandwalk (This creature is unblockable as long as defending player controls an Island.) All lands are Islands in addition to their other types. Creatures without flying or islandwalk can't attack."
    @img = "http://1.bp.blogspot.com/_xYyHpCIxYsc/THWoAWQIXkI/AAAAAAAAAzU/SwokCtSsNHY/s400/leviathan.jpg"
    @mtg_id = 205029
  end

end
