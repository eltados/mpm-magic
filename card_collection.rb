class CardCollection
  attr_accessor :cards

  def initialize(cards=[])
    @cards = cards
  end

  def shuffle!
    @cards.shuffle!
  end

  def draw!
    @cards.shift
  end

  def size
    @cards.size
  end

  def include? card
    @cards.include? card
  end

  def <<(card)
    @cards << card
  end

end
