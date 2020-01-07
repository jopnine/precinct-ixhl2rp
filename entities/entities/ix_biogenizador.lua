AddCSLuaFile()



ENT.Type = "anim"
ENT.PrintName = "Biogenizador"
ENT.Category = "AlfaScience"
ENT.Author = "Alface"
ENT.Purpose = "Fazer biogel com alguns itens interessantes."
ENT.Spawnable = true
ENT.AdminOnly = true

-- em caso algum modifique isso:
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Grub")
	self:NetworkVar("Int", 1, "Sucata")
	self:NetworkVar("Int", 2, "Bateria")
end
--

if SERVER then

    function ENT:Initialize()
        self:SetPos(self:GetPos() + Vector(0,0,40))
        self:SetModel("models/xqm/hydcontrolbox.mdl") 
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_NONE)
        self:SetUseType(SIMPLE_USE)
        self:SetMaxHealth(100)
        self:SetSucata(0)
        self:SetGrub(0)	
        local phys = self:GetPhysicsObject()
        if phys and phys:IsValid() then
            phys:Wake()
        end 
      end
    end

    function ENT:Use(ply)
if self:GetBateria() >= 1 then
if self:GetGrub() == 4 and self:GetSucata() == 4 then
    local nome_item = "health_vial"
    local btp = self:GetBateria()-1 	
    ix.util.Notify("Você criou um "..nome_item.." e ele está ao lado da máquina.",ply)
    ix.item.Spawn("health_vial", self:GetPos(), function(itemTable, entity)
    	local physics = entity:GetPhysicsObject()
    	entity:SetMoveType(MOVETYPE_VPHYSICS)
		entity:SetNotSolid(false)

			if (IsValid(physics)) then
			 physics:EnableGravity(true)
			end
    	end)
	self:SetBateria(btp)
	self:SetGrub(0)
	self:SetSucata(0)
    ix.util.Notify("A bateria está agora, em "..btp.."/3.",ply)	
	print("[AlfaScience] "..ply:Nick().." craftou com o biogenizador, um "..nome_item..".")
else

   if self:GetGrub() == 0 then
   	self.gr = 2
   end
   if self:GetGrub() == 2 then
   	self.gr = 1
   end
   if self:GetGrub() == 4 then
   	self.gr = "nenhuma"
   end

   if self:GetSucata() == 0 then
   	self.sr = 2
   end
   if self:GetSucata() == 2 then
   	self.sr = 1
   end
   if self:GetSucata() == 4 then
   	self.sr = "nenhuma"
   end
 	ix.util.Notify("A máquina precisa de mais "..self.gr.." essência(s) de grub e "..self.sr.." metal(is) reciclado(s).",ply)
 end
  else
  	ix.util.Notify("A máquina precisa ser recarregada.", ply)
  end
end

    function ENT:Touch(ent)
  if ent:GetClass() == "ix_item" then   	
    	if ent:GetClass() == "ix_item" and ent:GetItemTable().uniqueID == "bateria" then
    		self:SetBateria(3)
    		ent:Remove()
    		ent:EmitSound("items/battery_pickup.wav",50)
    	end -- bateria
        
     if ent:GetClass() == "ix_item" then
     	if ent:GetItemTable().uniqueID == "essencia_grub" and self:GetGrub() < 4 then
           local grub = self:GetGrub()
           self:SetGrub(grub + 1)
           ent:Remove()          
         end-- grub
    end -- getclass ix item
        if self:GetGrub() == 1 then
        	self:EmitSound("npc/antlion_grub/squashed.wav", 75)
        end
        

        if self:GetGrub() == 3 then
        	self:EmitSound("npc/antlion_grub/squashed.wav", 75)  
        end        
        
        if ent:GetItemTable().uniqueID == "reclaimed_metal" and self:GetSucata() < 4 then
        	local sucata = self:GetSucata()
        	self:SetSucata(sucata + 1)
        	ent:Remove()
        end
        if self:GetSucata() == 1 then
        	self:EmitSound("phx/hmetal3.wav")
        
        end

        if self:GetSucata() == 3 then
        	self:EmitSound("phx/hmetal1.wav")  
        end
  end
 
end -- function ENT:Touch()

if CLIENT then
	function ENT:Draw()
        self:DrawModel()
    end
end



