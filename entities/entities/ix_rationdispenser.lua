
AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Ration Dispenser"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

ENT.Displays = {
	[1] = {"INSERT ID", color_white, true},
	[2] = {"CHECKING", Color(255, 200, 0)},
	[3] = {"DISPENSING", Color(0, 255, 0)},
	[4] = {"FREQ. LIMIT", Color(255, 0, 0)},
	[5] = {"WAIT", Color(255, 200, 0)},
	[6] = {"OFFLINE", Color(255, 0, 0), true},
	[7] = {"INSERT ID", Color(255, 0, 0)},
	[8] = {"PREPARING", Color(0, 255, 0)}
}
local racao = "ration"
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
	self:NetworkVar("Bool", 1, "Enabled")
end

if (SERVER) then
	function ENT:SpawnFunction(client, trace)
		local dispenser = ents.Create("ix_rationdispenser")

		dispenser:SetPos(trace.HitPos)
		dispenser:SetAngles(trace.HitNormal:Angle())
		dispenser:Spawn()
		dispenser:Activate()
		dispenser:SetEnabled(true)

		Schema:SaveRationDispensers()
		return dispenser
	end

	function ENT:Initialize()
		self:SetModel("models/props_junk/watermelon01.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:DrawShadow(false)
		self:SetUseType(SIMPLE_USE)
		self:SetDisplay(1)
		self:SetEnabled(true)

		self.dispenser = ents.Create("prop_dynamic")
		self.dispenser:SetModel("models/props_combine/combine_dispenser.mdl")
		self.dispenser:SetPos(self:GetPos())
		self.dispenser:SetAngles(self:GetAngles())
		self.dispenser:SetParent(self)
		self.dispenser:Spawn()
		self.dispenser:Activate()
		self:DeleteOnRemove(self.dispenser)

		local physics = self.dispenser:GetPhysicsObject()
		physics:EnableMotion(false)
		physics:Sleep()

		self.canUse = true
		self.nextUseTime = CurTime()
	end

	function ENT:SpawnRation(callback, releaseDelay)
		print("SpawnRation")
		print(racao)
		releaseDelay = releaseDelay or 1.2
		
		local item = ix.item.Spawn(racao, self:GetPos(), function(itemTable, entity)
			if (callback) then
				callback(entity)
			end

			entity:SetMoveType(MOVETYPE_NONE)
			entity:SetNotSolid(true)
			entity:SetParent(self.dispenser, 1)

			timer.Simple(releaseDelay, function()
				local physics = entity:GetPhysicsObject()

				entity:SetMoveType(MOVETYPE_VPHYSICS)
				entity:SetNotSolid(false) 
				entity:SetParent(nil)

				if (IsValid(physics)) then
					physics:EnableGravity(true)
				end

				-- display cooldown notice
				timer.Simple(releaseDelay, function()
					self:SetDisplay(5)
				end)

				-- make dispenser usable
				timer.Simple(releaseDelay + 4, function()
					self.canUse = true
					self:SetDisplay(1)
				end)
			end)
		end, self:GetAngles())
	end

	function ENT:StartDispense()
		print("StartDispense")
		print(racao)
		self:SetDisplay(3)
		self:SpawnRation(function(racao)
			self.dispenser:Fire("SetAnimation", "dispense_package")
			self:EmitSound("ambient/machines/combine_terminal_idle4.wav")
		end)
	end

	function ENT:DisplayError(id, length)
		id = id or 6
		length = length or 2

		self:SetDisplay(id)
		self:EmitSound("buttons/combine_button_locked.wav")
		self.canUse = false

		timer.Simple(length, function()
			self:SetDisplay(1)
			self.canUse = true
		end)
	end

	function ENT:Use(client)
		jogador = client
		
		if (!self.canUse or self.nextUseTime > CurTime()) then
			return
		end

		if (client:Team() == FACTION_CITIZEN or client:Team() == FACTION_CWU or client:Team() == FACTION_VORTIGAUNT) then
			if (!self:GetEnabled()) then
				self:DisplayError(6)
				return
			end

			local cid = client:GetCharacter():GetInventory():HasItem("cid")
			local vortid = client:GetCharacter():GetInventory():HasItem("vortid")

				if (!cid && !vortid) then
					self:DisplayError(7)
					return
				end

			-- display checking message
			self.canUse = false
			self:SetDisplay(2)
			self:EmitSound("ambient/machines/combine_terminal_idle2.wav")
			
			if(cid == false) then
				cid = vortid
			
							-- check cid ration time and dispense if allowed
							timer.Simple(math.random(1.8, 2.2), function()
								if (cid:GetData("nextRationTime", 0) < os.time()) then
									self:SetDisplay(8)
									self:EmitSound("ambient/machines/combine_terminal_idle3.wav")

									timer.Simple(10.2, function()
										if (client:Team() == FACTION_CWU) then
										racao = "loyalration"
										self:StartDispense(racao)
										end
										if (client:Team() == FACTION_CITIZEN) then
											racao = "ration"
											self:StartDispense(racao)
										end
										if (client:Team() == FACTION_VORTIGAUNT) then
											racao = "bioticration"
											self:StartDispense(racao)
										end
										if(cid) then
										cid:SetData("nextRationTime", os.time() + ix.config.Get("rationInterval", 1))
										end
										if(vortid) then
										vortid:SetData("nextRationTime", os.time() + ix.config.Get("rationInterval", 1))
										end
									end)
								else
									self:DisplayError(4)
								end
							end)
						elseif(cid != false) then
								--cid = vortid
							
											-- check cid ration time and dispense if allowed
											timer.Simple(math.random(1.8, 2.2), function()
												if (cid:GetData("nextRationTime", 0) < os.time()) then
													self:SetDisplay(8)
													self:EmitSound("ambient/machines/combine_terminal_idle3.wav")
				
													timer.Simple(10.2, function()
														if (client:Team() == FACTION_CWU) then
														racao = "loyalration"
														self:StartDispense(racao)
														end
														if (client:Team() == FACTION_CITIZEN) then
															racao = "ration"
															self:StartDispense(racao)
														end
														if (client:Team() == FACTION_VORTIGAUNT) then
															racao = "bioticration"
															self:StartDispense(racao)
														end
														if(cid) then
														cid:SetData("nextRationTime", os.time() + ix.config.Get("rationInterval", 1))
														end
														if(vortid) then
														vortid:SetData("nextRationTime", os.time() + ix.config.Get("rationInterval", 1))
														end
													end)
												else
													self:DisplayError(4)
												end
											end)
								end -- fim do if que checa o CID
			

						elseif (client:IsCombine()) then
							self:SetEnabled(!self:GetEnabled())
							self:EmitSound(self:GetEnabled() and "buttons/combine_button1.wav" or "buttons/combine_button2.wav")

							Schema:SaveRationDispensers()
							self.nextUseTime = CurTime() + 2
						end
			
			
			
			
			

	end

	function ENT:OnRemove()
		if (!ix.shuttingDown) then
			Schema:SaveRationDispensers()
		end
	end
else
	surface.CreateFont("ixRationDispenser", {
		font = "Default",
		size = 32,
		antialias = false
	})

	function ENT:Draw()
		local position, angles = self:GetPos(), self:GetAngles()
		local display = self:GetEnabled() and self.Displays[self:GetDisplay()] or self.Displays[6]

		angles:RotateAroundAxis(angles:Forward(), 90)
		angles:RotateAroundAxis(angles:Right(), 270)

		cam.Start3D2D(position + self:GetForward() * 7.6 + self:GetRight()*  8.5 + self:GetUp() * 3, angles, 0.1)
			render.PushFilterMin(TEXFILTER.NONE)
			render.PushFilterMag(TEXFILTER.NONE)

			surface.SetDrawColor(color_black)
			surface.DrawRect(10, 16, 153, 40)

			surface.SetDrawColor(60, 60, 60)
			surface.DrawOutlinedRect(9, 16, 155, 40)

			local alpha = display[3] and 255 or math.abs(math.cos(RealTime() * 2) * 255)
			local color = ColorAlpha(display[2], alpha)

			draw.SimpleText(display[1], "ixRationDispenser", 86, 36, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			render.PopFilterMin()
			render.PopFilterMag()
		cam.End3D2D()
	end
end
