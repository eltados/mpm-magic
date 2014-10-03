class Orgg < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Orgg"
    @strength = 6
    @toughness = 6
    @type = "Creature"
    @cost = 5 # 3RR
    @description =  "Trample Orgg can't attack if defending player controls an untapped creature with power 3 or greater. Orgg can't block creatures with power 3 or greater."
    @img = "http://ertaislament.files.wordpress.com/2011/08/trained-orgg.png"
    @mtg_id = 1968
  end

end
