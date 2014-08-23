class CardCollection
  attr_accessor :cards

  def initialize(cards=[])
    @cards = cards
  end

  def suffle!
    @cards.shuffle!
  end

  def draw!
    @cards.shift
  end

  def size
    @cards.size
  end

  def <<(card)
    @cards << card
  end

end
