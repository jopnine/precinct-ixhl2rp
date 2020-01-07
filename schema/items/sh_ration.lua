
ITEM.name = "Ração"
ITEM.model = Model("models/weapons/w_packatc.mdl")
ITEM.description = "Um pacote de papel frágil contendo comida e água."
ITEM.items = {"supplements", "agua"}

ITEM.functions.Abrir = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()

		for k, v in ipairs(itemTable.items) do
			if (!character:GetInventory():Add(v)) then
				ix.item.Spawn(v, client)
			end
		end

		character:GiveMoney(ix.config.Get("rationTokens", 25))
		client:EmitSound("ambient/fire/mtov_flame2.wav", 75, math.random(160, 180), 0.35)
	end
}
