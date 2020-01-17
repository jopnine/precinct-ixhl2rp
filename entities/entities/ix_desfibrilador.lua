
SWEP.Category 				= "AlfaScience"
SWEP.PrintName				= "Desfibrilador"
SWEP.Slot					= 1
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true


SWEP.ViewModelFlip 			= false
SWEP.UseHands				= true
SWEP.ViewModel 				= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel 			= "models/weapons/w_crowbar.mdl"
SWEP.Author					= "Alface"
SWEP.Instructions			= "LMB para reviver algum personagem ou para causar danos elétricos. \n--By Alface."

SWEP.Spawnable				= true

SWEP.Primary.Damage         = 6
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Delay 			= 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Delay 		= 2


function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:Reload()
end 

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
		local data = {}
		data.start = self.Owner:GetShootPos()
		data.endpos = data.start + self.Owner:GetAimVector()*72
		data.filter = self.Owner
		local trace = util.TraceLine(data)
		local effect = EffectData()
		effect:SetStart(trace.HitPos)
		effect:SetNormal(trace.HitNormal)
		effect:SetOrigin(trace.HitPos)
		util.Effect("StunstickImpact", effect, true, true)
		self:EmitSound("Weapon_StunStick.Swing")
	end

function SWEP:PrimaryAttack()


	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	local e = self.Owner:GetEyeTrace().Entity
	print(e:GetClass())
	print(e:GetOwner())
	print(e:Health())
	if not IsValid( self.Owner ) then return end
	
	if not IsValid(e) or e:GetPos():Distance( self.Owner:GetPos() ) > 200 then return end
	
	if e:GetClass() == "player" then
		e:SetHealth(e:Health() - 6)
			local data = {}
		data.start = self.Owner:GetShootPos()
		data.endpos = data.start + self.Owner:GetAimVector()*72
		data.filter = self.Owner
		local trace = util.TraceLine(data)
		local effect = EffectData()
		effect:SetStart(trace.HitPos)
		effect:SetNormal(trace.HitNormal)
		effect:SetOrigin(trace.HitPos)
		util.Effect("StunstickImpact", effect, true, true)
		self.Owner:EmitSound("Weapon_StunStick.Melee_HitWorld")

		print("[ALFASCIENCE] O jogador "..self.Owner:Nick().." agrediu "..e:Nick().." com um desfibrilador, dando 6 de dano.")
	end

	if e:GetClass() == "prop_ragdoll" then
		
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		ix.util.Notify("O jogador foi desfibrilado.", self.Owner)
		print("[ALFASCIENCE] O jogador "..self.Owner:Nick().." desfibrilou um jogador.")
		local data = {}
		data.start = self.Owner:GetShootPos()
		data.endpos = data.start + self.Owner:GetAimVector()*72
		data.filter = self.Owner
		local trace = util.TraceLine(data)
		local effect = EffectData()
		effect:SetStart(trace.HitPos)
		effect:SetNormal(trace.HitNormal)
		effect:SetOrigin(trace.HitPos)
		util.Effect("StunstickImpact", effect, true, true)
		

		self.Owner:EmitSound("Weapon_StunStick.Melee_HitWorld")
    	e:Remove()
	end
			
end

function SWEP:Deploy()
   return true
end
function SWEP:Initialize()
	self:SetHoldType( "weapon_crowbar" )
end

function SWEP:Holster()
	return true
end