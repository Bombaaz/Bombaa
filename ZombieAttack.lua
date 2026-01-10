-- ============================================
-- ZOMBIE ATTACK FARM - VERBESSERTE VERSION
-- Mit: 1) Position HINTER Zombie, 2) Besserer Autoshoot
-- ============================================

-- GUI Code...
local gui = Instance.new("ScreenGui")
gui.Name = "ZombieAttackFarmGUI"
gui.Parent = game.CoreGui

-- Hauptframe
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 250)
frame.Position = UDim2.new(0.5, -160, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 170, 255)

-- Dragable GUI
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Titel
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "ZOMBIE ATTACK FARM"
title.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- AutoFarm Button
local autoFarmBtn = Instance.new("TextButton", frame)
autoFarmBtn.Size = UDim2.new(0.9, 0, 0, 40)
autoFarmBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
autoFarmBtn.Text = "AUTO FARM: OFF"
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmBtn.Font = Enum.Font.GothamBold
autoFarmBtn.TextSize = 14

-- Height Slider
local heightLabel = Instance.new("TextLabel", frame)
heightLabel.Size = UDim2.new(0.4, 0, 0, 20)
heightLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
heightLabel.Text = "Height: 5"
heightLabel.BackgroundTransparency = 1
heightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
heightLabel.Font = Enum.Font.Gotham
heightLabel.TextSize = 12

local heightSlider = Instance.new("Frame", frame)
heightSlider.Size = UDim2.new(0.5, 0, 0, 15)
heightSlider.Position = UDim2.new(0.45, 0, 0.35, 0)
heightSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
heightSlider.BorderSizePixel = 1

local heightFill = Instance.new("Frame", heightSlider)
heightFill.Size = UDim2.new(0.25, 0, 1, 0) -- Start bei 5
heightFill.Position = UDim2.new(0, 0, 0, 0)
heightFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
heightFill.BorderSizePixel = 0

-- Distance Slider (Nähe)
local distanceLabel = Instance.new("TextLabel", frame)
distanceLabel.Size = UDim2.new(0.4, 0, 0, 20)
distanceLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
distanceLabel.Text = "Distance: 5"
distanceLabel.BackgroundTransparency = 1
distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
distanceLabel.Font = Enum.Font.Gotham
distanceLabel.TextSize = 12

local distanceSlider = Instance.new("Frame", frame)
distanceSlider.Size = UDim2.new(0.5, 0, 0, 15)
distanceSlider.Position = UDim2.new(0.45, 0, 0.45, 0)
distanceSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
distanceSlider.BorderSizePixel = 1

local distanceFill = Instance.new("Frame", distanceSlider)
distanceFill.Size = UDim2.new(0.25, 0, 1, 0) -- Start bei 5
distanceFill.Position = UDim2.new(0, 0, 0, 0)
distanceFill.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
distanceFill.BorderSizePixel = 0

-- Powerups Button
local powerupBtn = Instance.new("TextButton", frame)
powerupBtn.Size = UDim2.new(0.9, 0, 0, 40)
powerupBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
powerupBtn.Text = "POWERUPS: OFF"
powerupBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
powerupBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
powerupBtn.Font = Enum.Font.GothamBold
powerupBtn.TextSize = 14

-- Status
local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, -10, 0, 20)
statusLabel.Position = UDim2.new(0, 5, 0.75, 0)
statusLabel.Text = "Ready"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12

-- AutoShoot Info
local shootLabel = Instance.new("TextLabel", frame)
shootLabel.Size = UDim2.new(1, -10, 0, 20)
shootLabel.Position = UDim2.new(0, 5, 0.85, 0)
shootLabel.Text = "AutoShoot: Testing..."
shootLabel.BackgroundTransparency = 1
shootLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
shootLabel.Font = Enum.Font.Gotham
shootLabel.TextSize = 12

-- Close Button
local closeBtn = Instance.new("TextButton", title)
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold

-- ========== VERBESSERTE VARIABLEN ==========
local player = game.Players.LocalPlayer
local autoFarmActive = false
local powerupActive = false
local height = 5
local distance = 5
local currentTarget = nil
local collectedPowerups = {}

-- VERBESSERT: Zombie-Typen
local zombieTypes = {
    "zombie", "slime", "void", "lava", "tank", "fast", "enraged", 
    "Tank Zombie", "Beast", "Tank Ice Zombie", "Enraged Zombie", 
    "Explosive Zombie", "Enraged Slime", "Tank Vampire", "Ice Zombie",
    "Vampire", "Ghost", "Demon", "Abomination", "Crawler"
}

-- NEU: Waffen-Datenbank
local weaponData = {
    ["M16"] = {Range = 100, Offset = Vector3.new(0, 0, -5)},
    ["AK47"] = {Range = 90, Offset = Vector3.new(0, 0, -5)},
    ["Shotgun"] = {Range = 30, Offset = Vector3.new(0, 0, -3)},
    ["Sniper"] = {Range = 200, Offset = Vector3.new(0, 0, -10)}
    -- Füge mehr Waffen hinzu
}

-- ========== VERBESSERTE HILFSFUNKTIONEN ==========
local function updateStatus(text, color)
    statusLabel.Text = text
    statusLabel.TextColor3 = color
end

local function updateShootInfo(text, color)
    shootLabel.Text = text
    shootLabel.TextColor3 = color
end

-- NEU: Berechne Position HINTER dem Zombie (nicht oben)
local function getPositionBehindTarget(targetHrp)
    if not targetHrp then return nil end
    
    -- Hole die Blickrichtung des Zombies
    local lookVector = targetHrp.CFrame.LookVector
    
    -- Position HINTER dem Zombie (gegenüber seiner Blickrichtung)
    -- Height kontrolliert wie hoch wir sind, Distance wie weit weg
    local behindOffset = lookVector * -distance  -- Minus = hinter
    local heightOffset = Vector3.new(0, height, 0)
    
    return targetHrp.Position + behindOffset + heightOffset
end

-- NEU: Richte dich zum Zombie aus (damit du ihn ansiehst)
local function faceTarget(characterHrp, targetHrp)
    if not characterHrp or not targetHrp then return end
    
    local direction = (targetHrp.Position - characterHrp.Position).Unit
    characterHrp.CFrame = CFrame.lookAt(characterHrp.Position, characterHrp.Position + direction)
end

-- ========== VERBESSERTER AUTOSHOOT ==========
local function performAutoShoot(target)
    if not target then 
        updateShootInfo("AutoShoot: Kein Ziel", Color3.fromRGB(255, 0, 0))
        return false 
    end
    
    local character = player.Character
    if not character then return false end
    
    -- 1. Aktuelles Werkzeug finden
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then
        updateShootInfo("AutoShoot: Keine Waffe", Color3.fromRGB(255, 165, 0))
        return false
    end
    
    local toolName = tool.Name
    updateShootInfo("AutoShoot: " .. toolName, Color3.fromRGB(0, 255, 0))
    
    -- 2. Unterschiedliche Schussmethoden probieren
    local success = false
    
    -- Methode 1: Direkte Aktivierung
    tool:Activate()
    success = true
    
    -- Methode 2: RemoteEvents suchen
    if not success then
        -- Nach Remotes im Spiel suchen
        local remotes = {
            "FireServer", "fire", "Shoot", "shoot", 
            "Damage", "damage", "Attack", "attack"
        }
        
        for _, remoteName in ipairs(remotes) do
            local remote = tool:FindFirstChild(remoteName)
            if remote and remote:IsA("RemoteEvent") then
                remote:FireServer(target)
                success = true
                break
            end
        end
    end
    
    -- Methode 3: MouseButton1Click simulieren
    if not success then
        local clickDetector = tool:FindFirstChildOfClass("ClickDetector")
        if clickDetector then
            clickDetector.MaxActivationDistance = 1000
            fireclickdetector(clickDetector)
            success = true
        end
    end
    
    -- Debug-Info in Console
    if success then
        local zombieHumanoid = target:FindFirstChild("Humanoid")
        local health = zombieHumanoid and zombieHumanoid.Health or 0
        print(string.format("[AUTO-SHOOT] %s -> %s (HP: %d)", 
            toolName, 
            target.Name,
            health
        ))
    end
    
    return success
end

-- ========== VERBESSERTE ZOMBIE-SUCHE ==========
local function findZombie()
    -- Zuerst in verschiedenen Ordnern suchen
    local possibleFolders = {
        workspace:FindFirstChild("enemies"),
        workspace:FindFirstChild("Enemies"),
        workspace:FindFirstChild("Zombies"),
        workspace:FindFirstChild("zombies"),
        workspace:FindFirstChild("Mobs")
    }
    
    local character = player.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local closest = nil
    local closestDist = math.huge
    
    -- Durch alle möglichen Ordner gehen
    for _, folder in ipairs(possibleFolders) do
        if folder then
            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model") then
                    local humanoid = model:FindFirstChild("Humanoid")
                    local targetHrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
                    
                    if humanoid and targetHrp and humanoid.Health > 0 then
                        -- Prüfe ob es ein Zombie ist
                        local isZombie = false
                        local nameLower = model.Name:lower()
                        
                        for _, zombieType in ipairs(zombieTypes) do
                            if nameLower:find(zombieType:lower()) then
                                isZombie = true
                                break
                            end
                        end
                        
                        -- Auch nach Humanoid-Wert prüfen
                        if not isZombie and humanoid:GetAttribute("IsZombie") then
                            isZombie = true
                        end
                        
                        if isZombie then
                            local dist = (hrp.Position - targetHrp.Position).Magnitude
                            if dist < closestDist then
                                closestDist = dist
                                closest = model
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closest
end

-- ========== VERBESSERTER AUTO FARM ==========
local autoFarmThread
local function startAutoFarm()
    if autoFarmActive then return end
    
    autoFarmActive = true
    autoFarmBtn.Text = "AUTO FARM: ON"
    autoFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    updateStatus("Starte...", Color3.fromRGB(0, 255, 0))
    updateShootInfo("AutoShoot: Aktiv", Color3.fromRGB(0, 255, 0))
    
    autoFarmThread = task.spawn(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        
        -- Humanoid für NoClip
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = true
            humanoid.AutoRotate = false  -- Verhindere automatische Rotation
        end
        
        -- NoClip aktivieren
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Velocity = Vector3.new(0, 0, 0)
            end
        end
        
        local lastShootTime = 0
        local shootCooldown = 0.2  -- 5 Schüsse pro Sekunde
        
        while autoFarmActive do
            local zombie = findZombie()
            currentTarget = zombie
            
            if zombie then
                local targetHrp = zombie:FindFirstChild("HumanoidRootPart") or zombie:FindFirstChild("Torso")
                
                if targetHrp then
                    -- VERBESSERT: Position HINTER dem Zombie
                    local newPos = getPositionBehindTarget(targetHrp)
                    
                    -- Zur Position teleportieren
                    hrp.CFrame = CFrame.new(newPos)
                    
                    -- VERBESSERT: Zum Zombie schauen
                    faceTarget(hrp, targetHrp)
                    
                    -- Geschwindigkeit auf 0 setzen
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    hrp.RotVelocity = Vector3.new(0, 0, 0)
                    
                    -- VERBESSERT: Autoshoot mit Cooldown
                    local currentTime = tick()
                    if currentTime - lastShootTime > shootCooldown then
                        local shootSuccess = performAutoShoot(zombie)
                        lastShootTime = currentTime
                        
                        -- Status basierend auf Schuss-Erfolg
                        if shootSuccess then
                            updateStatus("Angriff: " .. zombie.Name, Color3.fromRGB(255, 50, 50))
                        else
                            updateStatus("Verfolgung: " .. zombie.Name, Color3.fromRGB(255, 255, 0))
                        end
                    else
                        updateStatus("Cooldown: " .. zombie.Name, Color3.fromRGB(200, 200, 255))
                    end
                    
                    -- Prüfe ob Zombie tot ist
                    local zombieHumanoid = zombie:FindFirstChild("Humanoid")
                    if not zombieHumanoid or zombieHumanoid.Health <= 0 then
                        task.wait(0.3)  -- Warten bis er verschwindet
                    end
                end
            else
                updateStatus("Suche Zombies...", Color3.fromRGB(255, 165, 0))
                updateShootInfo("AutoShoot: Warte auf Ziel", Color3.fromRGB(255, 255, 0))
            end
            
            task.wait(0.05)  -- Sehr schnelle Updates für glatte Bewegung
        end
        
        -- Reset
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.AutoRotate = true
        end
        
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        
        updateShootInfo("AutoShoot: Inaktiv", Color3.fromRGB(255, 0, 0))
    end)
end

local function stopAutoFarm()
    autoFarmActive = false
    autoFarmBtn.Text = "AUTO FARM: OFF"
    autoFarmBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    updateStatus("Gestoppt", Color3.fromRGB(255, 0, 0))
    
    if autoFarmThread then
        task.cancel(autoFarmThread)
    end
end

-- ========== POWERUPS (vereinfacht) ==========
local powerupThread
local function startPowerups()
    if powerupActive then return end
    
    powerupActive = true
    powerupBtn.Text = "POWERUPS: ON"
    powerupBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    collectedPowerups = {}
    
    powerupThread = task.spawn(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        
        while powerupActive do
            task.wait(2)  -- Check alle 2 Sekunden
            
            -- Hier könntest du Powerup-Logik hinzufügen
            updateStatus("Powerups: Aktiv", Color3.fromRGB(0, 255, 255))
        end
    end)
end

local function stopPowerups()
    powerupActive = false
    powerupBtn.Text = "POWERUPS: OFF"
    powerupBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    
    if powerupThread then
        task.cancel(powerupThread)
    end
end

-- ========== GUI EVENTS ==========
autoFarmBtn.MouseButton1Click:Connect(function()
    if autoFarmActive then
        stopAutoFarm()
    else
        startAutoFarm()
    end
end)

powerupBtn.MouseButton1Click:Connect(function()
    if powerupActive then
        stopPowerups()
    else
        startPowerups()
    end
end)

-- Height Slider (5-30)
heightSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local relativeX = math.clamp(mouse.X - heightSlider.AbsolutePosition.X, 0, heightSlider.AbsoluteSize.X)
            local percentage = relativeX / heightSlider.AbsoluteSize.X
            
            height = math.floor(1 + percentage * 29)  -- 1 bis 30
            heightFill.Size = UDim2.new(percentage, 0, 1, 0)
            heightLabel.Text = "Height: " .. height
        end)
        
        heightSlider.InputEnded:Wait()
        connection:Disconnect()
    end
end)

-- Distance Slider (1-20)
distanceSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local relativeX = math.clamp(mouse.X - distanceSlider.AbsolutePosition.X, 0, distanceSlider.AbsoluteSize.X)
            local percentage = relativeX / distanceSlider.AbsoluteSize.X
            
            distance = math.floor(1 + percentage * 19)  -- 1 bis 20
            distanceFill.Size = UDim2.new(percentage, 0, 1, 0)
            distanceLabel.Text = "Distance: " .. distance
        end)
        
        distanceSlider.InputEnded:Wait()
        connection:Disconnect()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    stopAutoFarm()
    stopPowerups()
end)

print("=====================================")
print("ZOMBIE ATTACK FARM - KORRIGIERT")
print("=====================================")
print("Fehler in Zeile 119 behoben")
print("Features:")
print("- Position HINTER Zombie (nicht oben)")
print("- Auto-Rotation zum Ziel")
print("- Verbesserter Autoshoot")
print("- Glattere Bewegung")
print("=====================================")
print("Tipps:")
print("1. Height: 2-5 für Rückenposition")
print("2. Distance: 3-5 für Rückenposition")
print("3. AutoShoot automatisch aktiv")
print("=====================================")
