class SinApp

    def self.action( me=nil, action=nil, target=nil )
        # reject when the same action is played multiple times
        return false if me.world.stack.include? action && action.can_be_played_multiple_times?

        notify = false
        if target
          action.targets << target
          target.targeted_by_actions << action
        end

        if action.all_targets_selected?
          me.target_action = nil
          action.pay!
          notify = true
          if action.stackable?  && me.opponent.react?
            me.world.stack.push action
          else
            action.execute!
          end
        else
          me.target_action = TargetAction.new(action.owner, action)
        end

        return notify
    end


end
