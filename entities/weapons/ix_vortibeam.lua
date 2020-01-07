if (SERVER) then
	AddCSLuaFile("ix_vortibeam.lua")
end


if (CLIENT) then
	SWEP.Slot = 0
	SWEP.SlotPos = 5
	SWEP.DrawAmmo = false
	SWEP.PrintName = "Vortibeam"
	SWEP.DrawCrosshair = true
	
	game.AddParticles("particles/Vortigaunt_FX.pcf")
end

PrecacheParticleSystem("vortigaunt_beam")
PrecacheParticleSystem("vortigaunt_beam_b")
PrecacheParticleSystem("vortigaunt_charge_token")

SWEP.Category = "HL2 RP"
SWEP.Instructions = "Primary Fire: Fire your laz0r."
SWEP.Purpose = "For death."
SWEP.Contact = ""
SWEP.Author	= "RJ"
SWEP.Drop = false

SWEP.HoldType = "melee"

SWEP.AdminSpawnable = false
SWEP.Spawnable = false
  
SWEP.Primary.NeverRaised = true
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 90
SWEP.Primary.Delay = 3
SWEP.Primary.Ammo = ""
SWEP.AnimPrefix	= "melee"

SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 0
SWEP.Secondary.Ammo	= ""

SWEP.NoIronSightFovChange = true
SWEP.NoIronSightAttack = true
SWEP.LoweredAngles = Angle(60, 60, 60)
SWEP.IronSightPos = Vector(0, 0, 0)
SWEP.IronSightAng = Vector(0, 0, 0)
SWEP.NeverRaised = false

-- Called when the SWEP is deployed.
function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
end

-- Called when the SWEP is holstered.
function SWEP:Holster(switchingTo)
	self:SendWeaponAnim(ACT_VM_HOLSTER)
	
	return true
end

-- Called when the SWEP is initialized.
function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	
	if (self.Owner:OnGround()) then
		if (SERVER) then
			self.Owner:ForceSequence("zapattack1", 1.5)
		end
		
		self.Owner:SetCycle(0) --stops the animation starting at random points in the sequence, credit to Viz for this fix
		
		local chargeSound = CreateSound(self.Owner, "npc/vort/attack_charge.wav")
		chargeSound:Play()
		
		ParticleEffectAttach("vortigaunt_charge_token", PATTACH_POINT_FOLLOW, self.Owner, self.Owner:LookupAttachment("leftclaw"))
		ParticleEffectAttach("vortigaunt_charge_token", PATTACH_POINT_FOLLOW, self.Owner, self.Owner:LookupAttachment("rightclaw"))
		
		timer.Simple(1.5, function()
			chargeSound:Stop()
			self.Owner:EmitSound("npc/vort/attack_shoot.wav")
			
			local tr = util.QuickTrace(self.Owner:EyePos(), self.Owner:EyeAngles():Forward()*5000, self.Owner)
			
			self.Owner:StopParticles()
			util.ParticleTracerEx("vortigaunt_beam", self.Owner:GetAttachment(self.Owner:LookupAttachment("leftclaw")).Pos,tr.HitPos, true, self.Owner:EntIndex(), self.Owner:LookupAttachment("leftclaw"))
			
			util.BlastDamage(self.Owner, self.Owner, tr.HitPos, 10, 400)
		end)
	end
end
