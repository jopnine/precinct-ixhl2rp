
ITEM.name = "CID"
ITEM.model = Model("models/sky/cid.mdl")
ITEM.description = "Um cartão usado para identificação de cidadãos com o ID #%s, atribuído a %s."

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("id", "00000"), self:GetData("citizen_name", "nobody"))
end
