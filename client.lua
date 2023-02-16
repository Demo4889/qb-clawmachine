local QBCore = exports['qb-core']:GetCoreObject()
local machineInfo = nil

CreateThread(function()
    local model = `ch_prop_arcade_claw_01a`
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(0)
    end


    for k,v in pairs(Config.machines) do
        exports['qb-target']:RemoveTargetModel(model, Config.Text['use_claw'])

        if DoesObjectOfTypeExistAtCoords(v.location.x, v.location.y, v.location.z, 1.0, model, 0) then
            local object = GetClosestObjectOfType(v.location.x, v.location.y, v.location.z, 1.0, model)
            SetEntityAsMissionEntity(object, true, true)
            Wait(100)
            DeleteObject(object)
        end

        RequestModel(model)

        if not HasModelLoaded(model) then
            Wait(10)
        end

        local claw = CreateObject(model, v.location.x, v.location.y, v.location.z - 1.0, true, true, false)
        SetEntityHeading(claw, (v.location.w - 180))
        FreezeEntityPosition(claw, true)

        exports['qb-target']:AddTargetModel(model, {
            options = {
                {
                    icon = 'fas fa-coins',
                    label = Config.Text['use_claw']..Config.price,
                    targeticon = 'fas fa-coins',
                    action = function(entity)
                        if IsPedAPlayer(entity) then return false end
                        local pCoords = GetEntityCoords(PlayerPedId())
                        local object = DoesObjectOfTypeExistAtCoords(pCoords.x, pCoords.y, pCoords.z, 2.0, model)

                        if object then
                            TaskTurnPedToFaceEntity(GetPlayerPed(-1), object, 2000)
                        end

                        QBCore.Functions.Progressbar('claw_machine', Config.Text['grab_toy'], 5000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim_casino_a@amb@casino@games@arcadecabinet@maleleft",
                            anim = "insert_coins",
                            flag = 16,
                        }, {}, {}, function() -- Play When Done
                            local ped = PlayerPedId()
                            local pCoords = GetEntityCoords(ped)

                            ClearPedTasks(ped)

                            for k,v in pairs(Config.machines) do
                                local dist = Vdist(v.location.x, v.location.y, v.location.z, pCoords.x, pCoords.y, pCoords.z)

                                if dist <= 5.0 then
                                    machineInfo = v
                                end
                            end
                            TriggerServerEvent('qb-clawmachine:winPrize', machineInfo)
                            Wait(100)
                            machineInfo = nil
                        end, function() -- Play When Cancel
                            ClearPedTasks(PlayerPedId())
                        end)
                    end,
                }
            },
            distance = 1.0
        })
    end
end)

RegisterNetEvent("qb-clawmachine:client:animation", function(type)
    local ped = PlayerPedId()
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        if type == "win" then
            animDict = "anim_casino_a@amb@casino@games@arcadecabinet@maleleft"
            anim = "win"

            while not HasAnimDictLoaded(animDict) do
                RequestAnimDict(animDict)
                Wait(5)
            end

            TaskPlayAnim(ped, animDict, anim, 3.0, 3.0, -1, 0, 0, 0, 0, 0)
        elseif type == "lose" then
            animDict = "anim_casino_a@amb@casino@games@arcadecabinet@maleleft"
            anim = "lose"

            while not HasAnimDictLoaded(animDict) do
                RequestAnimDict(animDict)
                Wait(5)
            end

            TaskPlayAnim(ped, animDict, anim, 3.0, 3.0, -1, 0, 0, 0, 0, 0)
        end

        Wait(2000)

        ClearPedTasks(ped)
    end
end)