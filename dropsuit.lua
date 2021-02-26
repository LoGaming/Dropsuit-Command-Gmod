local config = {
    commands = {"/dropsuit", "/droparmor", "/droparmour"}
}

hook.Add("PlayerSay", "dropsuit", function(ply, txt)
    local cmd = string.Trim(txt)
    if table.HasValue(config.commands, cmd) then
        if ply.armorSuit then
            local armor = ply.armorSuit
            local armorclass = Armor:Get(armor)
            local trace = {}
            trace.start = ply:EyePos()
            trace.endpos = trace.start + ply:GetAimVector() * 85
            trace.filter = ply
            local tr = util.TraceLine(trace)
            local dropped = ents.Create(armorclass.Entitie)
            dropped:SetPos(tr.HitPos)
            dropped:Spawn()
            ply:removeArmorSuit()
            ply:ChatPrint("You Have Dropped Your Armor Suit!")
        else
            ply:ChatPrint("No Armor Equipped.")
        end
        return ""
    end
end)