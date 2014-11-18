class Deck

  attr_reader :cards, :name, :url
  def initialize(url)
    json  = RestClient.get(url)
    json = JSON.parse(json)
    @url = url
    @name = json["name"]
    @cards_json = json["cards"]
  end

  def cards
    Deck.cards(@cards_json)
  end

  def valid?
    true
  end




  def self.cards(cards)
   cards.to_h.map { |key , value |
      cards = [] ;
      value.to_i.times do
        cards << Object.const_get(key).new
      end
      cards
    }.flatten
  end



end
