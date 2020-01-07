CLASS.name = "Escravo"
CLASS.faction = FACTION_VORTIGAUNT
CLASS.isDefault = true
CLASS_ESCRAVO = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/vortigaunt_slave.mdl")
	end
end