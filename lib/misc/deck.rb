class Deck

  attr_reader :cards
  def initialize(hash={})
    @cards = []
    hash.each_pair do |card, nb|
      nb.times do
        @cards <<  card
      end
    end
  end


  def self.base
   Deck.new({
    Mountain => 10,
    Forest => 10,
    Lighting => 4,

   })
  end



end
