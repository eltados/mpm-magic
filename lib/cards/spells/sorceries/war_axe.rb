class  WarAxe < Sorcery


  def initialize(owner=nil)
    super(owner)
    @name = 'War Axe'
    @cost = 3 # 5B
    @description =  "Deals 5 dommages to the opponent"
    @img = "http://dx9rjq5h30myv.cloudfront.net/wp-content/uploads/2012/09/lord-lightning-610.jpg"
  end

  def play!
    super
    @owner.opponent.hits_player!(5 , self)
  end

end
