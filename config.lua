Config = {}

Config.MaxPlayers = GetConvarInt('sv_maxclients', 32) -- might need to be set to 255 in OneSync servers

Config.KickMessage = "You've been kicked due to the known instanced bug."