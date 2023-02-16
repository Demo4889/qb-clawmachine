local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-clawmachine:winPrize', function(machine)
    local Player = QBCore.Functions.GetPlayer(source)
    local randomToy = math.random(1, #machine.prizes)
    for i = 1, #machine.prizes, 1 do
        if randomToy == i then
            local prizeChance = math.random(1,100)
            if machine.payaccount == "cash" then
                if machine.prizechance >= prizeChance then
                        Player.Functions.RemoveMoney("cash", Config.price, 'claw_machine')
                        Player.Functions.AddItem(machine.prizes[i], 1)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[machine.prizes[i]], 'add')
                        TriggerClientEvent("qb-clawmachine:client:animation", source, "win")
                else
                    Player.Functions.RemoveMoney("cash", Config.price, 'claw_machine')
                    TriggerClientEvent("QBCore:Notify", source, Config.Text['ate_money'], 'error')
                    TriggerClientEvent("qb-clawmachine:client:animation", source, "lose")
                end
            else
                if machine.prizechance >= prizeChance then
                    Player.Functions.RemoveMoney("bank", Config.price, 'claw_machine')
                    Player.Functions.AddItem(machine.prizes[i], 1)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[machine.prizes[i]], 'add')
                    TriggerClientEvent("qb-clawmachine:client:animation", source, "win")
                else
                    Player.Functions.RemoveMoney("bank", Config.price, 'claw_machine')
                    TriggerClientEvent("QBCore:Notify", source, Config.Text['ate_money'], 'error')
                    TriggerClientEvent("qb-clawmachine:client:animation", source, "lose")
                end
            end
        end
    end
end)