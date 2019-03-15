Config = {}

Config.MaxPlayers = GetConvarInt('sv_maxclients', 32) -- might need to be set to 255 in OneSync servers

Config.KickPlayer = true -- kick the player? if set to false it will instead draw a text warning about being instanced.
Config.KickMessage = "You've been kicked due to the known instanced bug."
Config.WarningMessage = "~r~You seem to be instanced. Please re-join!"