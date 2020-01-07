
ITEM.name = "Cigarros Lightwood"
ITEM.model = Model("models/closedboxshin.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Uma caixa de cigarros Lightwood, extremamente desejada por aqueles que prezam pelo velho mundo."

ITEM.functions.Usar = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 0, client:GetMaxHealth()))

		return true
	end,
}
