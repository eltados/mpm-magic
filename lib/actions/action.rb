class Action
  attr_accessor :name, :owner, :img, :description, :priority , :targets

  def initialize(owner=nil)
    @owner = owner
    @targets = []
  end

  def to_param
    "#{object_id}-#{name}-#{owner.to_param}"
  end
  def to_s
    @name
  end

  def stackable?
    true
  end

  def can_be_played_multiple_times?
    false
  end

  def skip?
    return true if !is_a?(Play) && card.is_a?(Creature) && ( !card.in_play? && !card.flags[:sacrified] )
    return true if is_a?(Play) && ( !card.in_hand? )
    targets.each do |t|
      if !can_target(t)
        return true
      end
    end
    false
  end

  def self.find(id)
    ObjectSpace._id2ref(id.to_i)
  end

  def pay!
  end

  def can_be_activated
      card.in_play? && player.active? && !already_played?
  end

  def card
    @owner
  end

  def already_played?
    world.stack.include? self
  end


  def player
    card.owner
  end

  def target
    targets.first
  end

  def opponent
    player.opponent
  end

  def world
    player.world
  end

  def phase
    player.world.turn.phase
  end



  def execute!
    world.log Log.new(description: self.log , card: card, action:self)
  end

  def can_target(target)
    card.can_target(target)
  end

  def positive?
    false
  end

  def required_targets
    0
  end

  def react_time
    3000
  end

  def all_targets_selected?
    targets.size >= required_targets
  end

  def log
    "#{card.owner.name} #{name.downcase}s #{card.name}"
  end

  def inspect
    "#<#{self.class.name}:#{object_id} owner=#<#{card.class.name}:#{card.object_id}> >"
  end

end
