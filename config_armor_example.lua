--Edit Config Here
Armor.Save = true // if set to true, all armors will be permanent and save
Armor.LoseOnDeath = true // if set to true, it removes when you die.

Armor:Add({
	Name = "PowerArmor", // name it appears in the sandbox menu and darkrp menu
    Color = Color( 255 , 0, 255 ),
    OutlineColor = Color( 173 , 216 , 230 ),
	Length = ( 600 * 1 ), // how long does it last
	Description = "+15% Run Speed. +250 Armor, +100 Health,) (Jump Boosters Activated", // description shown when using the suit
	Model = "models/player/swat.mdl", // what your model changes to
	Entitie = "armor_power", // the entitie name for the armor
	Price = 40000, // how much it costs
	OnGive = function( ply ) // what happens when they get the suit equipped
		ply:SetArmor( 250 )
		ply:SetHealth( 200 )
		ply:SetJumpPower( 300 ) 
		
		ply._oldRunSpeed = ply:GetRunSpeed()
		ply:SetRunSpeed( ply:GetRunSpeed() + ( ply:GetRunSpeed() * .15 ) )
	end,
	OnRemove = function( ply ) // what happens when the suit is removed
		ply:SetArmor( 0 )
		ply:SetHealth( 100 )
		ply:SetJumpPower( 200 )
		
		if ( ply._oldRunSpeed ) then
			ply:SetRunSpeed( ply._oldRunSpeed )
			ply._oldRunSpeed = nil
		end
	end,
})
