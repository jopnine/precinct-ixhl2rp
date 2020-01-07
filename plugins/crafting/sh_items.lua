//To add a new item or remove an item, this is the file to do it.

local ITEMS = {}

ITEMS.scrap_metal = {
	["name"] = "Sucata de Metal",
	["model"] = "models/props_debris/metal_panelchunk02d.mdl",
	["description"] = "Um pequeno pedaço de sucata metálica, inútil até ser combinada com outros itens.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 75 --This is used for the 'item spawner plugin' this defines how many 'tickets' the item gets to spawn.
}

ITEMS.reclaimed_metal = {
	["name"] = "Metal Reciclado",
	["model"] = "models/props_c17/oildrumchunk01d.mdl",
	["description"] = "Um pequeno pedaço de metal reciclado, inútil até ser combinado com outros itens.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 25
}


ITEMS.refined_metal = {
	["name"] = "Metal Refinado",
	["model"] = "models/props_c17/canisterchunk02a.mdl",
	["description"] = "Um pequeno pedaço de metal refinado, inútil até ser combinado com outros itens.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 10
}

ITEMS.scrap_electronics = {
	["name"] = "Sucata Eletrônica",
	["model"] = "models/props_lab/reciever01c.mdl",
	["description"] = "Um pequeno conjunto variado de eletrônicos, inútil até serem separados em componentes individuais ou combinados com outros itens.",
	["width"] = 2,
	["height"] = 1,
	["chance"] = 45
}

ITEMS.refined_electronics = {
	["name"] = "Eletrônicos Refinados",
	["model"] = "models/props_lab/reciever01b.mdl",
	["description"] = "Um pequeno conjunto variado de eletrônicos, refinado à perfeição.",
	["width"] = 2,
	["height"] = 1,
	["chance"] = 3
}

ITEMS.empty_carton_of_milk = {
	["name"] = "Caixa Vazia de Leite",
	["model"] = "models/props_junk/garbage_milkcarton002a.mdl",
	["description"] = "Uma caixa vazia de leite.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 60
}

ITEMS.empty_can = {
	["name"] = "Lata Vazia",
	["model"] = "models/props_junk/garbage_metalcan001a.mdl",
	["description"] = "Uma lata vazia.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 80
}

ITEMS.empty_glass_bottle = {
	["name"] = "Garrafa de Vidro Vazia",
	["model"] = "models/props_junk/garbage_glassbottle003a.mdl",
	["description"] = "Uma garrafa de vidro vazia.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 80
}

ITEMS.empty_paint_can = {
	["name"] = "Lata de Tinta Vazia",
	["model"] = "models/props_junk/metal_paintcan001b.mdl",
	["description"] = "Uma lata de tinta vazia.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 80
}

ITEMS.junk_newspaper = {
	["name"] = "Jornal Velho",
	["model"] = "models/props_junk/garbage_newspaper001a.mdl",
	["description"] = "Uma edição antiga do Jornal Nacional, datada a alguns anos atrás.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 80
}

ITEMS.empty_jar = {
	["name"] = "Jarro Vazio",
	["model"] = "models/props_lab/jar01b.mdl",
	["description"] = "Um jarro vazio, aparenta ter resquícios de suplemento de vitamina.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 80
}

ITEMS.cardboard_scraps = {
	["name"] = "Sucata de Cartolina",
	["model"] = "models/props_junk/garbage_carboard002a.mdl",
	["description"] = "Um conjunto de sucata de cartolina.",
	["width"] = 2,
	["height"] = 1,
	["chance"] = 80
}

ITEMS.locker_door = {
	["name"] = "Porta de Armário",
	["model"] = "models/props_lab/lockerdoorleft.mdl",
	["description"] = "Uma simples porta de armário.",
	["width"] = 1,
	["height"] = 4,
	["chance"] = 1
}

ITEMS.cloth_scrap = {
	["name"] = "Sucata de Tecido",
	["model"] = "models/props_debris/concrete_chunk04a.mdl",
	["description"] = "Um conjunto de tecido sucateado.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 90
}

ITEMS.sewn_cloth = {
	["name"] = "Tecido Costurado",
	["model"] = "models/props_debris/concrete_chunk04a.mdl",
	["description"] = "Um conjunto costurado de tecido, útil para criar roupas.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 10
}

ITEMS.battered_scrap = {
	["name"] = "Sucata Maltratada",
	["model"] = "models/props_debris/metal_panelchunk02d.mdl",
	["description"] = "Um metal de qualidade inferior, útil para pôr junto com sucatas.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 85
}

ITEMS.burned_metal = {
	["name"] = "Metal Carbonizado",
	["model"] = "models/props_debris/rebar001a_32.mdl",
	["description"] = "Um pequeno pedaço de metal queimado, frágil e praticamente inútil.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 85
}

ITEMS.empty_ammo_box = {
	["name"] = "Caixa de Munição Vazia",
	["model"] = "models/Items/BoxSRounds.mdl",
	["description"] = "Uma caixa vazia de munição usada.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 75
}

ITEMS.bullet_casings = {
	["name"] = "Estojo de Balas",
	["model"] = "models/Items/357ammobox.mdl",
	["description"] = "Um conjunto de estojo de balas usadas.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 85
}

ITEMS.gunpowder = {
	["name"] = "Pólvora",
	["model"] = "models/props_lab/box01a.mdl",
	["description"] = "Comumente chamada de pó preto, pólvora é um dos ingredientes primários da fabricação de armamentos.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 45
}

ITEMS.scrap_screwdriver = {
	["name"] = "Chave de Fenda de Sucata",
	["model"] = "models/props_c17/TrapPropeller_Lever.mdl",
	["description"] = "Uma chave de fenda moldada por metais sucateados.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 10
}

ITEMS.plank = {
	["name"] = "Tábua",
	["model"] = "models/props_debris/wood_board06a.mdl",
	["description"] = "Uma tábua de madeira.",
	["width"] = 1,
	["height"] = 3,
	["chance"] = 80
}

ITEMS.wood_piece = {
	["name"] = "Pedaço de Madeira",
	["model"] = "models/props_debris/wood_chunk02d.mdl",
	["description"] = "Um pedaço de madeira.",
	["width"] = 1,
	["height"] = 3,
	["chance"] = 80
}

ITEMS.scrap_hammer = {
	["name"] = "Martelo de Sucata",
	["model"] = "models/props_interiors/pot02a.mdl",
	["description"] = "Um martelo fraco dado a vida por diversas ferramentas",
	["width"] = 1,
	["height"] = 2,
	["chance"] = 80
}

ITEMS.normal_screwdriver = {
	["name"] = "Chave de Fenda",
	["model"] = "models/props_c17/TrapPropeller_Lever.mdl",
	["description"] = "Uma Chave de Fenda completa.",
	["width"] = 2,
	["height"] = 1,
	["chance"] = 20,
	["tool"] = true
}

ITEMS.chave_inglesa = {
	["name"] = "Chave Inglesa",
	["model"] = "models/props_c17/tools_wrench01a.mdl",
	["description"] = "Uma chave inglesa enferrujada, útil para encaixar peças.",
	["width"] = 2,
	["height"] = 1,
	["chance"] = 20,
	["tool"] = true
}

ITEMS.lamina = {
	["name"] = "Lâmina",
	["model"] = "models/props_c17/canisterchunk01m.mdl",
	["description"] = "Uma lâmina afiada e quebrada, ainda serve para realizar cortes.",
	["width"] = 1,
	["height"] = 1,
	["chance"] = 20,
	["tool"] = true
}

for k, v in pairs(ITEMS) do
	local ITEM = ix.item.Register(k, nil, false, nil, true)
	ITEM.name = v.name
	ITEM.model = v.model
	ITEM.description = v.description
	ITEM.category = "Crafting"
	ITEM.width = v.width or 1
	ITEM.height = v.height or 1
	ITEM.chance = v.chance or 0
	ITEM.isTool = v.tool or false
end