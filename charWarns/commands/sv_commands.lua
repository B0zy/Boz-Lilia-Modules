------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
lia.command.add(
    "charWarn",
    {
        adminOnly = true,
        privilege = "Management - Warn Players",
        syntax = "<string name> <string reason>",
        onRun = function(client, arguments)
            local target = lia.command.findPlayer(client, arguments[1])
            local tChar = target:getChar()
            local oldValue = tChar:getData("warn", 0)
            tChar:setData("warn", oldValue + 1)
            local newValue = tChar:getData("warn", 1)
            local reason = table.concat(arguments, " ", 2) or "" -- Concatenate arguments starting from index 2
            
            if string.len(reason) < 1 then
                reason = "Not specified."
            end
            if newValue >= lia.config.WarnsTillBan then 
                tChar:ban(lia.config.BanTime)
                tChar:setData("warn", oldValue)
                target:notify("Your character has been blocked for exceeding the allowed number of warnings!")
            end

            target:ChatPrint("You received a warning from " .. client:GetName() .. " Reason: " .. reason .. ".")
            target:notify("Total warnings: " .. newValue)
            target:ChatPrint("You were frozen for " .. lia.config.FreezeTime .. " seconds. Please read the warning!")
            client:notify("Success!")
            target:GodEnable()
            target:Freeze(true)
            IsValid(target)
            timer.Simple(
                lia.config.FreezeTime,
                function()
                    if IsValid(target) then
                        target:GodDisable()
                        target:Freeze(false)
                    end
                end
            )
        end
    }
)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------