local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    exports['qb-target']:RemoveTargetModel(`ch_prop_arcade_claw_01a`, Config.Text['claw_machine'])

    Wait(1000)

    exports['qb-target']:AddTargetModel(`ch_prop_arcade_claw_01a`, {
        options = {
            {
                icon = 'fas fa-coins',
                label = Config.Text['use_claw'],
                targeticon = 'fas fa-coins',
                action = function(entity)
                    if IsPedAPlayer(entity) then return false end
                    QBCore.Functions.Progressbar('claw_machine', Config.Text['grab_toy'], 5000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Play When Done
                        TriggerServerEvent('qb-clawmachine:winPrize')
                    end, function() -- Play When Cancel
                        --Stuff goes here
                    end)
                end,
            }
        },
        distance = 2.5
    })
end)