local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- 1. Create the Top Hint (Server-sided appearance via Hint object)
local hint = Instance.new("Hint")
hint.Text = "DGVULN HUB"
hint.Parent = workspace -- Hints are globally visible to the player when parented here

-- 2. Create Sleek UI Elements
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminControlUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 110)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -55)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

-- Adding rounded corners
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

-- Adding a subtle border/stroke
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(60, 60, 60)
uiStroke.Thickness = 1.5
uiStroke.Parent = mainFrame

local button = Instance.new("TextButton")
button.Name = "GiveAdminBtn"
button.Size = UDim2.new(0.85, 0, 0.45, 0)
button.Position = UDim2.new(0.075, 0, 0.275, 0)
button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
button.Text = "Activate"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.AutoButtonColor = true
button.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = button

-- 3. Logic: Setting the Value
button.MouseButton1Click:Connect(function()
    local adminValue = player:FindFirstChild("ServerAdmin")
    
    if adminValue then
        adminValue.Value = true
        button.Text = "activated"
        button.BackgroundColor3 = Color3.fromRGB(46, 204, 113) -- Material Green
        
        -- Brief animation effect
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(39, 174, 96)}):Play()
    else
        warn("ServerAdmin object not found!")
        button.Text = "Error: Value Missing"
        button.BackgroundColor3 = Color3.fromRGB(231, 76, 60) -- Material Red
    end
end)

-- 4. Modern Dragging Logic
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    -- Smooth dragging via Tween
    TweenService:Create(mainFrame, TweenInfo.new(0.1), {Position = newPos}):Play()
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
