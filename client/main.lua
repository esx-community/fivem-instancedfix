local serverPlayerList, isWarned, warnedTimes = {}, false, 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('fivem-instancedfix:playerActivated')

			return
		end
	end
end)

Citizen.CreateThread(function()
	TriggerServerEvent('fivem-instancedfix:requestData')

	while true do
		Citizen.Wait(1000 * 30)

		if isWarned then
			Citizen.CreateThread(function()
				StartWarningText()
			end)

			break
		end

		if NetworkIsSessionStarted() then
			CountPlayers()
		end
	end
end)

function CountPlayers()
	local clientPlayerList, isInstanced = {}, false

	for id = 0, Config.MaxPlayers do
		if NetworkIsPlayerActive(id) then
			local serverID = GetPlayerServerId(id)
			clientPlayerList[serverID] = true
		end
	end

	for k,v in pairs(serverPlayerList) do
		local isValid = clientPlayerList[k] == true

		if not isValid then
			isInstanced = true
		end
	end

	if Config.KickPlayer and isInstanced then
		warnedTimes = warnedTimes + 1

		if warnedTimes >= Config.MaxWarnings then
			TriggerServerEvent('fivem-intancedfix:kickMe')
		end
	elseif isInstanced then
		warnedTimes = warnedTimes + 1

		if warnedTimes >= Config.MaxWarnings then
			isWarned = true
		end
	else
		warnedTimes = 0
	end
end

function StartWarningText()
	SetTimecycleModifier('hud_def_blur')

	while true do
		Citizen.Wait(0)
		DisableAllControlActions(0)

		SetTextFont(4)
		SetTextScale(1.0, 1.0)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextCentre(true)

		BeginTextCommandDisplayText('STRING')
		AddTextComponentSubstringPlayerName(Config.WarningMessage)
		EndTextCommandDisplayText(0.5, 0.5)
	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if isWarned then
			SetTimecycleModifier('default')
		end
	end
end)

RegisterNetEvent('fivem-intancedfix:sendPlayerList')
AddEventHandler('fivem-intancedfix:sendPlayerList', function(players)
	serverPlayerList = players
end)