class ManaPool
  attr_accessor :mana, :player

  def initialize(player)
    @mana = 0
    @player = player
  end


  def reset!
    @mana = 0
  end

  def can_pay? cost
    @mana  + reserve >= cost
  end

  def pay! cost
    @mana -= cost
    while (@mana < 0)
      action  = @player.lands.find { |land| land.action(Produce).can_be_activated }.action( Produce )
      SinApp.action(@player,  action)
    end
  end

  def reserve
    r = @player.lands.select do  |land|
      land.action(Produce).can_be_activated
    end.map(&:mana_produced).inject{|sum,x| sum + x }
    r || 0
  end

end
