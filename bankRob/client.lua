local isRobbing = false 
local inAnim    = false
local isNear    = false
isAlive = false
local animDict = "missheistdockssetup1clipboard@idle_a"
local anim = "idle_a"

Citizen.CreateThread(function()
   while true do
    Citizen.Wait(10)
    DrawMarker(29, Config.BankCoords.x, Config.BankCoords.y, Config.BankCoords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 114, 204, 114, 255, false, false, 2, true, nil, nil, false)

    if Vdist(GetEntityCoords(PlayerPedId()), Config.BankCoords) < Config.Distance then
        DisplayText("Press ~INPUT_PICKUP~ to ~r~Rob ~w~the Bank!", true) -- The display text to rob the bank

        if IsControlJustReleased(0, 38) then -- If E is clicked
            if HasAnimDictLoaded(animDict) then -- If the animDict has loaded
                TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, 8.0, -1, 0, 0, false, false, false) -- Play the anim
                Wait(5000) -- Wait
                text("~g~You have sucessfully robbed the bank!") -- Then get the text
                isRobbing = true -- You are robbing
            end
        end 
    end 
   end 
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if not HasAnimDictLoaded(animDict) then 
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(2)
            end
        end
    end
end)

-- Functions 
function DisplayText(message, beep, duration)
    AddTextEntry('LD_ALERT', message)
    BeginTextCommandDisplayHelp('LD_ALERT')
    EndTextCommandDisplayHelp(0, false, beep, duration)
end


function text(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, false)
end