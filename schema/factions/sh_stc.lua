FACTION.name = "Sindicato dos Trabalhadores Civis"
FACTION.description = "Um indivíduo cujo propósito é servir a união universal."
FACTION.color = Color(150, 125, 100, 255)
FACTION.models = {
	"models/humans/rajio/female_01.mdl",
	"models/humans/rajio/female_02.mdl",
	"models/humans/rajio/female_03.mdl",
	"models/humans/rajio/female_04.mdl",
	"models/humans/rajio/female_05.mdl",
	"models/humans/rajio/female_06.mdl",
	"models/humans/rajio/female_07.mdl",
	"models/humans/rajio/female_08.mdl",
	"models/humans/rajio/female_09.mdl",
	"models/humans/rajio/female_10.mdl",
	"models/humans/rajio/female_11.mdl",
	"models/humans/rajio/female_12.mdl",
	"models/humans/rajio/female_13.mdl",
	"models/humans/rajio/female_14.mdl",
	"models/humans/rajio/female_16.mdl",
	"models/humans/rajio/female_17.mdl",
	"models/humans/rajio/female_18.mdl",
	"models/humans/rajio/female_19.mdl",
	"models/humans/rajio/female_20.mdl",
	"models/humans/rajio/female_21.mdl",
	"models/humans/rajio/male_01.mdl",
	"models/humans/rajio/male_02.mdl",
	"models/humans/rajio/male_03.mdl",
	"models/humans/rajio/male_04.mdl",
	"models/humans/rajio/male_05.mdl",
	"models/humans/rajio/male_06.mdl",
	"models/humans/rajio/male_07.mdl",
	"models/humans/rajio/male_08.mdl",
	"models/humans/rajio/male_09.mdl",
	"models/humans/rajio/male_10.mdl",
	"models/humans/rajio/male_11.mdl",
	"models/humans/rajio/male_12.mdl",
	"models/humans/rajio/male_13.mdl",
	"models/humans/rajio/male_14.mdl",
	"models/humans/rajio/male_15.mdl",
	"models/humans/rajio/male_16.mdl",
	"models/humans/rajio/male_18.mdl",
	"models/humans/rajio/male_19.mdl",
	"models/humans/rajio/male_20.mdl",
	"models/humans/rajio/male_21.mdl",
	"models/humans/rajio/male_22.mdl",
	"models/humans/rajio/male_23.mdl",
	"models/humans/rajio/male_26.mdl"
}



function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)
	

	inventory:Add("suitcase", 1)
	inventory:Add("uniformesindicato", 1)
	inventory:Add("calcassindicato", 1)
	inventory:Add("cid", 1, {
		["citizen_name"] = character:GetName(),
		["id"] = id,
		["cwu"] = true,
		["associated_character"] = character:GetID(),
		["worker_id"] = math.random(0, 100)
	})
	inventory:Add("stc", 1, {
		["citizen_name"] = character:GetName(),
		["id"] = id,
		["cwu"] = true,
		["associated_character"] = character:GetID(),
		["worker_id"] = math.random(0, 100)
	})
end

FACTION_STC = FACTION.index