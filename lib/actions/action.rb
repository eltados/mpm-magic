class Action
  attr_accessor :name, :owner, :img, :description, :priority

  def to_param
    "#{object_id}-#{name}"
  end

  def self.find(id)
    ObjectSpace._id2ref(id.to_i)
  end

  def actionnable?
     true
  end

  def card
    @owner
  end


  def player
    card.owner
  end

  def world
    card.owner.world
  end


  def execute!
    world.logs << log
  end

  def can_target?(target)
    true
  end

  def log
    "#{card.owner.name} #{name.downcase}s #{card.name}"
  end

end
