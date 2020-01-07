
ITEM.name = "Frasco de Biogel"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "Um frasco com uma pequena quantidade de biogel."
ITEM.category = "Medicina"
ITEM.permit = "medicina"
ITEM.price = 40

ITEM.functions.Usar = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 50, client:GetMaxHealth()))
	end
}
