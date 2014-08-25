require_relative 'card'
class Card

  attr_accessor :name, :owner, :img, :tapped, :type, :cost

  DEFAULTS = {
     tapped: false,
  }.freeze

  def initialize(options={})

    options = DEFAULTS.merge(options)
    options.each {|k,v| send("#{k}=",v)}

  end

  def play!
  end

  def actions
  end


  def toggle!
    @tapped = ! @tapped
  end

  def tap!
    @tapped = true
  end

  def untap!
    @tapped = false
  end



  def unkeep!
  end


  def tapped?
    tapped
  end

  def in_play?
    @owner.cards_in_play.include? self
  end

  def to_param
    "#{object_id}-#{name}"
  end

  def self.find(id)
    ObjectSpace._id2ref(id.to_i)
  end


end
