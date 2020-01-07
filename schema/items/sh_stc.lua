
ITEM.name = "STC"
ITEM.model = Model("models/sky/cwuid.mdl")
ITEM.description = "Um cartão usado para identificação de membros do sindicato com o ID #%s, atribuído a %s."

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("id", "00000"), self:GetData("citizen_name", "nobody"))
end
