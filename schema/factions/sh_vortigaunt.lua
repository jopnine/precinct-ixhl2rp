FACTION.name = "Vortigaunt"
FACTION.description = "Uma criatura verde e molenga de outro planeta."
FACTION.color = Color(100, 150, 50)
FACTION.models = {"models/vortigaunt_slave.mdl"}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true
FACTION.walkSounds = {[0] = "npc/vort/vort_foot1.wav", [1] = "npc/vort/vort_foot2.wav"}
FACTION.runSounds = {[0] = "npc/vort/vort_foot3.wav", [1] = "npc/vort/vort_foot4.wav"}
FACTION.weapons = {"ix_broom"}

function FACTION:GetDefaultName(client)
	vid = Schema:ZeroNumber(math.random(1, 99999), 5), true
	return "C17-ESCRAVO." .. vid
end

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	
	character:SetData("vortid", vid)
		
	
	inventory:Add("vortid", 1, {
		vid = vid	
	})
end

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()

	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end


FACTION_VORTIGAUNT = FACTION.index