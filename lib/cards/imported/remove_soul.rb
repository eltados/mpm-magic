
class RemoveSoul < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Remove Soul"

    @cost = 2 # 1U
    @description =  "Counter target creature spell."
    @img = "cards/83228.png"
    @mtg_id = 83228
  end

  def self.disabled?; true end

end
    