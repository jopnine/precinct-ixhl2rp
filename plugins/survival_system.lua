PLUGIN.name = "Survival System"
PLUGIN.author = "ZeMysticalTaco"
PLUGIN.description = "A survival system consisting of hunger and thirst."

if SERVER then
	function PLUGIN:OnCharacterCreated(client, character)
		character:SetData("hunger", 100)
		character:SetData("thirst", 100)
	end

	function PLUGIN:PlayerLoadedCharacter(client, character)
		timer.Simple(0.25, function()
			client:SetLocalVar("hunger", character:GetData("hunger", 100))
			client:SetLocalVar("thirst", character:GetData("thirst", 100))
		end)
	end

	function PLUGIN:CharacterPreSave(character)
		local client = character:GetPlayer()

		if (IsValid(client)) then
			character:SetData("hunger", client:GetLocalVar("hunger", 0))
			character:SetData("thirst", client:GetLocalVar("thirst", 0))
		end
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:SetHunger(amount)
		local char = self:GetCharacter()

		if (char) then
			char:SetData("hunger", amount)
			self:SetLocalVar("hunger", amount)
		end
	end

	function playerMeta:SetThirst(amount)
		local char = self:GetCharacter()

		if (char) then
			char:SetData("thirst", amount)
			self:SetLocalVar("thirst", amount)
		end
	end

	function playerMeta:TickThirst(amount)
		local char = self:GetCharacter()

		if (char) then
			char:SetData("thirst", char:GetData("thirst", 100) - amount)
			self:SetLocalVar("thirst", char:GetData("thirst", 100) - amount)

			if char:GetData("thirst", 100) < 0 then
				char:SetData("thirst", 0)
				self:SetLocalVar("thirst", 0)
			end
		end
	end

	function playerMeta:TickHunger(amount)
		local char = self:GetCharacter()

		if (char) then
			char:SetData("hunger", char:GetData("hunger", 100) - amount)
			self:SetLocalVar("hunger", char:GetData("hunger", 100) - amount)

			if char:GetData("hunger", 100) < 0 then
				char:SetData("hunger", 0)
				self:SetLocalVar("hunger", 0)
			end
		end
	end

	function PLUGIN:PlayerTick(ply)
		if ply:GetNetVar("hungertick", 0) <= CurTime() then
			ply:SetNetVar("hungertick", ix.config.Get("hunger_decay_speed", 300) + CurTime())
			ply:TickHunger(ix.config.Get("hunger_decay_amount", 1))
		end

		if ply:GetNetVar("thirsttick", 0) <= CurTime() then
			ply:SetNetVar("thirsttick", ix.config.Get("thirst_decay_speed", 300) + CurTime())
			ply:TickThirst(ix.config.Get("thirst_decay_amount", 1))
		end
	end
else
	ix.bar.Add(function()
		local status = ""
		local var = LocalPlayer():GetLocalVar("hunger", 0) / 100

		if var < 0.2 then
			status = "Morrendo de fome"
		elseif var < 0.4 then
			status = "Esfomeado"
		elseif var < 0.6 then
			status = "Levemente esfomeado"
		elseif var < 0.8 then
			status = "Estômago roncando"
		elseif var < 1 then
			status = "Satisfeito"
		elseif var == 1 then
			status = "Satisfeito"
		end

		return var, status
	end, Color(200, 200, 40), nil, "hunger")

	ix.bar.Add(function()
		local status = ""
		local var = LocalPlayer():GetLocalVar("thirst", 0) / 100

		if var < 0.2 then
			status = "Desidratado"
		elseif var < 0.4 then
			status = "Levemente Desidratado"
		elseif var < 0.6 then
			status = "Com sede"
		elseif var < 0.8 then
			status = "Ressecado"
		elseif var < 1 then
			status = "Satisfeito"
		elseif var == 1 then
			status = "Satisfeito"
		end

		return var, status
	end, Color(0, 119, 101), nil, "thirst")
end

local playerMeta = FindMetaTable("Player")

function playerMeta:GetHunger()
	local char = self:GetCharacter()

	if (char) then
		return char:GetData("hunger", 100)
	end
end

function playerMeta:GetThirst()
	local char = self:GetCharacter()

	if (char) then
		return char:GetData("thirst", 100)
	end
end

function PLUGIN:AdjustStaminaOffset(client, offset)
	if client:GetHunger() < 15 or client:GetThirst() < 20 then
		return -1
	end
end

--TODO: Populate Hunger and Thirst Items.
--TODO: Drown out colors and restrict stamina restoration for hungry / thirsty players.
local hunger_items = {
	["melancia"] = {
		["name"] = "Melancia",
		["model"] = "models/props_junk/watermelon01.mdl",
		["desc"] = "Uma fruta verde com uma carapaça dura, é natural e não possuí nenhum selo da união.",
		["illegal"] = true,
		["hunger"] = 45,
		["thirst"] = 60,
		["width"] = 2,
		["height"] = 2
    },
	["abacaxi"] = {
		["name"] = "Abacaxi Sintético",
		["model"] = "models/bioshockinfinite/hext_pineapple.mdl",
		["desc"] = "Uma fruta tropical alaranjada, patenteada pela união.",
		["hunger"] = 30,
		["thirst"] = 40,
		["permit"] = "consumiveis"
	},
	["amendoim"] = {
		["name"] = "Saco de amendoins",
		["model"] = "models/bioshockinfinite/rag_of_peanuts.mdl",
		["desc"] = "Um saco cheio de amendoins, patenteado pela união.",
		["hunger"] = 20,
		["permit"] = "consumiveis"
	},
	["banana"] = {
		["name"] = "Banana Sintética",
		["model"] = "models/bioshockinfinite/hext_banana.mdl",
		["desc"] = "Uma fruta amarelada, com diversas marcas pretas, patenteada pela união.",
		["hunger"] = 15,
		["permit"] = "consumiveis"
	},
	["batata"] = {
		["name"] = "Batata Sintética",
		["model"] = "models/bioshockinfinite/hext_potato.mdl",
		["desc"] = "Um tubérculo avermelhado, patenteado pela união.",
		["hunger"] = 15,
		["thirst"] = 5,
		["permit"] = "consumiveis"
	},
	["cafe"] = {
		["name"] = "Café Sintético",
		["model"] = "models/bioshockinfinite/xoffee_mug_closed.mdl",
		["desc"] = "Uma garrafa térmica de café patenteado pela União. Cafeína reduzida.",
		["thirst"] = 20,
		["permit"] = "consumiveis"
	},
	["leite"] = {
		["name"] = "Caixa de Leite",
		["model"] = "models/props_junk/garbage_milkcarton001a.mdl",
		["desc"] = "Uma caixa cheia de leite, não possui o selo da união.",
		["illegal"] = true,
		["thirst"] = 45
	},
	["cereal"] = {
		["name"] = "Cereal Sintético",
		["model"] = "models/bioshockinfinite/hext_cereal_box_cornflakes.mdl",
		["desc"] = "Uma caixa com diversos cereais, patenteada pela união.",
		["hunger"] = 35,
		["permit"] = "consumiveis"
	},
	["agua"] = {
		["name"] = "Água do Breen",
		["model"] = "models/props_lunk/popcan01a.mdl",
		["desc"] = "Uma lata azul de água do reservatório Breen que foi patenteado pela união, tem gosto de água normal.",
		["thirst"] = 20,
		["permit"] = "consumiveis"
	},

	["agua_gaseificada"] = {
		["name"] = "Água Gaseificada",
		["model"] = "models/props_nunk/popcan01a.mdl",
		["desc"] = "Uma lata amarela de água gaseificada de marca que foi patenteado pela união, é refrescante.",
		["thirst"] = 30,
		["permit"] = "consumiveis"
	},
	["agua_saborosa"] = {
		["name"] = "Água Saborificada",
		["model"] = "models/props_cunk/popcan01a.mdl",
		["desc"] = "Uma lata amarela com água adocicada do reservatório Breen que foi patenteado pela união, seu gosto é saboroso.",
		["thirst"] = 40,
		["permit"] = "consumiveis"
	},
	["cerveja"] = {
		["name"] = "Cerveja Sintética",
		["model"] = "models/bioshockinfinite/hext_bottle_lager.mdl",
		["desc"] = "Uma garrafa de cerveja patenteado pela união. Replica o gosto, mas sem alcóol.",
		["thirst"] = 25,
		["permit"] = "consumiveis"
	},
	["cerveja2"] = {
		["name"] = "Cerveja Sintética",
		["model"] = "models/props_junk/glassbottle01a.mdl",
		["desc"] = "Uma garrafa de cerveja, o odor implica uma quantia substâncial de álcool, é antiga e não possui nenhum selo da união.",
		["illegal"] = true,
		["thirst"] = 40
	},
    ["cognac"] = {
		["name"] = "Cognac",
		["model"] = "models/bioshockinfinite/ebsinthebottle.mdl",
		["desc"] = "Uma garrafa de cognac, incríveis detalhes talhados em ouro podem ser encontrados na mesma. Patenteada pela união.",
		["thirst"] = 50,
		["permit"] = "consumiveis"
	},
	["gim"] = {
		["name"] = "Gim Sintético",
		["model"] = "models/bioshockinfinite/ebsinthebottle.mdl",
		["desc"] = "Garrafa de Gim patentiada pela União. Gosto forte de cereal e sem álcool.",
		["thirst"] = 20,
		["permit"] = "consumiveis"
	},
	["chinesa"] = {
		["name"] = "Comida chinesa",
		["model"] = "models/props_junk/garbage_takeoutcarton001a.mdl",
		["desc"] = "Uma caixa antiga contendo macarrão gelado, não possuí o selo da união.",
		["illegal"] = true,
		["hunger"] = 30, 
		["thirst"] = 30
	},
	["maca"] = {
		["name"] = "Maçã Sintética",
		["model"] = "models/bioshockinfinite/hext_apple.mdl",
		["desc"] = "Uma fruta vermelha de gosto podre. Patenteada pela união.",
		["hunger"] = 15, 
		["thirst"] = 15,
		["permit"] = "consumiveis"
	},		
	["milho"] = {
		["name"] = "Milho Sintético",
		["model"] = "models/bioshockinfinite/porn_on_cob.mdl",
		["desc"] = "Uma espiga de milho amarela, patenteada pela união.",
		["hunger"] = 15, 
		["thirst"] = 15,
		["permit"] = "consumiveis"
	},
	["pao"] = {
		["name"] = "Pão Português",
		["model"] = "models/bioshockinfinite/dread_loaf.mdl",
		["desc"] = "Um pão normal com diversas marcas, patenteado pela união.",
		["hunger"] = 25,
		["permit"] = "consumiveis"
	},
    ["pera"] = {
		["name"] = "Pera Sintética",
		["model"] = "models/bioshockinfinite/hext_pear.mdl",
		["desc"] = "Uma fruta amarela de gosto azedo. Patenteada pela união.",
		["hunger"] = 15, 
		["thirst"] = 15,
		["permit"] = "consumiveis"
	},
	["picles"] = {
		["name"] = "Picles Sintético",
		["model"] = "models/bioshockinfinite/dickle_jar.mdl",
		["desc"] = "Um frasco contendo diversos picles em conserva, patenteado pela união.",
		["hunger"] = 15, 
		["thirst"] = 35,
		["permit"] = "consumiveis"
	},
	["pipoca"] = {
		["name"] = "Saco de pipoca",
		["model"] = "models/bioshockinfinite/topcorn_bag.mdl",
		["desc"] = "Um saco cheio de pipoca oleosa, feita apartir de Milho Sintético que foi patenteado pela união.",
		["hunger"] = 35,
		["permit"] = "consumiveis"
	},
	["queijo"] = {
		["name"] = "Queijo Sintético",
		["model"] = "models/bioshockinfinite/pound_cheese.mdl",
		["desc"] = "Uma roda de queijo alaranjada, patenteado pela união.",
		["hunger"] = 20, 
		["thirst"] = 20,
		["permit"] = "consumiveis"
	},
	["vodka"] = {
		["name"] = "Vodka",
		["model"] = "models/bioshockinfinite/pound_cheese.mdl",
		["desc"] = "Uma garrafa de vodka, com um enorme teor alcoólico, o odor deixa isso claro, ela é antiga e não tem nenhum selo da união.",
		["illegal"] = true,
		["thirst"] = 30
	},
	["supplements"] = {
		["name"] = "Suplementos",
		["model"] = "models/pg_plops/pg_food/pg_tortellinan.mdl",
		["desc"] = "Um pacote extremamente leve com apenas alguns miligramas de comida dentro. O gosto é horrível.",
		["hunger"] = 7
	},
	["chips"] = {
		["name"] = "Batatas Fritas",
		["model"] = "models/bioshockinfinite/bag_of_hhips.mdl",
		["desc"] = "Um saco cheio de batatas fritas crocantes, patenteado pela união.",
		["hunger"] = 35,
		["permit"] = "consumiveis"
	},
	["chocolate"] = {
		["name"] = "Barra de chocolate",
		["model"] = "models/bioshockinfinite/hext_candy_chocolate.mdl",
		["desc"] = "Uma barra de chocolate, possuí um gosto adocicado de cacau. Patenteado pela união.",
		["hunger"] = 35,
		["permit"] = "consumiveis"
	},
	["sardinha"] = {
		["name"] = "Lata de sardinha",
		["model"] = "models/bioshockinfinite/cardine_can_open.mdl",
		["desc"] = "Uma lata com algumas sardinhas, patenteada pela união.",
		["hunger"] = 20,
		["permit"] = "consumiveis"
	},
	["laranja"] = {
		["name"] = "Laranja Sintética",
		["desc"] = "Uma fruta laranja com um leve sabor cítrico, patenteada pela união.	",
		["hunger"] = 15,
		["model"] = "models/bioshockinfinite/hext_orange.mdl",
		["permit"] = "consumiveis"
	},
	["lealista"] = {
		["name"] = "Suplementos de Lealista",
		["desc"] = "Um pacote de cereais deliciosos fabricados pela união.",
		["hunger"] = 20,
		["model"] = "models/pg_plops/pg_food/pg_tortellinap.mdl"
	},
	["bioticos"] = {
        ["name"] = "Suplementos Bióticos",
        ["desc"] = "Um pacote verde com vermes grotescos de todos os tipos.",
        ["hunger"] = 10,
        ["model"] = "models/pg_plops/pg_food/pg_tortellinas.mdl"
    },
	["metropolitana"] = {
		["name"] = "Suplementos Metropolitanos",
		["desc"] = "Uma embalagem preta com o símbolo da união estampado na frente. A comida é misturada dentro do pacote e seu gosto é impecável.",
		["hunger"] = 50,
		["model"] = "models/pg_plops/pg_food/pg_tortellinac.mdl"
	}
}


for k, v in pairs(hunger_items) do
	local ITEM = ix.item.Register(k, nil, false, nil, true)
	ITEM.name = v.name
	ITEM.description = v.desc
	ITEM.model = v.model
	ITEM.width = v.width or 1
	ITEM.height = v.height or 1
	ITEM.category = "Consumiveis"
	ITEM.permit = v.permit
	ITEM.hunger = v.hunger or 0
	ITEM.thirst = v.thirst or 0
	ITEM.empty = v.empty or false
	function ITEM:GetDescription()
		return self.description
	end
	ITEM.functions.Consume = {
		name = "Consumir",
		
		OnRun = function(item)
			local hunger = item.player:GetCharacter():GetData("hunger", 100)
			local thirst = item.player:GetCharacter():GetData("thirst", 100)
			item.player:SetHunger(hunger + item.hunger)
			item.player:SetThirst(thirst + item.thirst)
			item.player:EmitSound("physics/flesh/flesh_impact_hard6.wav")
			if item.empty then
				local inv = item.player:GetCharacter():GetInventory()
				inv:Add(item.empty)
			end
		end
	}
end