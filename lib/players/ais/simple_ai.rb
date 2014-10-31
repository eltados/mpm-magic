class SimpleAi < Ai

  def play!
      valid_target = true

      if me.target_action != nil
          target_action = me.target_action
          if target_action.action.positive?
            target  = me.permanents.select{ |card| target_action.can_target(card) }.shuffle.first
          else
            target  = opponent.permanents.select{ |card| target_action.can_target(card) }.shuffle.first
          end
        if target
          # puts "Ai decides to #{target_action.action.name} #{target.name} with #{target_action.action.card.name}"
          return SinApp.action(@player, target_action.action , target )
        else
          valid_target = false
        end
      end

      land = hand.find {|c| c.is_a?(Land) && c.action(Play) != nil && c.action(Play).can_be_activated }
      if land
        # puts "Ai decides to play #{land.name}"
        return SinApp.action(@player, land.action(Play) )
      end


      creature = hand.sort_by(&:cost).reverse.find {|c|  c.is_a?(Creature) && c.action(Play).can_be_activated }
      if creature
        # puts "Ai decides to summon #{creature.name}"
        return SinApp.action(@player, creature.action(Play) )
      end


      spell = hand.sort_by(&:cost).reverse.find { |c| c.is_a?(Spell) && c.action(Play).can_be_activated  }
      if spell && ( valid_target || me.target_action == nil ||  me.target_action.action != spell.action(Play) )
        # puts "Ai decides to cast #{spell.name}"
        return SinApp.action(@player, spell.action(Play) )
      end


      action = me.permanents.map(&:actions).flatten.find { |a| a.can_be_activated &&
            !a.is_a?(Produce) &&
            !a.is_a?(UndoAttack) &&
            !a.is_a?(UndoBlock) &&
            !a.is_a?(Produce) &&
            !a.is_a?(Block) &&
            !a.is_a?(Attack) }
      if action && me.target_action == nil
        # puts "@@Ai decides for #{action.card.name} to #{action.name}"
        return SinApp.action(@player, action )
      end

      creature = creatures.find { |c| c.action(Attack).can_be_activated }
      if creature
        # puts "Ai decides to attack with #{creature.name}"
        return SinApp.action(@player, creature.action(Attack) )
      end


      if ! world.stack.empty?
        # puts "Ai resolve stack #{world}"
        return world.resolve_stack!
      end

      
      if world.turn.phase.is_a?(DiscardPhase) && hand.size >= 8
        card = hand.sort_by(&:cost).reverse.first
        return SinApp.action(@player, card.action(Discard) )
      end

      next_action = @player.actions.first
      return SinApp.action(@player, next_action)
  end



  def play2!

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

    land = hand.find {|c| c.is_a?(Land) && c.action(Play) != nil && c.action(Play).can_be_activated }
    if land
      return SinApp.action(@player, land.action(Play) )
      # return land.execute!(Play)
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
