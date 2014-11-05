
class Counterspell < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Counterspell"

    @cost = 2 # UU
    @description =  "Counter target spell."
    @img = "cards/102.png"
    @mtg_id = 102
  end

  def self.disabled?; true end

end
    