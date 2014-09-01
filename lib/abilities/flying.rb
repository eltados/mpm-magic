class Flying < Ability

  def initialize(owner=nil)
    super(owner)
    @name = "Flying"
    @img ="flying.png"
    @description ="The creature can only be block by flying creatures"
  end
end
