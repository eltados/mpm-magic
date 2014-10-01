class SimpleAi < Ai

  def play!
    land = hand.find {|c| c.is_a?(Land) && c.can?(Play) }

    if land
      return land.execute!(Play)
    end

    creature = hand.sort_by(&:cost).reverse.find {|c|  c.is_a?(Creature) && c.can?(Play) }
    if creature
      return creature.execute!(Play)
    end

    if world.turn.phase.is_a?(Combat) && creatures.find { |c| c.can?(Attack) } != nil
      # c = creatures.select { |c| c.can?(Attack) }

      return attack_all!
    end

    if world.turn.phase.is_a?(BlockPhase)
      attacking_creatures = opponent.creatures.select{ |c| c.flags[:attacking] &&  !c.flags[:blocked] }
      attacking_creatures.each do |attacking_creature|
        creatures.select{ |c| c.can? Block, attacking_creature }.sort_by(&:attack).each do |defending_creature|
          block = defending_creature.action(Block)
          if attacking_creature.attack <  defending_creature.health
            return block.execute_with_target!( attacking_creature )
          end
        end
      end

    end

    if world.turn.phase.is_a?(DiscardPhase) && hand.size >= 8
      return hand.sort_by(&:cost).reverse.first.execute! Discard
    end

    return world.turn.next!

  end

end
