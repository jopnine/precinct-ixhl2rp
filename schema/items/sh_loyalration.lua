ITEM.name = "Ração Lealista"
ITEM.model = Model("models/weapons/w_packatl.mdl")
ITEM.description = "Uma embalagem vermelha de alumínio duro com o símbolo da união estampado na frente."
ITEM.items = {"lealista", "agua_saborosa"}

ITEM.functions.Abrir = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()

		for k, v in ipairs(itemTable.items) do
			if (!character:GetInventory():Add(v)) then
				ix.item.Spawn(v, client)
			end
		end

		character:GiveMoney(ix.config.Get("rationTokens", 40))
		client:EmitSound("ambient/fire/mtov_flame2.wav", 75, math.random(160, 180), 0.35)
	end
}
