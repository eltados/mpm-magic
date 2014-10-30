class SinApp

    def self.action( me=nil, action=nil, target=nil )
        notify = false
        if target
          action.targets << target
          target.targeted_by_actions << action
        end

        if action.all_targets_selected?
          me.target_action = nil
          action.pay!
          notify = true
          me.world.stack.push action

        else
          me.target_action = TargetAction.new(action.owner, action)
        end

        return notify
    end


end
