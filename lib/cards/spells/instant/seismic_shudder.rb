class  SeismicShudder  < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Seismic Shudder'
    @cost = 2 # 1R
    @description =  "Seismic Shudder deals 1 damage to each creature without flying."
    @img = "http://ts1.mm.bing.net/th?id=HN.608010560169381544&w=198&h=153&c=7&rs=1&pid=1.7"
  end

  def play!
    super
    world.creatures.reject{|c| c.has_ability( Flying ) }.each do |c|
      c.hit! 1
    end
  end

end
