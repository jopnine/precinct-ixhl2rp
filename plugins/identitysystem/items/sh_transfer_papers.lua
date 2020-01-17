ITEM.name = "Cartão de Transferência"
ITEM.model = Model("models/props_lab/clipboard.mdl")
ITEM.description = "Um folheto de papel indicando suas informações de transferência."

function ITEM:GetDescription()
	return self.description
end
function ITEM:PopulateTooltip(tooltip)
	local data = tooltip:AddRow("data")
	data:SetBackgroundColor(derma.GetColor("Success", tooltip))
	data:SetText("Nome: " .. self:GetData("citizen_name", "Unissued") .. "\nNº de transferência: " .. self:GetData("unique", "00000"))
	data:SetFont("BudgetLabel")
	data:SetExpensiveShadow(0.5 )
	data:SizeToContents()

	local data2 = tooltip:AddRow("data2")
	data2:SetBackgroundColor(derma.GetColor("Warning", tooltip))
	data2:SetText("Entregue estes papéis para um oficial e receba um CID. ISTO NÃO É UMA IDENTIFICAÇÃO VÁLIDA!.")
	data2:SetFont("DermaDefault")
	data2:SetExpensiveShadow(0.5)
	data2:SizeToContents()



end