
ITEM.name = "Kit Médico"
ITEM.model = Model("models/Items/HealthKit.mdl")
ITEM.description = "Um pacote médico, com uma quantidade considerável de biogel."
ITEM.category = "Medicina"
ITEM.permit = "medicina"
ITEM.price = 80

ITEM.functions.Usar = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 80, 100))
	end
}
