class Ability

  attr_accessor :card
  def initialize(card)
    @card = card
  end


  def permanent?
    true
  end

  def id
     self.class.name.underscore.to_sym
  end


  def name
     self.class.name.underscore.gsub('_', ' ').gsub(' ability', '').humanize
  end

  def img
    "#{id}.png"
  end


  def description
    ""
  end

  def to_sym
    id
  end

  def to_s
    id
  end

  def self.to_sym
    self.name.underscore.to_sym
  end


end
