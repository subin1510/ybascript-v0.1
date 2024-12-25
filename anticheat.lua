
repeat
    wait()
until game:IsLoaded()

-- Check LoadingScreen1 removal or timeout
local startTime = tick()
repeat
    wait()
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen1") == nil then

local OldNamecallTP
OldNamecallTP = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
    local Arguments = {...}
    local Method = getnamecallmethod()
    if Method == "InvokeServer" and Arguments[1] == "idklolbrah2de" then
        return "  ___XP DE KEY"
    end
    if (Method == "FireServer" or Method == "InvokeServer" or Method == "InvokeClient") and Arguments[1] == "Reset" and Arguments[3] ~= "kissinthehomiesgoodnight" then
        return wait(9e9)
    end

    return OldNamecallTP(self, ...)
end))

local itemHook;
itemHook = hookfunction(getrawmetatable(game.Players.LocalPlayer.Character.HumanoidRootPart.Position).__index, function(p,i)
    if getcallingscript().Name == "ItemSpawn" and i:lower() == "magnitude" then
        return 0
    end
    return itemHook(p,i)
end)
