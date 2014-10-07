class SimpleAi < Ai

  def play!
    if @player.target_action != nil
        target_action = @player.target_action
        if target_action.action.positive?
          target  = permanents.select{ |card| target_action.can_target(card) }.shuffle.first
        else
          target  = opponent.permanents.select{ |card| target_action.can_target(card) }.shuffle.first
        end
      if target
        return target_action.action.execute_with_target!(target)
      end
    end

    land = hand.find {|c| c.is_a?(Land) && c.can?(Play) }
    if land
      return land.execute!(Play)
    end

    creature = hand.sort_by(&:cost).reverse.find {|c|  c.is_a?(Creature) && c.can?(Play) }
    if creature
      return creature.execute!(Play)
    end

    spell = hand.sort_by(&:cost).reverse.find { |s| s.can?(Play)   }
    if spell
      return spell.execute!(Play)
    end

    action = permanents.map(&:actions).flatten.find { |a|  a.can_be_activated &&
          !a.is_a?(UndoAttack) &&
          !a.is_a?(UndoBlock) &&
          !a.is_a?(Produce) &&
          !a.is_a?(Block) &&
          !a.is_a?(Attack) }
    if action &&  @player.target_action  == nil
      return action.execute!
    end


    if world.turn.phase.is_a?(Combat) && creatures.find { |c| c.can?(Attack) } != nil

      return attack_all!
    end

    if world.turn.phase.is_a?(BlockPhase)
      attacking_creatures = opponent.creatures.select{ |c| c.flags[:attacking] &&  !c.flags[:blocked] }
      attacking_creatures.sort_by(&:attack).each do |attacking_creature|
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
