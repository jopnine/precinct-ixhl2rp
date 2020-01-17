
ITEM.name = "Lanterna"
ITEM.model = Model("models/pg_props/pg_obj/pg_flashlight.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Uma lanterna comum que pode ser desativada e ativada."
ITEM.category = "Tools"

ITEM:Hook("drop", function(item)
	item.player:Flashlight(false)
end)
