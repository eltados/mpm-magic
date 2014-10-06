class  AncestralRecall < Sorcery


  def initialize(owner=nil)
    super(owner)
    @name = 'Ancestral Recall'
    @cost = 1 # B
    @description =  "Draws three cards."
    @img = "http://www.wizards.com/mtg/images/daily/arcana/aw_091708.jpg"
  end

  def play!
    super
    3.times {  player.draw! }
  end

end
