-- GUI erstellen
local gui = Instance.new("ScreenGui", game.CoreGui)

-- Hintergrund für die GUI (optional)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 110)  -- Erhöht wegen zweitem Button
frame.Position = UDim2.new(0.5, -200, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0

-- Label "Autofarm"
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(0, 150, 0, 40)
label.Position = UDim2.new(0, 10, 0, 10)
label.Text = "Autofarm"
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.SourceSans
label.TextSize = 20

-- Autofarm Toggle-Button
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0, 100, 0, 40)
toggle.Position = UDim2.new(0, 250, 0, 10)
toggle.Text = ""
toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggle.BorderSizePixel = 0

-- Kill Boss Label
local bossLabel = Instance.new("TextLabel", frame)
bossLabel.Size = UDim2.new(0, 150, 0, 40)
bossLabel.Position = UDim2.new(0, 10, 0, 55)
bossLabel.Text = "Kill Boss"
bossLabel.BackgroundTransparency = 1
bossLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
bossLabel.Font = Enum.Font.SourceSans
bossLabel.TextSize = 20

-- Kill Boss Toggle-Button
local bossToggle = Instance.new("TextButton", frame)
bossToggle.Size = UDim2.new(0, 100, 0, 40)
bossToggle.Position = UDim2.new(0, 250, 0, 55)
bossToggle.Text = ""
bossToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
bossToggle.BorderSizePixel = 0

-- Variablen
local flying = false
local bossFarming = false
local player = game.Players.LocalPlayer
local connection
local bossConnection
local currentTarget
local currentBoss

-- Zombie-Namen
local zombieNames = {
    "zombie", "slime", "void", "lava", "tank", "fast", "enraged", "Tank Zombie", "Beast", "Tank Ice Zombie", "Enraged Zombie", "Explosive Zombie", "Enraged Slime", "Tank Vampire"
}

-- Boss-Namen
local bossNames = {
    "Mega Tank", "King Slime", "Dark Ghost", "Demon Overlord", "Dragon Beast"
}

-- Nächstes Ziel: Zombie
local function getClosestZombie(hrp)
    local enemiesFolder = workspace:FindFirstChild("enemies")
    if not enemiesFolder then return nil end

    local closest, dist = nil, math.huge
    for _, model in ipairs(enemiesFolder:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") and model:FindFirstChild("Humanoid") then
            for _, keyword in ipairs(zombieNames) do
                if model.Name:lower():find(keyword) and model.Humanoid.Health > 0 then
                    local d = (hrp.Position - model.HumanoidRootPart.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = model
                    end
                end
            end
        end
    end
    return closest
end

-- Nächstes Ziel: Boss
local function getClosestBoss(hrp)
    local bossFolder = workspace:FindFirstChild("BossFolder")
    if not bossFolder then return nil end

    local closest, dist = nil, math.huge
    for _, model in ipairs(bossFolder:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") and model:FindFirstChild("Humanoid") then
            for _, name in ipairs(bossNames) do
                if model.Name == name and model.Humanoid.Health > 0 then
                    local d = (hrp.Position - model.HumanoidRootPart.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = model
                    end
                end
            end
        end
    end
    return closest
end

-- Autofarm
local function toggleAutofarm()
    flying = not flying
    toggle.BackgroundColor3 = flying and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(80, 80, 80)
    toggle.Text = flying and "" or ""

    if flying then
        spawn(function()
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            currentTarget = getClosestZombie(hrp)

            while flying do
                if currentTarget and currentTarget:FindFirstChild("HumanoidRootPart") then
                    hrp.Velocity = Vector3.zero
                    hrp.CFrame = currentTarget.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
                else
                    currentTarget = getClosestZombie(hrp)
                end
                task.wait(0.05)
            end

            if connection then
                connection:Disconnect()
                connection = nil
            end
        end)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

-- Kill Boss
local function toggleBossFarm()
    bossFarming = not bossFarming
    bossToggle.BackgroundColor3 = bossFarming and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(80, 80, 80)
    bossToggle.Text = bossFarming and "" or ""

    if bossFarming then
        spawn(function()
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")

            while bossFarming do
                local enemiesFolder = workspace:FindFirstChild("enemies")
                local hasZombies = enemiesFolder and #enemiesFolder:GetChildren() > 0

                if not hasZombies then
                    currentBoss = getClosestBoss(hrp)

                    if currentBoss and currentBoss:FindFirstChild("HumanoidRootPart") then
                        hrp.Velocity = Vector3.zero
                        hrp.CFrame = currentBoss.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)

                        if bossConnection then bossConnection:Disconnect() end
                        local humanoid = currentBoss:FindFirstChild("Humanoid")
                        if humanoid then
                            bossConnection = humanoid.Died:Connect(function()
                                task.wait()
                                currentBoss = getClosestBoss(hrp)
                            end)
                        end
                    else
                        currentBoss = nil
                    end
                end

                task.wait(0.05)
            end

            if bossConnection then
                bossConnection:Disconnect()
                bossConnection = nil
            end
        end)
    else
        if bossConnection then
            bossConnection:Disconnect()
            bossConnection = nil
        end
    end
end

-- Button Klick Events
toggle.MouseButton1Click:Connect(toggleAutofarm)
bossToggle.MouseButton1Click:Connect(toggleBossFarm)

-- GUI bewegbar
local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)