local playerList = {}

RegisterNetEvent('fivem-instancedfix:playerActivated')
AddEventHandler('fivem-instancedfix:playerActivated', function()
	if not playerList[source] then
		playerList[source] = true
		TriggerClientEvent('fivem-intancedfix:sendPlayerList', -1, playerList)
	end
end)

AddEventHandler('playerDropped', function()
	if playerList[source] then
		playerList[source] = nil
		TriggerClientEvent('fivem-intancedfix:sendPlayerList', -1, playerList)
	end
end)

RegisterNetEvent('fivem-instancedfix:requestData')
AddEventHandler('fivem-instancedfix:requestData', function()
	TriggerClientEvent('fivem-intancedfix:sendPlayerList', source, playerList)
end)

RegisterNetEvent('fivem-intancedfix:kickMe')
AddEventHandler('fivem-intancedfix:kickMe', function()
	print(('fivem-intancedfix: kicked %s for being instanced'):format(source))
	DropPlayer(source, Config.KickMessage)
end)