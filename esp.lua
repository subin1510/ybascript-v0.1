-- Wait until "LoadingScreen1" becomes nil
while game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen1") ~= nil do
    wait(0.1)  -- Wait for a small amount of time (0.1 seconds) before checking again
end

wait(3.5)  
local espObjects = {}  -- Table to store created ESPs

-- Function to create ESP for an item
local function createESP(part, espText, espColor)
    -- Check if ESP has already been created for this part
    if espObjects[part] then return end

    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Adornee = part
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 5, 0)  -- Position ESP above the part
    billboardGui.AlwaysOnTop = true  -- Ensure ESP is always on top of other parts

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboardGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = espText  -- Display the name from the ProximityPrompt or the default name
    textLabel.TextColor3 = espColor  -- Text color (as specified by the user)
    textLabel.TextSize = 14
    textLabel.TextStrokeTransparency = 0.8

    billboardGui.Parent = part
    
    -- Store it to avoid creating the ESP for the same object again
    espObjects[part] = billboardGui
end

-- Function to check all objects in game.Workspace.Item_Spawns.Items
local function checkItems()
    while true do  -- Infinite loop
        for _, item in pairs(game.Workspace.Item_Spawns.Items:GetChildren()) do
            if item:IsA("Model") then
                -- Check parts inside the Model
                for _, part in pairs(item:GetChildren()) do
                    if part:IsA("Part") then
                        -- Check if the Part has children like PointLight, SurfaceAppearance
                        local checkNames = {"PointLight", "SurfaceAppearance"}
                        for _, name in ipairs(checkNames) do
                            if part:FindFirstChild(name) then
                                -- Check if ProximityPrompt exists and get the name from it
                                local proximityPrompt = item:FindFirstChild("ProximityPrompt")
                                local espText = "Unknown"  -- Default is Unknown if ProximityPrompt is not found
                                local espColor = Color3.fromRGB(255, 0, 0)  -- Default color is red
                                
                                if proximityPrompt then
                                    espText = proximityPrompt.ObjectText or "Unknown"  -- Get name from ProximityPrompt
                                    
                                    -- Check and change color based on ProximityPrompt name
                                    if espText == "Rokakaka" then
                                        espColor = Color3.fromRGB(255, 0, 0)  -- Red
                                    elseif espText == "Pure Rokakaka" then
                                        espColor = Color3.fromRGB(255, 105, 180)  -- Pink
                                    elseif espText == "Diamond" then
                                        espColor = Color3.fromRGB(0, 0, 255)  -- Blue
                                    elseif espText == "Dio's Diary" then
                                        espColor = Color3.fromRGB(255, 215, 0)  -- Dark Yellow
                                    elseif espText == "Steel Ball" then
                                        espColor = Color3.fromRGB(0, 128, 0)  -- Green
                                    elseif espText == "Rib Cage of The Saint's Corpse" then
                                        espColor = Color3.fromRGB(169, 169, 169)  -- Gray
                                    elseif espText == "Stone Mask" then
                                        espColor = Color3.fromRGB(0, 0, 0)  -- Black
                                    elseif espText == "Gold Coin" then
                                        espColor = Color3.fromRGB(255, 215, 0)  -- Dark Yellow
                                    elseif espText == "Quinton's Glove" then
                                        espColor = Color3.fromRGB(255, 0, 0)  -- Red
                                    elseif espText == "Ancient Scroll" then
                                        espColor = Color3.fromRGB(255, 255, 0)  -- Yellow
                                    elseif espText == "Caesar's Headband" then
                                        espColor = Color3.fromRGB(128, 0, 128)  -- Purple
                                    elseif espText == "Mysterious Arrow" then
                                        espColor = Color3.fromRGB(255, 215, 0)  -- Dark Yellow
                                    elseif espText == "Zeppeli's Hat" then
                                        espColor = Color3.fromRGB(255, 255, 255)  -- White
                                    elseif espText == "Clackers" then
                                        espColor = Color3.fromRGB(0, 0, 0)  -- Black
                                    elseif espText == "Lucky Arrow" then
                                        espColor = Color3.fromRGB(255, 0, 255)  -- Purple (or rainbow if impossible)
                                    elseif espText == "Blue Candy" then
                                        espColor = Color3.fromRGB(0, 0, 255)  -- Blue
                                    elseif espText == "Red Candy" then
                                        espColor = Color3.fromRGB(255, 0, 0)  -- Red
                                    elseif espText == "Green Candy" then
                                        espColor = Color3.fromRGB(0, 255, 0)  -- Green
                                    elseif espText == "Yellow Candy" then
                                        espColor = Color3.fromRGB(255, 255, 0)  -- Yellow
                                    else
                                        espColor = Color3.fromRGB(255, 0, 0)  -- Default red color for unknown items
                                    end
                                end
                                
                                -- Create ESP for Part and display name from ProximityPrompt with specified color
                                createESP(part, espText, espColor)
                                break  -- No need to check further once ESP is created
                            end
                        end
                    end
                end

                -- Check MeshParts inside the Model
                for _, meshPart in pairs(item:GetChildren()) do
                    if meshPart:IsA("MeshPart") then
                        -- Check if MeshPart has children like PointLight, SurfaceAppearance
                        local checkNames = {"PointLight", "SurfaceAppearance"}
                        for _, name in ipairs(checkNames) do
                            if meshPart:FindFirstChild(name) then
                                -- Check if ProximityPrompt exists and get the name from it
                                local proximityPrompt = item:FindFirstChild("ProximityPrompt")
                                local espText = "Unknown"  -- Default is Unknown if ProximityPrompt is not found
                                local espColor = Color3.fromRGB(255, 0, 0)  -- Default color is red
                                
                                if proximityPrompt then
                                    espText = proximityPrompt.ObjectText or "Unknown"  -- Get name from ProximityPrompt
                                    
                                    -- Check and change color based on ProximityPrompt name
                                    if espText == "Rokakaka" then
                                        espColor = Color3.fromRGB(255, 0, 0)  -- Red
                                    elseif espText == "Pure Rokakaka" then
                                        espColor = Color3.fromRGB(255, 105, 180)  -- Pink
                                    elseif espText == "Diamond" then
                                        espColor = Color3.fromRGB(0, 0, 255)  -- Blue
                                    elseif espText == "Dio's Diary" then
                                        espColor = Color3.fromRGB(255, 215, 0)  -- Dark Yellow
                                    elseif espText == "Steel Ball" then
                                        espColor = Color3.fromRGB(0, 128, 0)  -- Green
                                    elseif espText == "Rib Cage of The Saint's Corpse" then
                                        espColor = Color3.fromRGB(169, 169, 169)  -- Gray
                                    elseif espText == "Stone Mask" then
                                        espColor = Color3.fromRGB(0, 0, 0)  -- Black
                                    elseif espText == "Gold Coin" then
                                        espColor = Color3.fromRGB(255, 215, 0)  -- Dark Yellow
                                    elseif espText == "Quinton's Glove" then
                                        espColor = Color3.fromRGB(255, 0, 0)  -- Red
                                    elseif espText == "Ancient Scroll" then
                                        espColor = Color3.fromRGB(255, 255, 0)  -- Yellow
                                    elseif espText == "Caesar's Headband" then
                                        espColor = Color3.fromRGB(128, 0, 128)  -- Purple
                                    elseif espText == "Mysterious Arrow" then
                                        espColor = Color3.fromRGB(255, 215, 0)  -- Dark Yellow
                                    elseif espText == "Zeppeli's Hat" then
                                        espColor = Color3.fromRGB(255, 255, 255)  -- White
                                    elseif espText == "Clackers" then
                                        espColor = Color3.fromRGB(0, 0, 0)  -- Black
                                    elseif espText == "Lucky Arrow" then
                                        espColor = Color3.fromRGB(255, 0, 255)  -- Purple (or rainbow if impossible)
                                    elseif espText == "Blue Candy" then
                                        espColor = Color3.fromRGB(0, 0, 255)  -- Blue
                                    elseif espText == "Red Candy" then
                                        espColor = Color3.fromRGB(255, 0, 0)  -- Red
                                    elseif espText == "Green Candy" then
                                        espColor = Color3.fromRGB(0, 255, 0)  -- Green
                                    elseif espText == "Yellow Candy" then
                                        espColor = Color3.fromRGB(255, 255, 0)  -- Yellow
                                    else
                                        espColor = Color3.fromRGB(255, 0, 0)  -- Default red color for unknown items
                                    end
                                end
                                
                                -- Create ESP for MeshPart and display name from ProximityPrompt with specified color
                                createESP(meshPart, espText, espColor)
                                break  -- No need to check further once ESP is created
                            end
                        end
                    end
                end
            end
        end
        wait(0.00001)
    end
end

-- Start checking items
checkItems()
