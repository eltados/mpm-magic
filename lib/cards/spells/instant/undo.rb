class Undo < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Undo"

    # @cost = 3 # 1UU
    @cost = 2 # 1UU
    # @description =  "Return two target creatures to their owners' hands."
    @description =  "Return target creature to its owners' hands."
    @img = "cards/6540.png"
    @mtg_id = 6540
  end



  def play!
    super
    target.player.return_in_hand! target
  end


  def can_target(target)
    target.is_a?(Creature) && target.in_play?
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def positive?
    false
  end

end
