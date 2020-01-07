local PLUGIN = PLUGIN;

-- Called when Clockwork has loaded all of the entities.
function PLUGIN:InitPostEntity()
	self:LoadUnionLights();
end;

-- Called just after data should be saved.
function PLUGIN:PostSaveData()
	self:SaveUnionLights();
end;