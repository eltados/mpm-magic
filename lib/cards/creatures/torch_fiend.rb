class TorchFiend < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Torch Fiend"
    @strength = 2
    @toughness = 1
    @type = "Creature"
    @cost = 2 # 1R
    @description =  "{Red} , Sacrifice Torch Fiend: Destroy target artifact."
    @img = "http://static.comicvine.com/uploads/square_small/11111/111111230/3621357-human_torch_00.jpg"
    @mtg_id = 244702
  end

end
