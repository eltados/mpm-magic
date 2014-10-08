
class Undo < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Undo"

    @cost = 3 # 1UU
    @description =  "Return two target creatures to their owners' hands."
    @img = "cards/6540.png"
    @mtg_id = 6540
  end

  def self.disabled?; true end

end
