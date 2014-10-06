
class WrathofGod < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Wrath of God"

    @cost = 4 # 2WW
    @description =  "Destroy all creatures. They can't be regenerated."
    @img = "cards/874.png"
    @mtg_id = 874
  end

  def self.disabled?; true end

end
    