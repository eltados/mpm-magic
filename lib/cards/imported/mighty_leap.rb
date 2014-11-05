
class MightyLeap < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Mighty Leap"

    @cost = 2 # 1W
    @description =  "Target creature gets +2/+2 and gains flying until end of turn."
    @img = "cards/241989.png"
    @mtg_id = 241989
  end

  def self.disabled?; true end

end
    