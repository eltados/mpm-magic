
class Upheaval < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Upheaval"

    @cost = 6 # 4UU
    @description =  "Return all permanents to their owners' hands."
    @img = "cards/383143.png"
    @mtg_id = 383143
  end

  def play!
    super
    world.permanents.each do |p|
      player.return_in_hand! p
    end
  end

end
