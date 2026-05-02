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
        local move = Vector3.new(0,0,0)
        
        local uis = game:GetService("UserInputService")
        if uis:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end
        
        if move.Magnitude > 0 then
            flyBody.Velocity = move.Unit * flySpeed
        else
            flyBody.Velocity = Vector3.new(0,0,0)
        end
    end)
end

local function stopFly()
    isFlying = false
    if flyBody then flyBody:Destroy() end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        if isFlying then
            stopFly()
        else
            startFly()
        end
    end
end)

-- Godmode
humanoid.MaxHealth = math.huge
humanoid.Health = math.huge
humanoid:GetPropertyChangedSignal("Health"):Connect(function()
    humanoid.Health = math.huge
end)

humanoid.WalkSpeed = 100
humanoid.JumpPower = 150

print("OP Script Loaded - Press F for Fly")
