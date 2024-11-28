local Library = {Notifications={}}
local Assist
Assist = {
    __index = function(self, index)
        return Library
    end;
    __call = function(self, index)
        local FirstIndex = index["Arguments"][1]
        local MemoryTable = index["Arguments"]

        table.remove(MemoryTable, 1)
        return Assist[index["Name"]](FirstIndex, MemoryTable)
    end;
}
Library.__index = Library
setmetatable(Assist, Assist)

--// Prerun
if game.CoreGui:FindFirstChild("XenonV3Lib") then
    game.CoreGui:FindFirstChild("XenonV3Lib"):Destroy()
end

--// Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

--// Alliases 
local u2 = UDim2.new
local v3 = Vector3.new
local pi = math.pi
local hf = hookfunction

function Assist.MakeTable(Name, Args)
    local Table = {["Name"] = Name}
    for i,v in pairs(Args) do
        Table[i] = v
    end
    return setmetatable(Table, Assist)
end

function Assist.GetAsset(Name)
    if Name ~= "Toggle" then
        for i,v in pairs(game.CoreGui:FindFirstChild("XenonV3Lib"):GetDescendants()) do
            if v.Name == Name then
                return v
            end
        end
    else
        for i,v in pairs(game.CoreGui:FindFirstChild("XenonV3Lib").Main.ScrollingFrame.Assets:GetChildren()) do
            if v.Name == Name then
                return v
            end
        end
    end
end

function Assist.Tween(inst, args)
    local tType, t, yield, pref = unpack(args)
    local Tween = TweenService:Create(inst, TweenInfo.new(pref and pref or t and t or 1), tType)
    Tween:Play()

    if yield then
        Tween.Completed:Wait()
    end
    return Tween
end

function RoundNumber(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function Tween(inst, tType, t, yield, pref)
    local Tween = TweenService:Create(inst, TweenInfo.new(pref and pref or t and t or 1), tType)
    Tween:Play()

    if yield then
        Tween.Completed:Wait()
    end
end --// Not rewriting to work with dropdowns

function Library.CreateLib(...)
    local LibTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            "XenonV3";

            ["UI"] = game:GetObjects("rbxassetid://12403182534")[1];
            ["Tabs"] = {};
            ["ToggleKey"] = Enum.KeyCode.RightAlt;
            ["BottomMenuToggleKey"] = Enum.KeyCode.RightControl;
            ["State"] = false;
            ["BottomState"] = false;
            ["Debounce"] = false;
        };
    });
    LibTable.UI.Parent = game.CoreGui
    LibTable.UI.Main.Visible = false
    LibTable.Toggle = function()
        LibTable.State = not LibTable.State
        LibTable.UI.Main.Visible = not LibTable.UI.Main.Visible
    end
    LibTable.ToggleBottom = function()
        LibTable.BottomState = not LibTable.BottomState
        LibTable.UI.TabHolder.Visible = not LibTable.UI.TabHolder.Visible
    end
    LibTable.Hide_All = function()
        for i,v in pairs(LibTable.UI.Main.ScrollingFrame:GetChildren()) do
            if v.Name ~= "Filter" and v.ClassName ~= "UIListLayout" and v.ClassName ~= "Folder" then
                v.Visible = false
            end
        end
    end
    LibTable.Show = function(show_tbl)
        for i,v in pairs(show_tbl) do
            v.Visible = true             
        end
    end
    LibTable.SetName = function(Name)
        LibTable.UI.Main.TopBar.Tab.Text = Name
    end
    LibTable.Ripple = function(asset, x, y)
        assert(x and y, "Please provide x and y coordinates!")
    
        coroutine.resume(coroutine.create(function()
             local New_Ripple = Assist({["Name"] = "GetAsset", ["Arguments"] = {"RippleAsset"}}):Clone()
             New_Ripple.Parent = asset
             New_Ripple.ImageTransparency = 0.6
             New_Ripple.Position = u2(0, (x-asset.AbsolutePosition.X), 0, (y-asset.AbsolutePosition.Y-36))
             New_Ripple.Size = u2(0, 0, 0, 0)
    
             local Length, Size = 0.6, (asset.AbsoluteSize.X >= asset.AbsoluteSize.Y and asset.AbsoluteSize.X * 1.5 or button.AbsoluteSize.Y * 1.5)
             local Tween = TweenService:Create(New_Ripple, TweenInfo.new(Length, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = u2(0, Size, 0, Size),
                Position = u2(0.5, (-Size / 2), 0.5, (-Size / 2)),
                ImageTransparency = 1
             })
             Tween:Play()
             Tween.Completed:Wait()
             New_Ripple:Destroy()
        end))
    end
    LibTable.InitDrag = function()
        local dragging, dragInput, dragStart, startPos

        local function update(input)
            local delta = input.Position - dragStart
            TweenService:Create(LibTable.UI.Main, TweenInfo.new(0.1), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end

        LibTable.UI.Main.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = LibTable.UI.Main.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        LibTable.UI.Main.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)

        UserInputService.TouchMoved:Connect(function(Input, IsTyping)
            if IsTyping then return end

            if dragging then
                update(Input)
            end
        end)
    end

    UserInputService.InputBegan:Connect(function(Key, IsTyping)
        if IsTyping then
            return
        end

        if Key.KeyCode == LibTable.ToggleKey then
            LibTable.Toggle()
        end

        if Key.KeyCode == LibTable.BottomMenuToggleKey then
            LibTable.ToggleBottom()
        end
    end)
    LibTable.UI.Main.Info.Close.MouseButton1Down:Connect(function()
        Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                LibTable.UI.Main.Info;
                {Position = u2(0.5, 0, 1, 0)};
                0.3;
            }
        })
    end)
    LibTable.InitDrag()

    return setmetatable(LibTable, Library)
end

function Library:Tab(Name, Icon)
    local TabTable = Assist({
       ["Name"] = "MakeTable";
       ["Arguments"] = {
            Name;

            ["Icon"] = "rbxassetid://"..Icon;
            ["Sections"] = {};
            ["Tweens"] = {};
            ["Tab"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"TabTemplate"}}):Clone();

            ["UI"] = self.UI;
            ["Self"] = self;
       }
    });
    TabTable.Update = function()
        TabTable.Tab.TabImage.Image = (Icon ~= nil and TabTable.Icon) or TabTable.Tab.TabImage.Image
        TabTable.Tab.Hide.TabName.TextLabel.Text = TabTable.Name
        TabTable.Tab.Visible = true
    end
    TabTable.CancelTweens = function()
        for i, tween in pairs(TabTable.Tweens) do
            tween:Cancel()
            table.remove(TabTable.Tweens, i)
        end
    end

    self.Tabs[#self.Tabs+1] = TabTable
    TabTable.Tab.Parent = self.UI.TabHolder:WaitForChild("Holder")
    TabTable.Update()

    TabTable.Tab.MouseEnter:Connect(function()
        TabTable.CancelTweens()

        local TextTween = TabTable.Tab.Hide.TabName
        local Tween = game:GetService("TweenService"):Create(TextTween, TweenInfo.new(0.2), {Position = u2(0.5, 0, 0.5, 0)})
        Tween:Play()

        table.insert(TabTable.Tweens, Tween)
    end)

    TabTable.Tab.MouseLeave:Connect(function()
        TabTable.CancelTweens()

        local TextTween = TabTable.Tab.Hide.TabName
        local Tween = game:GetService("TweenService"):Create(TextTween, TweenInfo.new(0.2), {Position = u2(0.5, 0, 1.55, 0)})
        Tween:Play()

        table.insert(TabTable.Tweens, Tween)
    end)

    TabTable.Tab.MouseButton1Down:Connect(function()
        self.Hide_All()
        self.Show(TabTable.Sections)
        self.SetName(TabTable.Name)
        if self.State == false then
            self.Toggle()
        end
    end)

    return setmetatable(TabTable, Library)
end

function Library:Section(Name)
    local SectionTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            Name;

            ["Assets"] = {};
            ["Drops"] = {};
            ["Tweens"] = {};
            ["State"] = false;
            ["Debounce"] = false;

            ["Section"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"Section"}}):Clone();
            ["Self"] = self["Self"];
        };
    });

    SectionTable.Update = function()
        SectionTable.Section.TopBar.Label.Text = SectionTable.Name
    end
    SectionTable.CancelTweens = function()
        for i, tween in pairs(SectionTable.Tweens) do
            tween:Cancel()
            table.remove(SectionTable.Tweens, i)
        end
    end
    SectionTable.In = function()
        --// Tween the container in
        SectionTable.State = false;
        SectionTable.Debounce = true;
        SectionTable.CancelTweens()
        local Tween4 = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SectionTable.Section.TopBar.Toggle,
                {Rotation = 0},
                0.2
            }
        })
        local Tween = game:GetService("TweenService"):Create(SectionTable.Section, TweenInfo.new(0.3), {Size = u2(0, 393, 0, 36)})
        Tween:Play()

        --Tween.Completed:Wait()
        local Tween1 = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SectionTable.Section.UICorner,
                {CornerRadius = UDim.new(0.2, 0)},
                0.6
            }
        })
        local Tween2 = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SectionTable.Section.TopBar.UICorner,
                {CornerRadius = UDim.new(0.25, 0)},
                0.6
            }
        })
        local Tween3 = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SectionTable.Section.TopBar.BottomCover.UICorner,
                {CornerRadius = UDim.new(0.5, 0)},
                0.6
            }
        })
        SectionTable.Section.TopBar.DropShadow.Visible = false

        table.insert(SectionTable.Tweens, Tween) table.insert(SectionTable.Tweens, Tween1) table.insert(SectionTable.Tweens, Tween2) table.insert(SectionTable.Tweens, Tween3) table.insert(SectionTable.Tweens, Tween4)
        Tween.Completed:Wait()
        task.wait(0.1)
        SectionTable.Debounce = false;
    end

    SectionTable.Out = function()
        --// Tween the container out
        SectionTable.State = true;
        SectionTable.Debounce = true;
        SectionTable.CancelTweens()
        local Tween1 = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SectionTable.Section.UICorner,
                {CornerRadius = UDim.new(0.025, 0)},
                0.1
            }
        })
        local Tween2 = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SectionTable.Section.TopBar.UICorner,
                {CornerRadius = UDim.new(0.25, 0)},
                0.1,
            }
        })
        local Tween3 = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SectionTable.Section.TopBar.Toggle,
                {Rotation = 180},
                0.2
            }
        })
        local Tween4 = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SectionTable.Section.TopBar.BottomCover.UICorner,
                {CornerRadius = UDim.new(0, 0)},
                0.1
            }
        })
        SectionTable.Section.TopBar.DropShadow.Visible = true
        local Tween = game:GetService("TweenService"):Create(SectionTable.Section, TweenInfo.new(0.3), {Size = u2(0, 393, 0, SectionTable.Section.Holder.UIListLayout.AbsoluteContentSize.Y + 60)})
        Tween:Play()
 
        table.insert(SectionTable.Tweens, Tween) table.insert(SectionTable.Tweens, Tween1) table.insert(SectionTable.Tweens, Tween2) table.insert(SectionTable.Tweens, Tween3) table.insert(SectionTable.Tweens, Tween4)
        Tween.Completed:Wait()
        task.wait(0.1)
        SectionTable.Debounce = false;
    end
    table.insert(self.Sections, SectionTable.Section)

    local UILayout = self.UI.Main.ScrollingFrame:FindFirstChildWhichIsA("UIListLayout")
    self.UI.Main.ScrollingFrame.CanvasSize = u2(0, 0, 0, UILayout.AbsoluteContentSize.Y + 2)

    UILayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.UI.Main.ScrollingFrame.CanvasSize = u2(0, 0, 0, UILayout.AbsoluteContentSize.Y + 2)
    end)

    SectionTable.Section.Parent = self.UI.Main.ScrollingFrame
    SectionTable.Update()

    SectionTable.Section.TopBar.Toggle.MouseButton1Down:Connect(function()
        if SectionTable.Debounce == true then return end
        if SectionTable.State then
            SectionTable.In()

            --[[for i,v in pairs(Container.Drops) do
                if v.State == false then
                    Tween(v.Asset, {Size = u2(0, 407 , 0, 50)}, 0.01)
                    Tween(v.Asset.Image, {Rotation = 0}, 0.01)
                end
            end--]]
        else
            SectionTable.Out()
        end

        while SectionTable.State == true do
            SectionTable.Section.Size = u2(0, 393, 0, SectionTable.Section.Holder.UIListLayout.AbsoluteContentSize.Y + 60)
            task.wait()
        end
    end)

    return setmetatable(SectionTable, Library)
end

function Library:Button(Name, Callback, Description)
    local ButtonTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            Name;

            ["Callback"] = Callback or function() print("No callback was connected!") end;
            ["Class"] = "Button";
            ["Description"] = Description or "The developer has not provided a description for this asset.";

            ["Tweens"] = {};
            ["Asset"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"Button"}}):Clone();
        };
    })
    ButtonTable.Update = function(...)
        ButtonTable.Asset.Label.Text = ButtonTable.Name
    end
    table.insert(self.Assets, ButtonTable.Asset)

    ButtonTable.Asset.Visible = true
    ButtonTable.Asset.Parent = self.Section.Holder
    ButtonTable.Update()

    ButtonTable.Asset.MouseButton1Down:Connect(function(X, Y)
        pcall(ButtonTable.Callback)
        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                ButtonTable.Asset.UIStroke,
                {Color = Color3.fromRGB(84, 111, 126)},
                0.1,
                true
            }
        })
        if ButtonTable.Asset.UIStroke.Color == Color3.fromRGB(84, 111, 126) then
            local Tween2 = Assist({
                ["Name"] = "Tween";
                ["Arguments"] = {
                    ButtonTable.Asset.UIStroke,
                    {Color = Color3.fromRGB(65, 86, 97)},
                    0.1,
                    false
                }
            })
        end
    end)

    ButtonTable.Asset.Info.MouseButton1Down:Connect(function(X, Y)
        Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                self["Self"].UI.Main.Info;
                {Position = u2(0.5, 0, 0.91, 0)};
                0.3;
            }
        })
        self["Self"].UI.Main.Info.Label.Text = ButtonTable.Description
    end)

    ButtonTable.Asset.MouseEnter:Connect(function()
        for i,v in pairs(ButtonTable.Tweens) do
            v:Cancel()
        end
        ButtonTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                ButtonTable.Asset.UIStroke,
                {Color = Color3.fromRGB(65, 86, 97)},
                0.1
            }
        })
        table.insert(ButtonTable.Tweens, Tween)
    end)

    ButtonTable.Asset.MouseLeave:Connect(function()
        for i,v in pairs(ButtonTable.Tweens) do
            v:Cancel()
        end
        ButtonTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                ButtonTable.Asset.UIStroke,
                {Color = Color3.fromRGB(44, 58, 66)},
                0.1
            }
        })
        table.insert(ButtonTable.Tweens, Tween)
    end)

    return setmetatable(ButtonTable, Library)
end

function Library:Toggle(Name, StartingState, Callback, Description, RunOnStart)
    local ToggleTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            Name;

            ["Callback"] = Callback or function() print("No callback was connected!") end;
            ["Class"] = "Toggle";
            ["Description"] = Description or "The developer has not provided a description for this asset.";
            ["State"] = StartingState;

            ["Tweens"] = {};
            ["Debounce"] = false;
            ["Asset"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"Toggle"}}):Clone();
        };
    })
    ToggleTable.Update = function(...)
        ToggleTable.Asset.Label.Text = ToggleTable.Name
        if ToggleTable.Debounce == true then return end

        ToggleTable.Debounce = true
        task.spawn(function()
            if ToggleTable.State == true then
                Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        ToggleTable.Asset.Outer.Inner,
                        {Position = u2(0.735, 0, 0.5, 0)},
                        0.3
                    }
                })
                Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        ToggleTable.Asset.Outer,
                        {BackgroundColor3 = Color3.fromRGB(44, 58, 66)},
                        0.3
                    }
                })
                Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        ToggleTable.Asset.Outer.UIStroke,
                        {Color = Color3.fromRGB(67, 88, 100)},
                        0.3
                    }
                })
                Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        ToggleTable.Asset.Outer.Inner,
                        {ImageColor3 = Color3.fromRGB(67, 88, 100)},
                        0.3,
                        true
                    }
                })
                ToggleTable.Debounce = false
            else
                Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        ToggleTable.Asset.Outer.Inner,
                        {Position = u2(0.265, 0, 0.5, 0)},
                        0.3
                    }
                })
                Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        ToggleTable.Asset.Outer,
                        {BackgroundColor3 = Color3.fromRGB(28, 37, 42)},
                        0.3
                    }
                })
                Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        ToggleTable.Asset.Outer.UIStroke,
                        {Color = Color3.fromRGB(44, 58, 66)},
                        0.3
                    }
                })
                Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        ToggleTable.Asset.Outer.Inner,
                        {ImageColor3 = Color3.fromRGB(44, 58, 66)},
                        0.3,
                        true
                    }
                })
                ToggleTable.Debounce = false
            end
        end)
    end
    table.insert(self.Assets, ToggleTable.Asset)

    ToggleTable.Asset.Visible = true
    ToggleTable.Asset.Parent = self.Section.Holder
    ToggleTable.Update()

    ToggleTable.Asset.MouseButton1Down:Connect(function(X, Y)
        if ToggleTable.Debounce == true then return end
        ToggleTable.State = not ToggleTable.State
        ToggleTable.Update()
        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                ToggleTable.Asset.UIStroke,
                {Color = Color3.fromRGB(84, 111, 126)},
                0.1,
                true
            }
        })
        if ToggleTable.Asset.UIStroke.Color == Color3.fromRGB(84, 111, 126) then
            local Tween2 = Assist({
                ["Name"] = "Tween";
                ["Arguments"] = {
                    ToggleTable.Asset.UIStroke,
                    {Color = Color3.fromRGB(65, 86, 97)},
                    0.1,
                    false
                }
            })
        end
        pcall(ToggleTable.Callback, ToggleTable.State)
        --self["Self"].Ripple(ToggleTable.Asset, X, Y)
    end)
    ToggleTable.Asset.Info.MouseButton1Down:Connect(function(X, Y)
        Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                self["Self"].UI.Main.Info;
                {Position = u2(0.5, 0, 0.91, 0)};
                0.3;
            }
        })
        self["Self"].UI.Main.Info.Label.Text = ToggleTable.Description
    end)

    ToggleTable.Asset.MouseEnter:Connect(function()
        for i,v in pairs(ToggleTable.Tweens) do
            v:Cancel()
        end
        ToggleTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                ToggleTable.Asset.UIStroke,
                {Color = Color3.fromRGB(65, 86, 97)},
                0.1
            }
        })
        table.insert(ToggleTable.Tweens, Tween)
    end)

    ToggleTable.Asset.MouseLeave:Connect(function()
        for i,v in pairs(ToggleTable.Tweens) do
            v:Cancel()
        end
        ToggleTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                ToggleTable.Asset.UIStroke,
                {Color = Color3.fromRGB(44, 58, 66)},
                0.1
            }
        })
        table.insert(ToggleTable.Tweens, Tween)
    end)

    if ToggleTable.State == true and RunOnStart then
        pcall(ToggleTable.Callback, ToggleTable.State)
    end
    
    return setmetatable(ToggleTable, Library)
end

function Library:Dropdown(Name, List, Callback, Description)
    local DropdownTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            Name;

            ["List"] = List;
            ["Callback"] = Callback or function() end;
            ["State"] = false;
            ["Class"] = "Dropdown";

            ["Tweens"] = {};
            ["Debounce"] = false;
            ["Description"] = Description or "The developer has not provided a description for this asset.";
            ["Asset"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"Dropdown"}}):Clone();

            ["Other"] = {
                ExtensionSize = 0
            };
        };
    })
    DropdownTable.Update = function(...)
        DropdownTable.Asset.Label.Text = DropdownTable.Name

        for _, v in pairs(DropdownTable.Asset.Holder.ScrollingFrame:GetChildren()) do
            if v:IsA("TextButton") then
                v:Destroy()
            end
        end --// Clear the dropdown
        DropdownTable.Asset.Holder.ScrollingFrame.UIListLayout.Padding = UDim.new(0, 7)
        DropdownTable.Asset.Holder.ScrollingFrame.Position = u2(0.5,0,0.5,0)

        --// Refresh with New ones
        local Template = Assist({["Name"] = "GetAsset", ["Arguments"] = {"DropButton"}})
        for i,v in pairs(DropdownTable.List) do
            local New_Template = Template:Clone()
            New_Template.Parent = DropdownTable.Asset.Holder.ScrollingFrame
            New_Template.Visible = true
            New_Template.Label.Text = v
            New_Template.Name = v
            local Tweens = {}

            New_Template.MouseButton1Down:Connect(function()
                if DropdownTable.State == true then
                    pcall(DropdownTable.Callback, v)
                    DropdownTable.Debounce = true
                    DropdownTable.State = not DropdownTable.State
                    Tween(DropdownTable.Asset, {Size = u2(0, 377 , 0, 43)}, 0.35)
                    Tween(DropdownTable.Asset.ListIcon, {ImageColor3 = Color3.fromRGB(65, 86, 97)}, 0.35)
                    --Tween(DropdownTable.Asset.Image, {Rotation = 0}, 0.35)
                    
                    task.wait(0.5)
                    DropdownTable.Debounce = false
                end
            end)
            New_Template.MouseEnter:Connect(function()
                for i,v in pairs(Tweens) do
                    v:Cancel()
                end
                Tweens = {}
        
                local Tween = Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        New_Template.UIStroke,
                        {Color = Color3.fromRGB(76, 101, 113)},
                        0.1
                    }
                })
                table.insert(Tweens, Tween)
            end)
            New_Template.MouseLeave:Connect(function()
                for i,v in pairs(Tweens) do
                    v:Cancel()
                end
                Tweens = {}
        
                local Tween = Assist({
                    ["Name"] = "Tween";
                    ["Arguments"] = {
                        New_Template.UIStroke,
                        {Color = Color3.fromRGB(65, 86, 97)},
                        0.1
                    }
                })
                table.insert(Tweens, Tween)
            end)
        end

        if #DropdownTable.List > 3 then
            local Content = DropdownTable.Asset.Holder.ScrollingFrame.UIListLayout.AbsoluteContentSize
            DropdownTable.Asset.Holder.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, Content.Y + 10);
            DropdownTable.Asset.Holder.ScrollingFrame.ScrollBarImageTransparency = 0
            DropdownTable.Asset.Holder.ScrollingFrame.ScrollingEnabled = true
        else
            DropdownTable.Asset.Holder.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
            DropdownTable.Asset.Holder.ScrollingFrame.ScrollBarImageTransparency = 1
            DropdownTable.Asset.Holder.ScrollingFrame.ScrollingEnabled = false
        end

        local Absolute = DropdownTable.Asset.Holder.ScrollingFrame.UIListLayout.AbsoluteContentSize
        DropdownTable.Other.ExtensionSize = Absolute.Y 
    
        if #DropdownTable.List > 3 then
            DropdownTable.Other.ExtensionSize = 133.8
        end
        
        if DropdownTable.State == true then
            DropdownTable.Debounce = true
            --Tween(self.Section, {Size = u2(0, 393 , 0, DropdownTable.Other.ExtensionSize.Outer)}, 0.35)
            Tween(DropdownTable.Asset, {Size = u2(0, 377 , 0, DropdownTable.Other.ExtensionSize + 62)}, 0.35)
            Tween(DropdownTable.Asset.Holder, {Size = u2(0, 366 , 0, DropdownTable.Other.ExtensionSize + 8)}, 0.35)
            Tween(DropdownTable.Asset.ListIcon, {ImageColor3 = Color3.fromRGB(84, 111, 126)}, 0.35)
            --Tween(DropdownTable.Asset.Image, {Rotation = 180}, 0.35)
            --Tween(self.Section, {Size = u2(self.Section.Size.X.Scale, self.Section.Size.X.Offset, self.Section.Size.Y.Scale, (self.Section.Size.Y.Offset + (DropdownTable.Other.ExtensionSize-50)))}, 0.35)

            task.wait(0.5)
            DropdownTable.Debounce = false
        end
    end
        
    table.insert(self.Assets, DropdownTable.Asset)
    table.insert(self.Drops, DropdownTable)

    DropdownTable.Asset.Visible = true
    DropdownTable.Asset.Parent = self.Section.Holder
    DropdownTable.Update()

    DropdownTable.Asset.MouseButton1Down:Connect(function(X, Y)
        if DropdownTable.Debounce then return end
		--Ripple(DropdownTable.Asset, X, Y)

        if DropdownTable.State and DropdownTable.Asset.Size.Y.Offset == 43 then
            DropdownTable.State = not DropdownTable.State
        end

        if DropdownTable.State then
            DropdownTable.Debounce = true
            DropdownTable.State = not DropdownTable.State
            Tween(DropdownTable.Asset, {Size = u2(0, 377, 0, 43)}, 0.35)
            Tween(DropdownTable.Asset.ListIcon, {ImageColor3 = Color3.fromRGB(65, 86, 97)}, 0.35)
            --Tween(DropdownTable.Asset.Image, {Rotation = 0}, 0.35)
            --Tween(self.Section, {Size = u2(self.Section.Size.X.Scale, self.Section.Size.X.Offset, self.Section.Size.Y.Scale, (self.Section.Size.Y.Offset - (DropdownTable.Other.ExtensionSize-50)))}, 0.35)
            task.wait(0.5)
            DropdownTable.Debounce = false
        else
            DropdownTable.Debounce = true
            DropdownTable.State = not DropdownTable.State
            --Tween(self.Section, {Size = u2(0, 393 , 0, DropdownTable.Other.ExtensionSize.Outer)}, 0.35)
            Tween(DropdownTable.Asset, {Size = u2(0, 377 , 0, DropdownTable.Other.ExtensionSize + 62)}, 0.35)
            Tween(DropdownTable.Asset.Holder, {Size = u2(0, 366 , 0, DropdownTable.Other.ExtensionSize + 8)}, 0.35)
            Tween(DropdownTable.Asset.ListIcon, {ImageColor3 = Color3.fromRGB(84, 111, 126)}, 0.35)
            --Tween(DropdownTable.Asset.Image, {Rotation = 180}, 0.35)
            --Tween(self.Section, {Size = u2(self.Section.Size.X.Scale, self.Section.Size.X.Offset, self.Section.Size.Y.Scale, (self.Section.Size.Y.Offset + (DropdownTable.Other.ExtensionSize-50)))}, 0.35)

            task.wait(0.5)
            DropdownTable.Debounce = false
        end
    end)
    
    DropdownTable.Asset.Info.MouseButton1Down:Connect(function(X, Y)
        Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                self["Self"].UI.Main.Info;
                {Position = u2(0.5, 0, 0.91, 0)};
                0.3;
            }
        })
        self["Self"].UI.Main.Info.Label.Text = DropdownTable.Description
    end)

    DropdownTable.Asset.MouseEnter:Connect(function()
        for i,v in pairs(DropdownTable.Tweens) do
            v:Cancel()
        end
        DropdownTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                DropdownTable.Asset.UIStroke,
                {Color = Color3.fromRGB(65, 86, 97)},
                0.1
            }
        })
        table.insert(DropdownTable.Tweens, Tween)
    end)

    DropdownTable.Asset.MouseLeave:Connect(function()
        for i,v in pairs(DropdownTable.Tweens) do
            v:Cancel()
        end
        DropdownTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                DropdownTable.Asset.UIStroke,
                {Color = Color3.fromRGB(44, 58, 66)},
                0.1
            }
        })
        table.insert(DropdownTable.Tweens, Tween)
    end)

    return setmetatable(DropdownTable, Library)
end

function Library:TextBox(Name, Callback, Description)
    local TextBoxTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            Name;

            ["Callback"] = Callback or function() end;
            ["CanCall"] = true;
            ["Class"] = "TextBox";
            ["Tweens"] = {};
            ["Description"] = Description or "The developer has not provided a description for this asset.";

            ["Asset"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"TextBox"}}):Clone();
        };
    })
    table.insert(self.Assets, TextBoxTable.Asset)

    TextBoxTable.Update = function(...)
        TextBoxTable.Asset.Label.Text = TextBoxTable.Name

        local Args = {...}
        if Args[1] then
            TextBoxTable.Asset.TextBoxInner.Text = Args[1]
            pcall(TextBoxTable.Callback, Args[1])
        end
    end

    TextBoxTable.Asset.Visible = true
    TextBoxTable.Asset.Parent = self.Section.Holder
    TextBoxTable.Update()

    TextBoxTable.Asset.TextBoxInner.Focused:Connect(function()
        if TextBoxTable.CanCall then
            TextBoxTable.Asset.TextBoxInner:ReleaseFocus()
        end
    end)

    TextBoxTable.Asset.MouseButton1Down:Connect(function(X, Y)
        if TextBoxTable.CanCall then
            TextBoxTable.CanCall = false
            --Ripple(TextBox.Asset, X, Y)

            Tween(TextBoxTable.Asset.TextBoxInner, {Size = u2(0, 128, 0, 30), Position = u2(0, 213, 0, 21)}, 0.2)
            TextBoxTable.Asset.TextBoxInner:CaptureFocus()
            TextBoxTable.Asset.TextBoxInner.FocusLost:Wait()
            Tween(TextBoxTable.Asset.TextBoxInner, {Size = u2(0, 91, 0, 30), Position = u2(0, 250, 0, 21)}, 0.2)
            pcall(TextBoxTable.Callback, TextBoxTable.Asset.TextBoxInner.Text)
				
            task.wait(0.2)
            TextBoxTable.CanCall = true
        end
    end)

    TextBoxTable.Asset.Info.MouseButton1Down:Connect(function(X, Y)
        Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                self["Self"].UI.Main.Info;
                {Position = u2(0.5, 0, 0.91, 0)};
                0.3;
            }
        })
        self["Self"].UI.Main.Info.Label.Text = TextBoxTable.Description
    end)

    TextBoxTable.Asset.MouseEnter:Connect(function()
        for i,v in pairs(TextBoxTable.Tweens) do
            v:Cancel()
        end
        TextBoxTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                TextBoxTable.Asset.UIStroke,
                {Color = Color3.fromRGB(65, 86, 97)},
                0.1
            }
        })
        table.insert(TextBoxTable.Tweens, Tween)
    end)

    TextBoxTable.Asset.MouseLeave:Connect(function()
        for i,v in pairs(TextBoxTable.Tweens) do
            v:Cancel()
        end
        TextBoxTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                TextBoxTable.Asset.UIStroke,
                {Color = Color3.fromRGB(44, 58, 66)},
                0.1
            }
        })
        table.insert(TextBoxTable.Tweens, Tween)
    end)

    return setmetatable(TextBoxTable, Library)
end

function Library:Keybind(Name, Starting_Key, Callback, Description, Blacklisted_Keys)
    local KeybindTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            Name;

            ["Key"] = Starting_Key or Enum.KeyCode.E;
            ["Blacklist"] = Blacklisted_Keys or {"W", "A", "S", "D"};
            ["Callback"] = Callback or function() end;
            ["Debounce"] = false;
            ["Class"] = "Keybind";
            ["Tweens"] = {};
    
            ["Asset"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"Keybind"}}):Clone();
            ["Connections"] = {In_Change = false};
            ["Description"] = Description or "The developer has not provided a description for this asset.";
        };
    })
    table.insert(self.Assets, KeybindTable.Asset)

    KeybindTable.GetKeystringFromEnum = function(Key)
        if Key == "..." then return "..." end
        return tostring(Key):split(".")[3]
    end

    KeybindTable.ValidKey = function(Key)
        return (typeof(Key) == "EnumItem")
    end

    KeybindTable.IsNotMouse = function(Key)
        return (Key.UserInputType == Enum.UserInputType.MouseButton1 or Key.UserInputType == Enum.UserInputType.MouseButton2)
    end

    KeybindTable.Update = function(...)
        KeybindTable.Asset.Label.Text = KeybindTable.Name
        KeybindTable.Asset.Frame.Text = KeybindTable.GetKeystringFromEnum(KeybindTable.Key)
        Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                KeybindTable.Asset.Frame;
                {
                    Position = u2(0.845, -((KeybindTable.Asset.Frame.TextBounds.X-25)+10), 0.5, 0);
                    Size = u2(0, (KeybindTable.Asset.Frame.TextBounds.X + 10), 0, 25)
                };
                0.1;
            }
        })
    end

    KeybindTable.Asset.Visible = true
    KeybindTable.Asset.Parent = self.Section.Holder
    KeybindTable.Update()

    KeybindTable.Connections.KeyPress = game:GetService("UserInputService").InputBegan:Connect(function(Input, GameProcessedEvent)
        if GameProcessedEvent then return end

        if Input.KeyCode == KeybindTable.Key and not KeybindTable.Connections.In_Change == true then
            pcall(KeybindTable.Callback)
        end
    end)

    KeybindTable.Asset.MouseButton1Down:Connect(function(X, Y)
        if not KeybindTable.Debounce then
            KeybindTable.Debounce = true
            KeybindTable.Connections.In_Change = true
            --Ripple(KeybindTable.Asset, X, Y)

            local Continue = false
            local Cache = {}
            Cache.OldText = KeybindTable.Name
            Cache.OldKey = KeybindTable.Key

            KeybindTable.Name = KeybindTable.Name
            KeybindTable.Key = "..."
            KeybindTable.Update()

            KeybindTable.Connections.Change_Connection = game:GetService("UserInputService").InputBegan:Connect(function(Input, GameProcessedEvent)
                if GameProcessedEvent then return end
                if KeybindTable.IsNotMouse(Input) then return end

                if Input.KeyCode == Enum.KeyCode.Return then
                    Continue = true
                    KeybindTable.Key = Cache.OldKey
                    KeybindTable.Connections.Change_Connection:Disconnect()

                    KeybindTable.Update()  
                end

                if not Continue and not table.find(KeybindTable.Blacklist, KeybindTable.GetKeystringFromEnum(Input.KeyCode)) then
                    KeybindTable.Key = Input.KeyCode
                    KeybindTable.Update()
                    Continue = true

                    pcall(KeybindTable.Callback, KeybindTable.GetKeystringFromEnum(KeybindTable.Key))
                    KeybindTable.Connections.Change_Connection:Disconnect()
                end
            end)
            repeat wait() until Continue
            KeybindTable.Name = Cache.OldText
            KeybindTable.Connections.In_Change = false
            Cache = nil

            KeybindTable.Update()
            wait(0.5)
            KeybindTable.Debounce = false
        end
    end)

    KeybindTable.Asset.Info.MouseButton1Down:Connect(function(X, Y)
        Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                self["Self"].UI.Main.Info;
                {Position = u2(0.5, 0, 0.91, 0)};
                0.3;
            }
        })
        self["Self"].UI.Main.Info.Label.Text = KeybindTable.Description
    end)

    KeybindTable.Asset.MouseEnter:Connect(function()
        for i,v in pairs(KeybindTable.Tweens) do
            v:Cancel()
        end
        KeybindTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                KeybindTable.Asset.UIStroke,
                {Color = Color3.fromRGB(65, 86, 97)},
                0.1
            }
        })
        table.insert(KeybindTable.Tweens, Tween)
    end)

    KeybindTable.Asset.MouseLeave:Connect(function()
        for i,v in pairs(KeybindTable.Tweens) do
            v:Cancel()
        end
        KeybindTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                KeybindTable.Asset.UIStroke,
                {Color = Color3.fromRGB(44, 58, 66)},
                0.1
            }
        })
        table.insert(KeybindTable.Tweens, Tween)
    end)

    return setmetatable(KeybindTable, Library)
end

function Library:Slider(Name, Min, Max, Start, Callback, Precise, Description)
    local SliderTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            Name;

            ["Min"] = Min or 0;
            ["Max"] = Max or 100;
            ["Value"] = Start or 0;
            ["Callback"] = Callback or function() end;
            ["Class"] = "Slider";
            ["Dragging"] = false;
            ["Precise"] = Precise or false;
    
            ["Tweens"] = {};
            ["Asset"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"Slider"}}):Clone();
            ["Description"] = Description or "The developer has not provided a description for this asset.";
        };
    })
    table.insert(self.Assets, SliderTable.Asset)

   SliderTable.Update = function(...)
        SliderTable.Asset.Label.Text = SliderTable.Name

        local New = SliderTable.Value
        SliderTable.Asset.Slider.Fill:TweenSize(UDim2.new((New - SliderTable.Min)/(SliderTable.Max - SliderTable.Min), 0, 1, 0), "Out", "Sine", 0.1, true)
        SliderTable.Asset.Percentage.Text = tostring(New)

        --[[
        if bool then
            pcall(Slider.Callback, New)
        end--]]
    end

    SliderTable.Asset.Name = SliderTable.Name
    SliderTable.Asset.Visible = true
    SliderTable.Asset.Parent = self.Section.Holder
    SliderTable.Update()

    SliderTable.Asset.Slider.Fill.Circle.InputBegan:Connect(
        function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                SliderTable.Dragging = true
                SliderTable.Asset.Slider.Fill.CircleEffect:TweenSize(u2(0, 15 + ((SliderTable.Value / SliderTable.Max) * 5), 0, 15 + ((SliderTable.Value / SliderTable.Max) * 5)), "Out", "Quad", 0.1, true);
            end
        end
    )
    SliderTable.Asset.Slider.Fill.Circle.InputEnded:Connect(
        function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                SliderTable.Dragging = false
                SliderTable.Asset.Slider.Fill.CircleEffect:TweenSize(u2(0, 0, 0, 0), "Out", "Quad", 0.1, true);
            end
        end
    )

    UserInputService.InputChanged:Connect(
    function(Input)
        if SliderTable.Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
            local Bound = SliderTable.Asset.Slider.AbsoluteSize.X
            local Pos1 =
                UDim2.new(
                    math.clamp((Input.Position.X - SliderTable.Asset.Slider.Fill.AbsolutePosition.X) / Bound, 0, 1),
                    0,
                    1,
                    0
                )
            SliderTable.Asset.Slider.Fill:TweenSize(Pos1, "Out", "Sine", 0.1, true)
            SliderTable.Value = (SliderTable.Precise and RoundNumber((((Pos1.X.Scale * SliderTable.Max) / SliderTable.Max) * (SliderTable.Max - SliderTable.Min) + SliderTable.Min), 1) or math.floor((((Pos1.X.Scale * SliderTable.Max) / SliderTable.Max) * (SliderTable.Max - SliderTable.Min) + SliderTable.Min)))
            SliderTable.Asset.Percentage.Text = tostring(SliderTable.Value)
            SliderTable.Asset.Slider.Fill.CircleEffect:TweenSize(u2(0, 15 + ((SliderTable.Value / SliderTable.Max) * 5), 0, 15 + ((SliderTable.Value / SliderTable.Max) * 5)), "Out", "Quad", 0.01, true);
            pcall(SliderTable.Callback, SliderTable.Value)
        end
    end
    )

    UserInputService.TouchMoved:Connect(
    function(Input)
        if SliderTable.Dragging then
            local Bound = SliderTable.Asset.Slider.AbsoluteSize.X
            local Pos1 =
                UDim2.new(
                    math.clamp((Input.Position.X - SliderTable.Asset.Slider.Fill.AbsolutePosition.X) / Bound, 0, 1),
                    0,
                    1,
                    0
                )
            SliderTable.Asset.Slider.Fill:TweenSize(Pos1, "Out", "Sine", 0.1, true)
            SliderTable.Value = (SliderTable.Precise and RoundNumber((((Pos1.X.Scale * SliderTable.Max) / SliderTable.Max) * (SliderTable.Max - SliderTable.Min) + SliderTable.Min), 1) or math.floor((((Pos1.X.Scale * SliderTable.Max) / SliderTable.Max) * (SliderTable.Max - SliderTable.Min) + SliderTable.Min)))
            SliderTable.Asset.Percentage.Text = tostring(SliderTable.Value)
            SliderTable.Asset.Slider.Fill.CircleEffect:TweenSize(u2(0, 15 + ((SliderTable.Value / SliderTable.Max) * 5), 0, 15 + ((SliderTable.Value / SliderTable.Max) * 5)), "Out", "Quad", 0.01, true);
            pcall(SliderTable.Callback, SliderTable.Value)
        end
    end
    )

    SliderTable.Asset.Info.MouseButton1Down:Connect(function(X, Y)
        Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                self["Self"].UI.Main.Info;
                {Position = u2(0.5, 0, 0.91, 0)};
                0.3;
            }
        })
        self["Self"].UI.Main.Info.Label.Text = SliderTable.Description
    end)

    SliderTable.Asset.MouseEnter:Connect(function()
        for i,v in pairs(SliderTable.Tweens) do
            v:Cancel()
        end
        SliderTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SliderTable.Asset.UIStroke,
                {Color = Color3.fromRGB(65, 86, 97)},
                0.1
            }
        })
        table.insert(SliderTable.Tweens, Tween)
    end)

    SliderTable.Asset.MouseLeave:Connect(function()
        for i,v in pairs(SliderTable.Tweens) do
            v:Cancel()
        end
        SliderTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                SliderTable.Asset.UIStroke,
                {Color = Color3.fromRGB(44, 58, 66)},
                0.1
            }
        })
        table.insert(SliderTable.Tweens, Tween)
    end)

    return setmetatable(SliderTable, Library)
end

function Library:Label(Text)
    local LabelTable = Assist({
        ["Name"] = "MakeTable";
        ["Arguments"] = {
            Text;

            ["Tweens"] = {};
            ["Class"] = "Label";
            ["Asset"] = Assist({["Name"] = "GetAsset", ["Arguments"] = {"LabelAsset"}}):Clone();
        };
    })
    LabelTable.Update = function(...)
        LabelTable.Asset.Label.Text = LabelTable.Name
    end

    table.insert(self.Assets, LabelTable)

    LabelTable.Asset.Visible = true
    LabelTable.Asset.Parent = self.Section.Holder
    LabelTable.Update()

    LabelTable.Asset.MouseEnter:Connect(function()
        for i,v in pairs(LabelTable.Tweens) do
            v:Cancel()
        end
        LabelTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                LabelTable.Asset.UIStroke,
                {Color = Color3.fromRGB(65, 86, 97)},
                0.1
            }
        })
        table.insert(LabelTable.Tweens, Tween)
    end)

    LabelTable.Asset.MouseLeave:Connect(function()
        for i,v in pairs(LabelTable.Tweens) do
            v:Cancel()
        end
        LabelTable.Tweens = {}

        local Tween = Assist({
            ["Name"] = "Tween";
            ["Arguments"] = {
                LabelTable.Asset.UIStroke,
                {Color = Color3.fromRGB(44, 58, 66)},
                0.1
            }
        })
        table.insert(LabelTable.Tweens, Tween)
    end)

    return setmetatable(LabelTable, Library)
end

function Library:UpdateNotifications()

    --// GET RID OF THE LOSER NOTIFICATIONS LOL
    for i,v in pairs(Library.Notifications) do
        if (tick()-v.Data.TOC) >= v.Data.Duration then
            --// Remove
            --inst, tType, t, yield, pref
            local Notif = v.Data.Notification
            Tween(Notif, {Position = u2(1, Notif.Position.X.Offset, Notif.Position.Y.Scale, Notif.Position.Y.Offset)}, 0.55)
            
            delay(0.55, function()
				Notif:Destroy()
			end)
            table.remove(Library.Notifications, i)
        end
    end

	if #Library.Notifications > 1 then
		table.sort(Library.Notifications, function(a, b)
			return a.Data.Queue < b.Data.Queue
		end)
	end

    for i,v in ipairs(Library.Notifications) do
        --Let's determine if its a new notification or already tweened
        local Move_Axis = (0.88 - (0.12 * (i-1)))
        if v.Data.Notification.Position.X.Scale == 1 then
            -- New
            v.Data.Notification.Position = u2(1, v.Data.Notification.Position.X.Offset, Move_Axis, v.Data.Notification.Position.Y.Offset)
            v.Data.Notification.Visible = true

            Tween(v.Data.Notification, {Position = u2(0.827, v.Data.Notification.Position.X.Offset, Move_Axis, v.Data.Notification.Position.Y.Offset)}, 0.5)
        else
            -- Old
            Tween(v.Data.Notification, {Position = u2(0.827, v.Data.Notification.Position.X.Offset, Move_Axis, v.Data.Notification.Position.Y.Offset)}, 0.5)
        end
    end
end

function Library:Notification(Title, Info, Duration, ButtonOptions)
    if #Library.Notifications >= 5 then
        print("You have too many notifications ongoing.")
        return
    end

    local Notification
    Notification = {

        Title = Title or "None",
        Info = Info or "No Info",

        Data = {
            Queue = #Library.Notifications+1,
            Notification = Assist({["Name"] = "GetAsset", ["Arguments"] = {"Notification"}}):Clone(),
            TOC = tick(),
            Duration = Duration or 3
        };
        Binds = {};
    }
    Notification.Data.Notification.Name = Notification.Data.Queue
    Notification.Data.Notification.TextLabel.Text = Notification.Info
    Notification.Data.Notification.Frame.TextLabel.Text = ('<font color="#FFFFFF">Xenon</font>: ' .. Notification.Title)
    Notification.Data.Notification.Parent = Assist({["Name"] = "GetAsset", ["Arguments"] = {"RippleAsset"}}).Parent;
    Notification.Data.Notification.Position = u2(1, Notification.Data.Notification.Position.X.Offset, 0, Notification.Data.Notification.Position.Y.Offset)
    
    if ButtonOptions then
        if ButtonOptions[1] then
            Notification.Data.Notification.Button1.Visible = true
            Notification.Data.Notification.Button1.TextLabel.Text = ButtonOptions[1].Text
            Notification.Data.Notification.Button1.Text = ButtonOptions[1].Text
            Notification.Binds[1] = Notification.Data.Notification.Button1.MouseButton1Click:Connect(function()
                for i,v in pairs(Notification.Binds) do
                    v:Disconnect()
                end
                ButtonOptions[1].Callback()
                Library.Notifications[Notification.Data.Queue].Data.TOC = tick() - Duration*2
                Library:UpdateNotifications()
            end)
        end
        if ButtonOptions[2] then
            Notification.Data.Notification.Button2.Visible = true
            Notification.Data.Notification.Button2.TextLabel.Text = ButtonOptions[2].Text
            Notification.Data.Notification.Button2.Text = ButtonOptions[2].Text
            Notification.Binds[2] = Notification.Data.Notification.Button2.MouseButton1Click:Connect(function()
                for i,v in pairs(Notification.Binds) do
                    v:Disconnect()
                end
                ButtonOptions[2].Callback()
                Library.Notifications[Notification.Data.Queue].Data.TOC = tick() - Duration*2
                Library:UpdateNotifications()
            end)
        end
    end

    table.insert(Library.Notifications, Notification)

    delay(Duration+0.05, function()
        Library:UpdateNotifications()
    end)
    Library:UpdateNotifications()
end

function Library:UpdateAsset(a_1, ...)
    local Class = self.Class;

    if a_1 == nil then return end;
    if Class == "Button" then
        self.Callback = a_1;
    elseif Class == "Toggle" then
        self.State = a_1;
        self.Update();
    
        task.spawn(function()
            pcall(self.Callback, self.State)
        end)
    elseif Class == "Label" then
        self.Name = a_1;
    elseif Class == "Slider" then       
        self.Value = a_1;
    elseif Class == "Dropdown" then
        self.List = a_1;
    elseif Class == "Keybind" then
        self.Key = a_1;
    elseif Class == "TextBox" then
        self.Update(a_1);
        return
    end

    self.Update();
end

return Library
