------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
lia.command.add(
    "charWarn",
    {
        adminOnly = true,
        privilege = "Management - Warn Players",
        syntax = "<string name> <string text>",
        onRun = function(client, arguments)
            local target = lia.command.findPlayer(client, arguments[1])
            local tChar = target:getChar()
            local oldValue = tChar:getData("warn", 0)
            tChar:setData("warn", oldValue + 1)
            local newValue = tChar:getData("warn", 1)
            local ply = tChar:getPlayer()
            local reason = arguments[2] or ""
            if string.len(reason) < 1 then reason = "Not specified." end
            if newValue >= lia.config.WarnsTillBan then 
                tChar:ban(lia.config.BanTime)
                tChar:setData("warn", oldValue)
                target:notify("Your character has been blocked for exceeding the allowed number of warnings!")
               -- client:notify("The character " .. client:GetName() .. " has been blocked for exceeding the allowed number of warnings")
            end

            ply:ChatPrint("You received a warning from " .. client:GetName() .. " Reason: " .. reason .. ".")
            ply:notify("Total warnings: " .. newValue)
            ply:ChatPrint("You were frozen for " .. lia.config.FreezeTime .. " seconds. Please read the warning!")
            client:notify("Success!")
            ply:GodEnable()
            ply:Freeze(true)
            IsValid(ply)
            timer.Simple(
                lia.config.FreezeTime,
                function()
                    if IsValid(ply) then
                        ply:GodDisable()
                        ply:Freeze(false)
                    end
                end
            )
        end
    }
)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------