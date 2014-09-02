class Card < Hook

  attr_accessor :name, :owner, :img, :tapped, :actions,  :type, :cost, :flags, :description


  def initialize (owner = nil)
    @actions = []
    add_action Discard.new
    add_action Play.new
    @cost = 0
    @tapped = false
    @flags = {}
    @owner = owner
  end

  def play!
    pay_cost!
    event :played
  end

  def pay_cost!
    @owner.mana_pool.pay! self.cost
  end

  def add_action action
    action.owner = self
    @actions <<  action
  end


  def remove_action action
    @actions.delete action(action) if(action(action) )
  end

  def can?(action_class, target = nil)
    action(action_class).actionnable? == true && \
    ( target ==nil || action(action_class).can_target?(target) )
  end

  def execute! action_class
    action(action_class).execute!
  end

  def action(action_class)
    @actions.each do |a|
      return a if a.is_a? action_class
    end
    return nil
  end


  def tap!
    @tapped = true
    event :tapped
  end

  def untap!
    @tapped = false
    event :untapped
  end


  def tapped?
    tapped
  end

  def in_play?
    @owner.permanents.include? self
  end

  def in_hand?
    self.owner.hand.include?(self)
  end

  def to_param
    "#{object_id}-#{name}"
  end

  def self.find(id)
    ObjectSpace._id2ref(id.to_i)
  end

  def actionable_actions
    actions.select(&:actionnable?).sort_by(&:priority)
  end

  def main_action
    actions.select(&:actionnable?).sort_by(&:priority)[0]
  end

  def self.all
      ObjectSpace.each_object(self.singleton_class).reject{ |c| c == self }
  end


  def player
    @owner
  end

  def world
    player.world
  end

  def when_turn_ends
    super
    @flags = {}
  end

  def when_phase_untap
    super
    untap!
  end


  def event(event)
    method = "when_#{event}".to_sym
    send method if self.respond_to? method.to_sym
  end



end
