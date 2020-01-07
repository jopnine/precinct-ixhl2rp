
ITEM.name = "Seringa de Adrenalina"
ITEM.model = Model("models/props_c17/TrapPropeller_Lever.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Um hormônio extremamente importante, responsável por preparar o organismo para a realização de grandes feitos."
ITEM.category = "Medicina"
ITEM.permit = "medicina"
ITEM.price = 50
		
ITEM.functions.Aplicar = {
	sound = "items/medshot4.wav"
	OnRun = function(itemTable)
		local client = itemTable.player
             
                client:RestoreStamina(100)
		client:SetWalkSpeed(180)
		client:SetRunSpeed(280)
		
		timer.Simple( 60, function() client:SetWalkSpeed(100) end)
		timer.Simple( 60, function() client:SetRunSpeed(200) end)

		return true
	end
}
