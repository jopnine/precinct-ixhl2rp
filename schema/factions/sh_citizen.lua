
FACTION.name = "Cidadãos"
FACTION.description = "A regular human citizen enslaved by the Universal Union."
FACTION.color = Color(150, 125, 100, 255)
FACTION.models = {
	"models/tnb/citizens/female_01.mdl",
	"models/tnb/citizens/female_02.mdl",
	"models/tnb/citizens/female_03.mdl",
	"models/tnb/citizens/female_04.mdl",
	"models/tnb/citizens/female_05.mdl",
	"models/tnb/citizens/female_06.mdl",
	"models/tnb/citizens/female_07.mdl",
	"models/tnb/citizens/female_08.mdl",
	"models/tnb/citizens/female_09.mdl",
	"models/tnb/citizens/female_10.mdl",
	"models/tnb/citizens/female_11.mdl",
	"models/tnb/citizens/npc/female_14.mdl",
	"models/tnb/citizens/npc/female_18.mdl",
	"models/tnb/citizens/npc/female_19.mdl",
	"models/tnb/citizens/npc/female_20.mdl",
	"models/tnb/citizens/female_21.mdl",
	"models/tnb/citizens/female_23.mdl",
	"models/tnb/citizens/male_01.mdl",
	"models/tnb/citizens/male_02.mdl",
	"models/tnb/citizens/male_03.mdl",
	"models/tnb/citizens/male_04.mdl",
	"models/tnb/citizens/male_05.mdl",
	"models/tnb/citizens/male_06.mdl",
	"models/tnb/citizens/male_07.mdl",
	"models/tnb/citizens/male_08.mdl",
	"models/tnb/citizens/male_09.mdl",
	"models/tnb/citizens/male_10.mdl",
	"models/tnb/citizens/male_11.mdl",
	"models/tnb/citizens/male_12.mdl",
	"models/tnb/citizens/male_13.mdl",
	"models/tnb/citizens/male_15.mdl",
	"models/tnb/citizens/male_17.mdl",
	"models/tnb/citizens/male_18.mdl",	
	"models/tnb/citizens/npc/male_20.mdl",
	"models/tnb/citizens/npc/male_21.mdl",
	"models/tnb/citizens/npc/male_22.mdl",
	"models/tnb/citizens/npc/male_23.mdl"
}

FACTION.isDefault = true

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)

	inventory:Add("suitcase", 1)
	local Timestamp = os.time()
		local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )
	inventory:Add("transfer_papers", 1, {
		citizen_name = character:GetName(),
		unique = math.random(0000000,999999999),
		issue_date = tostring(TimeString)
	})
end

FACTION_CITIZEN = FACTION.index
