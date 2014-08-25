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

  def execute!
    raise "Not implemented"
  end

end
