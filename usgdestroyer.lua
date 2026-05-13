-- the menu
local Library = loadstring(game:HttpGet("https://github.com/1dontgiveaf/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/1dontgiveaf/Fluent/main/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/1dontgiveaf/Fluent/main/Addons/InterfaceManager.lua"))()
local Window = Fluent:CreateWindow({
    Title = "usg destroyer " .. Fluent.Version,
    SubTitle = "by doug",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- Turns off and on blur in case it's detected
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when there's no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "all the stuffz", Icon = "" }),
}

Window:Dialog({
    Title = "w a r n i n g",
    Content = "if a user has allow mode on most scripts wont work",
    Buttons = {
        { 
            Title = "i gotchu",
            Callback = function()
                print("Confirmed the dialog.")
            end 
        }, {
            Title = "nah idc loser haha",
            Callback = function()
                print("Cancelled the dialog.")
            end 
        }
    }
})

Tabs.Main:AddButton({
    Title = "enable master settings",
    Description = "PLEASE PRESS THIS",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/charlieomg/dgxvulnhubrobloxshitstuff/refs/heads/main/enablemaster.lua'))()
    end
})

local Toggle = Tabs.Main:AddToggle("RainbowSpam", {
    Title = "rainbow all blocks", 
    Description = "requires you to hold paint bucket",
    Default = false,
    Callback = function(state)
        _G.RainbowChaos = state
        if state then
            task.spawn(function()
                -- All logic contained inside the state check
                local lp = game:GetService("Players").LocalPlayer
                local toolName = "Paint Bucket The PAINTER"
                local bucket = lp.Backpack:FindFirstChild(toolName) or (lp.Character and lp.Character:FindFirstChild(toolName))

                if bucket and _G.RainbowChaos then
                    local remote = bucket:WaitForChild("RemoteEvent")
                    bucket.Parent = lp.Character -- Auto-equip
                    
                    while _G.RainbowChaos do
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            if not _G.RainbowChaos then break end
                            
                            -- death
                            if obj.Name == "IsBlock" or (obj.Parent and obj.Parent:FindFirstChild("IsBlock")) then
                                local target = obj:IsA("BasePart") and obj or obj.Parent:FindFirstChildOfClass("BasePart")
                                
                                if target then
                                    local randomColor = Color3.new(math.random(), math.random(), math.random())
                                    remote:FireServer("Part", randomColor, target)
                                end
                                task.wait(0.01) -- Execution speed
                            end
                        end
                        task.wait(0.5)
                    end
                else
                    print("Tool not found while activating toggle.")
                end
            end)
        end
    end 
})

local Toggle = Tabs.Main:AddToggle("TextureSpammer", {
    Title = "decal spam", 
    Description = "requires the paint roller to be held and set a image inside the roller",
    Default = false,
    Callback = function(state)
        _G.TextureSpam = state
        
        if state then
            task.spawn(function()
                local lp = game:GetService("Players").LocalPlayer
                local toolName = "Paint Roller The TEXTURE MAKER"
                
                -- Configuration
                local assetId = "10764744805" -- Your ID
                local faces = {Enum.NormalId.Top, Enum.NormalId.Front, Enum.NormalId.Right}

                -- Find and Equip tool
                local roller = lp.Backpack:FindFirstChild(toolName) or (lp.Character and lp.Character:FindFirstChild(toolName))
                
                if roller and _G.TextureSpam then
                    local remote = roller:WaitForChild("RemoteEvent")
                    roller.Parent = lp.Character
                    
                    -- Ensure ID is set (Firing the ID update mode usually used by these tools)
                    -- Most tools send the ID as a separate remote call or a specific mode
                    remote:FireServer("UpdateID", assetId) 
                    
                    while _G.TextureSpam do
                        for _, item in ipairs(workspace:GetDescendants()) do
                            if not _G.TextureSpam then break end
                            
                            -- Identifier check
                            if item.Name == "IsBlock" or (item.Parent and item.Parent:FindFirstChild("IsBlock")) then
                                local targetPart = item:IsA("BasePart") and item or item.Parent:FindFirstChildOfClass("BasePart")

                                if targetPart then
                                    for _, face in ipairs(faces) do
                                        -- Using the "1" mode from your original snippet
                                        remote:FireServer(1, targetPart, face)
                                    end
                                    task.wait(0.01)
                                end
                            end
                        end
                        task.wait(0.5)
                    end
                else
                    print("Paint Roller tool not found.")
                end
            end)
        end
    end 
})

local Toggle = Tabs.Main:AddToggle("MegaResizer", {
    Title = "make all blocks super big", 
    Description = "requires the rescaler and master settings set the number in the rescaler to 2026 for max damage",
    Default = false,
    Callback = function(state)
        _G.MegaResizer = state
        
        if state then
            task.spawn(function()
                local lp = game:GetService("Players").LocalPlayer
                local toolName = "Roulette The RESIZER"
                
                -- 1. Find and Equip the Tool
                local char = lp.Character or lp.CharacterAdded:Wait()
                local resizeTool = lp.Backpack:FindFirstChild(toolName) or char:FindFirstChild(toolName)

                if resizeTool and _G.MegaResizer then
                    local resizeRemote = resizeTool:WaitForChild("RemoteEvent")
                    resizeTool.Parent = char -- Tool must be equipped for server validation
                    
                    while _G.MegaResizer do
                        -- 2. Scan and Filter for Blocks
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            if not _G.MegaResizer then break end
                            
                            -- Target blocks based on your identifier
                            if obj:IsA("BasePart") and (obj.Name == "IsBlock" or obj.Parent:FindFirstChild("IsBlock")) then
                                local target = obj.Parent:FindFirstChild("IsBlock") and obj.Parent or obj
                                
                                -- 3. Fire Server with "resize" mode
                                resizeRemote:FireServer(target, "resize")
                                
                                -- Throttle slightly to avoid remote rate-limiting
                                task.wait(0.02)
                            end
                        end
                        task.wait(1) -- Scans the map again every second
                    end
                else
                    print("Roulette Resizer tool not found!")
                end
            end)
        end
    end 
})

Tabs.Main:AddButton({
    Title = "delete all",
    Description = "requires u to hold thy screwdriver",
    Callback = function()
        local lp = game:GetService("Players").LocalPlayer
        local char = lp.Character or lp.CharacterAdded:Wait()
        local toolName = "Screwdriver The PROPERTIES CHANGER"

        -- 1. Find the Tool
        local tool = lp.Backpack:FindFirstChild(toolName) or char:FindFirstChild(toolName)

        if not tool then
            warn("Screwdriver not found! You need it in your inventory.")
            return
        end

        local remote = tool:WaitForChild("RemoteEvent")
        
        -- 2. Equip for Server Auth
        tool.Parent = char
        task.wait(0.2)

        -- 3. Scan and Execute
        local targets = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "IsBlock" or (obj.Parent and obj.Parent:FindFirstChild("IsBlock")) then
                local part = obj:IsA("BasePart") and obj or obj.Parent:FindFirstChildOfClass("BasePart")
                if part and not table.find(targets, part) then
                    table.insert(targets, part)
                end
            end
        end

        print("Targeting " .. #targets .. " blocks...")

        task.spawn(function()
            for i, block in ipairs(targets) do
                -- Setting both properties to false in one call
                remote:FireServer({block}, {
                    ["Anchored"] = false,
                    ["CanCollide"] = false
                })
                
                -- Fast but safe throttle
                if i % 10 == 0 then task.wait(0.05) end
                task.wait(0.01)
            end
            print("Mass destruction complete.")
        end)
    end
})

Tabs.Main:AddButton({
    Title = "unanchor all builds",
    Description = "requires u to hold screwdriver",
    Callback = function()
        local lp = game:GetService("Players").LocalPlayer
        local char = lp.Character or lp.CharacterAdded:Wait()
        local toolName = "Screwdriver The PROPERTIES CHANGER"

        -- 1. Locate the Tool
        local tool = lp.Backpack:FindFirstChild(toolName) or char:FindFirstChild(toolName)

        if not tool then
            warn("Screwdriver not found! Make sure you have it in your inventory.")
            return
        end

        local remote = tool:WaitForChild("RemoteEvent")
        
        -- 2. Equip for Server Validation
        tool.Parent = char
        task.wait(0.2)

        -- 3. Gather Targets
        local targets = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            -- Identify player-built blocks using the game's internal tag
            if obj.Name == "IsBlock" or (obj.Parent and obj.Parent:FindFirstChild("IsBlock")) then
                local part = obj:IsA("BasePart") and obj or obj.Parent:FindFirstChildOfClass("BasePart")
                if part and not table.find(targets, part) then
                    table.insert(targets, part)
                end
            end
        end

        print("Unanchoring " .. #targets .. " blocks...")

        -- 4. Execution Loop
        task.spawn(function()
            for i, block in ipairs(targets) do
                -- Remote expects: {TargetTable}, {PropertyTable}
                remote:FireServer({block}, {
                    ["Anchored"] = false
                })
                
                -- Anti-kick throttle
                if i % 10 == 0 then task.wait(0.05) end
                task.wait(0.01)
            end
            print("Finished unanchoring all blocks.")
        end)
    end
})
