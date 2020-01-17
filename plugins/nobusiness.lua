local PLUGIN = PLUGIN

PLUGIN.name = "No Business Menu"
PLUGIN.author = "Noise"
PLUGIN.description = "Literally just spalius' plugin, but the function returns false."
PLUGIN.license = "This plugin is free to use, modify, share and redistribute freely without any restrictions. This plugin is covered under CC0 license. No rights reserved."

function PLUGIN:CanPlayerUseBusiness()
	return false
end