
class BookofRass < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Book of Rass"

    @cost = 6 # 6
    @description =  "{2}, Pay 2 life: Draw a card."
    @img = "cards/202573.png"
    @mtg_id = 202573
    add_action PayTwoManaAnTwoHpDraw.new(self)
  end

end
