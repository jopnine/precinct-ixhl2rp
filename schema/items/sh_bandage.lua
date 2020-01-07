
ITEM.name = "Atadura"
ITEM.model = Model("models/props_wasteland/prison_toiletchunk01f.mdl")
ITEM.description = "Um rolo de curativo caseiro para estancar sangramentos."
ITEM.category = "Medicina"
ITEM.permit = "medicina"
ITEM.price = 15

ITEM.functions.Usar = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 20, 100))
	end
}
