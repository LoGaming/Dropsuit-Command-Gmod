net.Receive( "armorSend", function()
    local name = net.ReadString()
    
    if ( name == "nil" ) then
        hook.Remove( "HUDPaint", "armorDisplay" )
        return
    end
    
    local data = Armor:Get( name )
    
    if ( !data ) then return end
    
    local stamp = CurTime() + data.Length
    
    hook.Add( "HUDPaint", "armorDisplay", function()
        local w = ScrW()
        
        draw.SimpleTextOutlined( data.Name, "Trebuchet24", w/2, 8, data.Color or color_white, 1, TEXT_ALIGN_LEFT, 1, data.OutlineColor or Color( 60, 157, 208 ))
        draw.SimpleTextOutlined( "("..data.Description..")", "Trebuchet18", w/2, 32, color_white, 1, TEXT_ALIGN_LEFT, 1, Color( 60, 157, 208 ) )
        
        if ( !Armor.Save ) then
            draw.SimpleTextOutlined( math.floor( stamp - CurTime() ).." seconds left", "Trebuchet18", w/2, 41, color_white, 1, TEXT_ALIGN_LEFT, 1, Color( 60, 157, 208 ) )
        end
    end )
end )
