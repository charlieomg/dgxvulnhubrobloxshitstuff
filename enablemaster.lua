
local player = game:GetService("Players").LocalPlayer
local adminValue = player:FindFirstChild("ServerAdmin")

if adminValue then
    adminValue.Value = true
    print("master is enabled")
else
    warn("ServerAdmin object not found! The game might use a different name or path.")
end
