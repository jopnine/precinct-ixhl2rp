
ITEM.name = "STCP"
ITEM.model = Model("models/dorado/tarjetazero.mdl")
ITEM.description = "Um cartão usado para identificação de membros do setor de pesquisa e desenvolvimento do sindicato com o ID #%s, atribuído a %s."

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("id", "00000"), self:GetData("citizen_name", "nobody"))
end
