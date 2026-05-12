while wait() do
local args = {
    [1] = 12
}

game:GetService("ReplicatedStorage").Honeypot.Internal.RemoteStorage:FindFirstChild("ClaimPlaytimeReward - RemoteEvent"):FireServer(unpack(args))
end
