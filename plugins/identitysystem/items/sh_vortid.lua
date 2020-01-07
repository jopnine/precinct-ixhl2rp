ITEM.name = "Crachá de Escravo"
ITEM.model = Model("models/dorado/tarjeta4.mdl")
ITEM.description = "Um crachá distribuido pela união aos bióticos escravizados, contém apenas um ID."

function ITEM:GetDescription()
	return self.description
end

function ITEM:IsCWU()
	return self:GetData("cwu", false)
end

function ITEM:IsCombine()
	return self:GetData("cca", false)
end

--dynamiC MODELS BRUH
function ITEM:GetModel()
	return self.model
end

function ITEM:PopulateTooltip(tooltip)
	if not self:IsCWU() and not self:IsCombine() then
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Success", tooltip))
		data:SetText("ID Number: " .. self:GetData("vid", "00000"))
		data:SetFont("BudgetLabel")
		data:SetExpensiveShadow(0.5)
		data:SizeToContents()
	end

	local warning = tooltip:AddRow("warning")
	warning:SetBackgroundColor(derma.GetColor("Error", tooltip))
	warning:SetText("Este crachá está bem colado na pele do biótico, removê-lo resultará em realoação para um plano não terráquio.")
	warning:SetFont("DermaDefault")
	warning:SetExpensiveShadow(0.5)
	warning:SizeToContents()

end


--[[-------------------------------------------------------------------------
There will always be an associated character because these are -ONLY- given on spawn.
---------------------------------------------------------------------------]]


function Schema:CharacterVarChanged(character, key, oldValue, value)
	local client = character:GetPlayer()
	if (key == "name") then
		local factionTable = ix.faction.Get(client:Team())

		if (factionTable.OnNameChanged) then
			factionTable:OnNameChanged(client, oldValue, value)
		end
	end
end

hook.Add("CharacterVarChanged", "ixCPIDUpdate", function(char, key, oldValue, value)
	if key == "name" then
		local inv = char:GetInventory():GetItems()
		for k, v in pairs(inv) do
			if v.uniqueID == "vortid" then
				if v:GetAssociatedCharacter() and v:GetAssociatedCharacter() == char:GetID() then
					v:SetData("citizen_name", value)
					char:GetPlayer():Notify("You have had your rank updated and your ID card has been changed to appropriately affect it.")
				end
			end
		end
	end
end)

ITEM.functions.ViewRecord = {
	name = "View Record",
	OnRun = function(item)
		local client = item.player
		local char = client:GetChar()

		return false
	end,

	OnCanRun = function(item)
		return item.player:IsCombine() or item.invID != item.player:GetCharacter():GetInventory():GetID()
	end
}