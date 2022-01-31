local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-clawmachine:winPrize', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local randomToy = math.random(1, #Config.Prizes)
    for i = 1, #Config.Prizes, 1 do
        if randomToy == i then
            local prizeChance = math.random(1,100)
            if Config.PrizeChance >= prizeChance then
                Player.Functions.RemoveMoney(Config.PayAccount, Config.Price, 'claw_machine')
                Player.Functions.AddItem(Config.Prizes[i], 1)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.Prizes[i]], 'add')
            else
                Player.Functions.RemoveMoney(Config.PayAccount, Config.Price, 'claw_machine')
                TriggerClientEvent("QBCore:Notify", source, Config.Text['ate_money'], 'error')
            end
        end
    end
end)