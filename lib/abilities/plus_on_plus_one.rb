class PlusOnePlusOne < Ability


  def description
    "This creature get a +1 / +1."
  end


  def toughness(original)
    original + 1
  end

  def strength(original)
    original + 1
  end


end
