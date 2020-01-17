ITEM.name = "Cartão de Cidadania"
ITEM.model = Model("models/sky/cid.mdl")
ITEM.description = "Um cartão padronizado pela União que contém o nome e o ID do indivíduo com a posse."

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
	if self:IsCWU() then
		return "models/sky/cwuid.mdl"
	elseif self:IsCombine() then
		return "models/dorado/tarjeta2.mdl"
	else
		return self.model
	end
end

function ITEM:PopulateTooltip(tooltip)
	if not self:IsCWU() and not self:IsCombine() then
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Success", tooltip))
		data:SetText("Name: " .. self:GetData("citizen_name", "Unissued") .. "\nID Number: " .. self:GetData("cid", "00000"))
		data:SetFont("BudgetLabel")
		data:SetExpensiveShadow(0.5)
		data:SizeToContents()
	end

	if self:IsCWU() then
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Success", tooltip))
		data:SetText("Name: " .. self:GetData("citizen_name", "Unissued") .. "\nID Number: " .. self:GetData("cid", "00000") .. "\nWorker ID: " .. self:GetData("worker_id", "NO ID! CONTACT DEVELOPER!"))
		data:SetFont("BudgetLabel")
		data:SetExpensiveShadow(0.5)
		data:SizeToContents()
	end

	if self:IsCombine() then
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Success", tooltip))
		data:SetText("Unit Identifier: " .. string.match(self:GetData("citizen_name", "NO NAME"), "%d%d%d") .. "\nUnit Rank: " .. self:GetCPRank() .. "\nFull Identifier: " .. self:GetCPName() .. "\nService Number: " .. self:GetData("service_number", "no num"))
		data:SetFont("BudgetLabel")
		data:SetExpensiveShadow(0.5)
		data:SizeToContents()
	end

	local warning = tooltip:AddRow("warning")
	warning:SetBackgroundColor(derma.GetColor("Error", tooltip))
	warning:SetText("Cada cartão possui um número de identidade único e uma foto 3x4 do indivíduo impressa no papel. Seria uma péssima idéia ser pego um um cartão que não lhe pertence.")
	warning:SetFont("DermaDefault")
	warning:SetExpensiveShadow(0.5)
	warning:SizeToContents()

	if self:IsCombine() then
		local warning2 = tooltip:AddRow("warning2")
		warning2:SetBackgroundColor(derma.GetColor("Error", tooltip))
		warning2:SetText("This is your ID card, it allows you access to everything you have been granted as a CCA officer. If you lose this card, you will be deserviced. Even if it is stolen from you.")
		warning2:SetFont("DermaDefault")
		warning2:SetExpensiveShadow(0.5)
		warning2:SizeToContents()
	end
end

function ITEM:GetAssociatedCharacter()
	return self:GetData("associated_character", false)
end

--[[-------------------------------------------------------------------------
There will always be an associated character because these are -ONLY- given on spawn.
---------------------------------------------------------------------------]]
function ITEM:GetCPName()
	if ix.char.loaded[self:GetAssociatedCharacter()] then
		return ix.char.loaded[self:GetAssociatedCharacter()]:GetName()
	else
		return self:GetData("citizen_name", false)
	end
end

function ITEM:GetCPRank()
	local name = self:GetCPName()
	return string.match(name, "%p%a%a%p") or string.match(name, "%p%d%d%p")
end

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
			if v.uniqueID == "cid" then
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

		if client:IsCombine() then
			print(client)
			print(item.id)
			PrintTable(ix.item.instances[item.id])
			--PrintTable(item)
			netstream.Start(client, "OpenRecordMenu", {item.id})
		end

		return false
	end,

	OnCanRun = function(item)
		return item.player:IsCombine() or item.invID != item.player:GetCharacter():GetInventory():GetID()
	end
}