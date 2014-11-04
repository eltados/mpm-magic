
class MudbuttonTorchrunner < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Mudbutton Torchrunner"

    @strength = 1
    @toughness = 1
    @cost = 3 # 2R
    @description =  "When Mudbutton Torchrunner dies, it deals 3 damage to target creature or player."
    @img = "cards/271222.png"
    @mtg_id = 271222
  end

  def self.disabled?; true end

end
    