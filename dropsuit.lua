-- Config (Change the settings here)

-- If you want a cooldown and delay on the dropsuit command put it here in seconds (0 to disable)
local DropsuitCooldown = 60 -- To prevent people resuiting to regain health multiple times in a fight

local SuitWillDrop = 3 -- To prevent people stealing others suits

-- If you want a custom messages change them here

local DropDelayMessage = "Your suit will drop in " .. tostring (DropsuitCooldown) .. " Seconds"

local SuitDropped = "You have dropped your suit"

local NoArmorEquipped = "You have no armor equipped"

local x = {
    commands = {"!dropsuit", "/dropsuit", "/droparmour", "!droparmour"}
}




-- Code (Ignore unless you know what your doing)

hook.Add("PlayerSay", "dropsuit", function(ply, txt)
    local cmd = string.Trim(txt)
    if table.HasValue(x.commands, cmd) then
        if !ply:Alive() then return "" end
        if ply:GetNWBool("GetIsStoringSuit") then return "" end
        if ply.armorSuit and ply:Alive() then
            if ply:GetNWBool("armor_dropsuit_cmd_cooldown") then
                ply:ChatPrint("You have wait " .. string.NiceTime(math.floor( timer.TimeLeft( "armor_dropsuit_cmd_cooldown" .. ply:EntIndex() ) )) .. " before you can drop the suit")
                return ""
            end

            ply:SetNWBool("GetIsStoringSuit", true)

            if SuitWillDrop > 0 then
                ply:ChatPrint(DropDelayMessage)
            end

            timer.Simple( SuitWillDrop, function()
            ply:SetNWBool("GetIsStoringSuit", false)
            local armor = ply.armorSuit
            local armorclass = Armor:Get(armor)
            local trace = {}
            trace.start = ply:EyePos()
            trace.endpos = trace.start + ply:GetAimVector() * 85
            trace.filter = ply
            local tr = util.TraceLine(trace)
            local dropped = ents.Create(armorclass.Entitie)
            if ply:Alive() then
                dropped:Spawn()
            ply:ChatPrint(SuitDropped)
            ply:removeArmorSuit()
            dropped:SetPos(tr.HitPos)
            if !timer.Exists("armor_dropsuit_cmd_cooldown" .. ply:EntIndex()) then
                ply:SetNWBool("armor_dropsuit_cmd_cooldown", true)
                timer.Create("armor_dropsuit_cmd_cooldown" .. ply:EntIndex(), DropsuitCooldown, 1, function()
                    ply:SetNWBool("armor_dropsuit_cmd_cooldown", false)
                end)
            end
        end
            end )
        else
            ply:ChatPrint(NoArmorEquipped)
        end

        return ""
    end
end)

