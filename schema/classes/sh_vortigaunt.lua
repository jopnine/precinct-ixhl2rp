CLASS.name = "Vortigaunt"
CLASS.faction = FACTION_VORTIGAUNT
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/vortigaunt.mdl")
		
	end
end

CLASS_VORTIGAUNT = CLASS.index
