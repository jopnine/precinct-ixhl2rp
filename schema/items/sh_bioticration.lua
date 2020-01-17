ITEM.name = "Ração Biótica"
ITEM.model = Model("models/weapons/w_packatb.mdl")
ITEM.description = "Uma embalagem verde e podre, você consegue ouvir coisas se mexendo dentro."
ITEM.items = {"bioticos", "agua_biotica"}

ITEM.functions.Abrir = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()

		for k, v in ipairs(itemTable.items) do
			if (!character:GetInventory():Add(v)) then
				ix.item.Spawn(v, client)
			end
		end

		client:EmitSound("ambient/fire/mtov_flame2.wav", 75, math.random(160, 180), 0.35)
	end
}
