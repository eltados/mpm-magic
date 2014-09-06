class Rhino < Creature

  def initialize(owner=nil)
    super(owner)
    @name = 'Crash of Rhinos'
    @strength = 8
    @toughness = 4
    @cost = 8 # 6GG
    @description =  "Trample"
    @img = "http://1.bp.blogspot.com/-mhGnu-OL0OY/UFz18xU2EKI/AAAAAAAAAvU/CNIREPLerCs/s1600/rhino running.jpg"
    @mtg_id = 3379
    add_abilities [ Trample ]
  end

end
