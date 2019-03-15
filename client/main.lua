local serverPlayerList = {}

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

	if isInstanced then
		TriggerServerEvent('fivem-intancedfix:kickMe')
	end
end

RegisterNetEvent('fivem-intancedfix:sendPlayerList')
AddEventHandler('fivem-intancedfix:sendPlayerList', function(players)
	serverPlayerList = players
end)