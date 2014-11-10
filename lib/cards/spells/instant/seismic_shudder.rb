class  SeismicShudder  < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Seismic Shudder'
    @cost = 2 # 1R
    @description =  "Seismic Shudder deals 1 damage to each creature without flying."
    @img = "cards/180134.png"
  end

  def play!
    super
    world.creatures.reject{|c| c.has_ability( Flying ) }.each do |c|
      c.hit! 1
    end
  end

end
