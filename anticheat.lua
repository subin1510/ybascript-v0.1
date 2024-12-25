if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("HUD") then
    local HUD = game:GetService("ReplicatedStorage").Objects.HUD:Clone()
    HUD.Parent = game.Players.LocalPlayer.PlayerGui
end

game.Players.LocalPlayer.Character:WaitForChild("RemoteEvent"):FireServer("PressedPlay")

pcall(function()
    game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen1"):Destroy()
end)   

task.wait(.5)

pcall(function()
    game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen"):Destroy()
end)

pcall(function()
    workspace.LoadingScreen.Song.Playing = false
end)

pcall(function()
    for i,v in pairs(game.Lighting:GetChildren()) do
        if v.Name == "DepthOfField" then
            v.Enabled = false
        end
    end
end)
wait(1)
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
