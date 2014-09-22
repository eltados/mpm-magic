class KrenkoMobBoss < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Krenko, Mob Boss"
    @strength = 3
    @toughness = 3
    @type = "Legendary Creature"
    @cost = 4 # 2RR
    @description =  "{Tap}: Put X 1/1 red Goblin creature tokens onto the battlefield, where X is the number of Goblins you control."
    @img = "http://cdn2-b.examiner.com/sites/default/files/styles/image_content_width/hash/6a/68/6a68ec1880c0765a6def11d6c0460c26.jpg?itok=z0R-ZSjS"
    @mtg_id = 386339
  end

end
