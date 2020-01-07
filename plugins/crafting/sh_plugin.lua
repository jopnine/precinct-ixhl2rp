--TODO: POPULATE CRAFTING ITEMS AND RECIPES
PLUGIN.name = "Crafting"
PLUGIN.author = "ZeMysticalTaco"
PLUGIN.desc = "Replacing the business menu with crafting because that's a more sensible thing to do."
STORED_RECIPES = {}

function PLUGIN:AddRecipe(name, model, desc, requirements, results, id, skill, blueprint, guns, entity, category)
	if type(name) ~= "table" then
		local RECIPE = {}
		RECIPE["id"] = id --Unique ID of the recipe.
		RECIPE["name"] = name -- Name of the recipe.
		RECIPE["model"] = model -- Model it uses in the menu.
		RECIPE["desc"] = desc -- Description of what it is.
		RECIPE["req"] = requirements --Requirements to craft it(use item id's)
		RECIPE["results"] = results --Results of the craft (use item id's)
		RECIPE["blueprint"] = blueprint or false
		RECIPE["guns"] = guns or false
		RECIPE["entity"] = entity or false
		RECIPE["category"] = category or "Miscellaneous"

		if skill then
			RECIPE["skill"] = skill
		end

		STORED_RECIPES[id] = RECIPE
	else
		for k, v in pairs(name) do
		RECIPE["id"] = k --Unique ID of the recipe.
		RECIPE["name"] = v.name -- Name of the recipe.
		RECIPE["model"] = v.model -- Model it uses in the menu.
		RECIPE["desc"] = v.desc -- Description of what it is.
		RECIPE["req"] = v.requirements --Requirements to craft it(use item id's)
		RECIPE["results"] = v.results --Results of the craft (use item id's)
		RECIPE["blueprint"] = v.blueprint or false --Whether or not it uses a blueprint
		RECIPE["guns"] = v.guns or false --Whether or not it will level up your gunsmithing skill.
		RECIPE["entity"] = v.entity or false --FUTURE: Whether or not it will use an entity.
		RECIPE["category"] = v.category or "Miscellaneous" --FUTURE: The Category

		end
	end
end
--[[-------------------------------------------------------------------------
TODO: For release, demonstrate full capacity of plugin.
---------------------------------------------------------------------------]]
local NEW_RECIPES = {
	["metal_downgrade_reclaimed"] = {
		["name"] = "Breakdown: Reclaimed Metal",
		["model"] = "models/props_c17/oildrumchunk01d.mdl",
		["desc"] = "Break down Reclaimed Metal into Scrap Metal.",
		["requirements"] = {["reclaimed_metal"] = 1, ["scrap_hammer"] = 1},
		["results"] = {["scrap_metal"] = 2},
		["category"] = "Metal Breakdown"
	},
	["metal_downgrade_refined"] = {
		["name"] = "Breakdown: Refined Metal",
		["model"] = "models/props_c17/canisterchunk02a.mdl",
		["desc"] = "Break down Refined Metal into Reclaimed Metal.",
		["requirements"] = {["refined_metal"] = 1, ["scrap_hammer"] = 1},
		["results"] = {["reclaimed_metal"] = 2},
		["category"] = "Metal Breakdown",
	},
	["metal_upgrade_reclaimed"] = {
		["name"] = "Metal: Reclaimed Metal",
		["model"] = "models/props_c17/oildrumchunk01d.mdl",
		["desc"] = "Break down Refined Metal into Reclaimed Metal.",
		["requirements"] = {["scrap_metal"] = 3},
		["results"] = {["reclaimed_metal"] = 1},
		["category"] = "Metal Upgrade",
	},
	["atadura_com_tecido"] = {
		["name"] = "Costurar: Atadura",
		["model"] = "models/props_wasteland/prison_toiletchunk01f.mdl",
		["desc"] = "Rolo de gaze feita a tecido velho.",
		["requirements"] = {["cloth_scrap"] = 3},
		["results"] = {["bandage"] = 1},
		["category"] = "Costura",
		["skill"] = {["medical"] = 5}
	},
	["costurar_tecidos"] = {
		["name"] = "Costurar: Tecidos",
		["model"] = "models/props_debris/concrete_chunk04a.mdl",
		["desc"] = "Costure e renove tecidos velhos.",
		["requirements"] = {["cloth_scrap"] = 2, ["lamina"] = 1},
		["results"] = {["sewn_cloth"] = 1},
		["category"] = "Costura"
	},
	["rasgar_tecidos"] = {
		["name"] = "Rasgar: Tecidos",
		["model"] = "models/props_debris/concrete_chunk04a.mdl",
		["desc"] = "Rasgue tecidos para obter tecidos velhos e destruidos.",
		["requirements"] = {["sewn_cloth"] = 1},
		["results"] = {["cloth_scrap"] = 2},
		["category"] = "Costura"
	},
	["costurar_luvas"] = {
		["name"] = "Costurar: Luvas",
		["model"] = "models/tnb/items/gloves.mdl",
		["desc"] = "Costure um par de luvas usando tecidos renovados.",
		["requirements"] = {["sewn_cloth"] = 4, ["lamina"] = 1},
		["results"] = {["luvas"] = 1},
		["category"] = "Costura"
	},
	["rasgar_luvas"] = {
		["name"] = "Rasgar: Luvas",
		["model"] = "models/tnb/items/gloves.mdl",
		["desc"] = "Rasgue um par de luvas para obter tecidos destruidos.",
		["requirements"] = {["luvas"] = 1},
		["results"] = {["cloth_scrap"] = 8},
		["category"] = "Costura"
	},
	["costurar_touca"] = {
		["name"] = "Costurar: Touca",
		["model"] = "models/tnb/items/beanie.mdl",
		["desc"] = "Costure uma touca de lã usando tecidos renovados.",
		["requirements"] = {["sewn_cloth"] = 4, ["lamina"] = 1},
		["results"] = {["touca"] = 1},
		["category"] = "Costura"
	},
	["rasgar_touca"] = {
		["name"] = "Rasgar: Touca",
		["model"] = "models/tnb/items/beanie.mdl",
		["desc"] = "Rasgue uma touca de lã para obter tecidos destruidos.",
		["requirements"] = {["touca"] = 1},
		["results"] = {["cloth_scrap"] = 8},
		["category"] = "Costura"
	},
	["costurar_bolsa"] = {
		["name"] = "Costurar: Bolsa",
		["model"] = "models/hl2rp/items/bag.mdl",
		["desc"] = "Costure uma bolsa simples usando tecidos renovados.",
		["requirements"] = {["sewn_cloth"] = 6, ["lamina"] = 1},
		["results"] = {["bolsa"] = 1},
		["category"] = "Costura"
	},
	["rasgar_bolsa"] = {
		["name"] = "Rasgar: Bolsa",
		["model"] = "models/hl2rp/items/bag.mdl",
		["desc"] = "Rasgue uma bolsa simples para obter tecidos destruidos.",
		["requirements"] = {["bolsa"] = 1},
		["results"] = {["cloth_scrap"] = 12},
		["category"] = "Costura"
	}
	
}

for k, v in pairs(NEW_RECIPES) do
	PLUGIN:AddRecipe(v.name, v.model, v.desc, v.requirements, v.results, k, v.skill or nil, v.blueprint or nil, v.guns or nil, v.entity or nil, v.category or "Miscellaneous")
end

--[[-------------------------------------------------------------------------
Tying in with the 'Citizen Production Plugin', adding schematics for study.
---------------------------------------------------------------------------]]
for k, v in pairs(ix.item.list) do
	if v.category == "Schematics" then
		local tbl = v.requirements
		local tbl2 = v.result
		local req_table_empty = {}
		local res_table_empty = {}
		for k2, v2 in pairs(tbl) do
			req_table_empty[v2[1]] = v2[2]
		end
		for k3,v3 in pairs(tbl2) do
			if v3[1] != "manufacturing_ticket" then
				res_table_empty[v3[1]] = v3[2]
			end
		end
		PLUGIN:AddRecipe(v.name, v.model, v.description .. "\nYou studied this blueprint from the factories.", req_table_empty, res_table_empty, v.uniqueID, false, v.uniqueID)
	end
end

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sh_items.lua")

ix.command.Add("BlueprintGive", {
	description = "Give a blueprint to a player.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.string},
	OnRun = function(self, client, target, blueprint)
		local data = target:GetData("blueprints", {})

		if not table.HasValue(data, blueprint) then
			table.insert(data, blueprint)
		else
			client:Notify(target:GetName() .. " already has this blueprint.")

			return
		end

		target:SetData("blueprints", data)
		client:Notify("You have given " .. target:GetName() .. " the blueprint " .. blueprint .. ".")
		target.player:Notify("You have been given the blueprint " .. blueprint .. " by " .. client:Name())
	end
})

ix.command.Add("BlueprintRemove", {
	description = "Remove a blueprint from a player.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.string},
	OnRun = function(self, client, target, blueprint)
		local data = target:GetData("blueprints", {})

		if table.HasValue(data, blueprint) then
			table.RemoveByValue(data, blueprint)
		else
			client:Notify(target:GetName() .. " does not have this blueprint.")
		end

		target:SetData("blueprints", data)
		client:Notify("You have taken " .. target:GetName() .. " the blueprint " .. blueprint .. ".")
		target.player:Notify("You have had the blueprint " .. blueprint .. " taken from you by " .. client:Name())
	end
})

local charMeta = ix.meta.character

function charMeta:GiveBlueprint(blueprint)
	local data = self:GetData("blueprints", {})

	if not table.HasValue(data, blueprint) then
		table.insert(data, blueprint)
	end

	self:SetData("blueprints", data)
end

function charMeta:RemoveBlueprint(blueprint)
	local data = target:GetData("blueprints", {})

	if table.HasValue(data, blueprint) then
		table.RemoveByValue(data, blueprint)
	end

	target:SetData("blueprints", data)
end