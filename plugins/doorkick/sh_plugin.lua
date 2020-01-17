
PLUGIN.name = "Doorkick"
PLUGIN.author = "B4tr1p"
PLUGIN.description = "Doorkick."


ix.config.Add("strneeded", 0.5, "How much strength is needed to kick a dor.", nil, {
	data = {min = 0, max = 30.0, decimals = 1},
	category = "Doorkick"
})


ix.config.Add("combineonly", false, "Whether or not doorkick is restricted to combines the server.", nil, {
	category = "Doorkick"
})


ix.command.Add("Doorkick", {
    description = "Chuta a porta.",
    adminOnly = true,

	OnRun = function(self, client, arguments)

		-- Get the door the player is looking at.
		local entity = client:GetEyeTrace().Entity
		local current = client:GetLocalVar("stm", 0)
		-- Validate it is a door.
		print(ix.config.Get("combineonly", false) )
		print(client:IsCombine())
	if(ix.config.Get("combineonly", false)) then
		if(client:IsCombine()) then
					if (IsValid(entity) and entity:IsDoor() and !entity:GetNetVar("disabled")) then
						if (client:GetPos():Distance(entity:GetPos())< 100) then	
							if (client:GetCharacter():GetAttribute("str", 0) > ix.config.Get("strneeded", 15)) then
								if(current > 95) then		
									print(client:GetCharacter():GetAttribute("str", 0))
									client:ConsumeStamina(110)
								--	 client:ForceSequence("adoorkick") --Entra que nem maluco
									client:ForceSequence("kickdoor")
									entity:Fire("unlock")
									entity:Fire("open")
								else
									client:Notify("Você não possui stamina suficiente!")
								end
							else
								client:Notify("Você não é forte o suficiente para realizar esta ação!")
							end
						else
							client:Notify("Você não está perto suficiente!")
						end
					else
						client:Notify("Você não está olhando para uma porta!")
					end
		else
		client:Notify("Você não é um combine!")
		end
	else
		if (IsValid(entity) and entity:IsDoor() and !entity:GetNetVar("disabled")) then
			if (client:GetPos():Distance(entity:GetPos())< 100) then	
				if (client:GetCharacter():GetAttribute("str", 0) > ix.config.Get("strneeded", 15)) then
					if(current > 95) then		
						print(client:GetCharacter():GetAttribute("str", 0))
						client:ConsumeStamina(110)
					--	 client:ForceSequence("adoorkick") --Entra que nem maluco
						client:ForceSequence("kickdoor")
						entity:Fire("unlock")
						entity:Fire("open")
					else
						client:Notify("Você não possui stamina suficiente!")
					end
				else
					client:Notify("Você não é forte o suficiente para realizar esta ação!")
				end
			else
				client:Notify("Você não está perto suficiente!")
			end
		else
			client:Notify("Você não está olhando para uma porta!")
		end
	end
    --    if (ix.anim.GetModelClass(model) == "metrocop" or ix.anim.GetModelClass(model) == "mpf") then
			
--		end
    end
})