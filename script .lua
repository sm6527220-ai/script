local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local flySpeed = 50
local isFlying = false
local flyBody = nil

local function startFly()
    if isFlying then return end
    isFlying = true
    local root = character:WaitForChild("HumanoidRootPart")
    
    flyBody = Instance.new("BodyVelocity")
    flyBody.MaxForce = Vector3.new(4000, 4000, 4000)
    flyBody.Velocity = Vector3.new(0, 0, 0)
    flyBody.Parent = root
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if not isFlying or not root then return end
        local cam = workspace.CurrentCamera
        local move = Vector
