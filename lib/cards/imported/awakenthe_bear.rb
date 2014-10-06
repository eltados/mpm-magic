
class AwakentheBear < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Awaken the Bear"

    @cost = 3 # 2G
    @description =  "Target creature gets +3/+3 and gains trample until end of turn."
    @img = "cards/386484.png"
    @mtg_id = 386484
  end

  def self.disabled?; true end

end
    