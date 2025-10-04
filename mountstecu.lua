    if game.PlaceId == 78955895955272 then
    -- ====================
    -- SERVICES
    -- ====================
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local UserInputService = game:GetService("UserInputService")

    -- ====================
    -- PLAYER REFERENCES
    -- ====================
    local lp = Players.LocalPlayer
    local function getCharacter()
        return lp.Character or lp.CharacterAdded:Wait()
    end
    
    local function getHRP()
        local char = getCharacter()
        return char:WaitForChild("HumanoidRootPart")
    end

    local function getHumanoid()
        local char = lp.Character
        return char and char:FindFirstChildOfClass("Humanoid")
    end

    -- ====================
    -- GAME DATA - MOUNT STECU
    -- ====================
    local GameData = {
        Checkpoints = {
            CFrame.new(1706.41309, 781.31427, -2317.73975, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp1
            CFrame.new(1267.55005, 782.18103, -2287.31177, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp2
            CFrame.new(976.414001, 797.752686, -2096.03101, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp3
            CFrame.new(1287.1781, 773.171204, -1751.28369, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp4
            CFrame.new(2228.76978, 779.186646, -1383.81018, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp5
            CFrame.new(2012.14124, 509.127167, -785.77533, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp6
            CFrame.new(1101.05457, 515.971313, -1080.37146, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp7
            CFrame.new(806.027771, 411.630493, -963.914978, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp8
            CFrame.new(759.735596, 397.336639, -1167.05786, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp9
            CFrame.new(216.745483, 393.48111, -1251.15125, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp10
            CFrame.new(40.5243378, 413.63028, -1533.05798, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp11
            CFrame.new(18.5296421, 541.809509, -1787.17297, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp12
            CFrame.new(-438.452545, 567.551208, -2165.28931, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp13
            CFrame.new(-1013.48041, 357.516602, -1912.95459, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp14
            CFrame.new(-1418.3407, 383.114563, -1861.67297, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp15
            CFrame.new(-1463.81738, 505.971375, -1783.54492, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp16
            CFrame.new(-1691.76843, 551.476562, -1781.30457, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp17
            CFrame.new(-2085.09448, 551.967224, -2033.93481, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp18
            CFrame.new(-2284.55444, 680.021179, -1830.8783, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp19
            CFrame.new(-1994.4209, 772.255615, -1487.92065, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp20
            CFrame.new(-1476.78613, 870.331909, -919.553894, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp21
            CFrame.new(-1259.79871, 862.731018, -776.911255, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp22
            CFrame.new(-736.688416, 1095.59973, -474.098877, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp23
            CFrame.new(-307.998901, 1314.9469, -325.651825, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp24
            CFrame.new(-92.7709351, 1550.83594, 128.126587, 0, 0, 1, 1, 0, 0, 0, 1, 0), -- cp25
        },
        SummitCP = CFrame.new(-246.924332, 1761.39685, 713.826538, -0.998483419, 0, -0.0550525598, 0, 1, 0, 0.0550525598, 0, -0.998483419), -- Summit
        BasecampCP = CFrame.new(2269.61353, 807, -2325.90283, 0, 0, 1, 0, 1, -0, -1, 0, 0) -- Basecamp
    }

    -- ====================
    -- UTILITY FUNCTIONS
    -- ====================
    local Utils = {}

    function Utils.doJump()
        local char = getCharacter()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then 
            hum:ChangeState(Enum.HumanoidStateType.Jumping) 
        end
    end

    function Utils.fireTouch(part)
        local hrp = getHRP()
        if hrp and part then
            for i = 1, 3 do
                firetouchinterest(hrp, part, 0)
                task.wait()
                firetouchinterest(hrp, part, 1)
            end
        end
    end

    function Utils.getCheckpointPart(index)
        local model = workspace:FindFirstChild("cekpoin")
        if not model then return nil end
        
        if index == 26 then
            return model:FindFirstChild("sumit")
        else
            return model:FindFirstChild("cp" .. index)
        end
    end

    function Utils.getBasecampPart()
        local model = workspace:FindFirstChild("cekpoin")
        if model and model:FindFirstChild("base") then
            return model.base
        end
        return nil
    end

    function Utils.resetToBasecamp()
        -- Use the game's teleport remote
        local success, err = pcall(function()
            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BaseTeleportRequest"):FireServer()
        end)
        
        if success then
            task.wait(0.5)
            Utils.doJump()
        else
            -- Fallback to manual teleport
            local hrp = getHRP()
            hrp.CFrame = GameData.BasecampCP
            task.wait(0.2)
            
            local basecampPart = Utils.getBasecampPart()
            if basecampPart then 
                Utils.fireTouch(basecampPart) 
            end
            Utils.doJump()
        end
    end

    function Utils.getTotalSummit()
        local stats = lp:FindFirstChild("leaderstats")
        if stats and stats:FindFirstChild("Summit") then
            return stats.Summit.Value
        end
        return 0
    end

    function Utils.getCurrentCheckpoint()
        local stats = lp:FindFirstChild("leaderstats")
        if stats and stats:FindFirstChild("Checkpoint") then
            return stats.Checkpoint.Value
        end
        return 0
    end

    function Utils.getBestTime()
        local stats = lp:FindFirstChild("leaderstats")
        if stats and stats:FindFirstChild("BestTime") then
            return stats.BestTime.Value
        end
        return "N/A"
    end

    -- ====================
    -- MOVEMENT MODULES
    -- ====================
    
    -- Fly Module
    local FlyModule = {}
    FlyModule.IsOnMobile = UserInputService.TouchEnabled
    FlyModule.Active = false
    FlyModule.Speed = 1
    
    local CONTROL = {F = 0, B = 0, L = 0, R = 0}
    local flyConnections = {}

    local function getRoot(char)
        return char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
    end

    function FlyModule:StartPCFly()
        if self.IsOnMobile then return end
        
        local char = getCharacter()
        local humanoid = char:WaitForChild("Humanoid")
        local T = getRoot(char)

        self.Active = true

        local BG = Instance.new("BodyGyro")
        BG.P = 9e4
        BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.CFrame = T.CFrame
        BG.Parent = T

        local BV = Instance.new("BodyVelocity")
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        BV.Parent = T

        local keyDown = UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.KeyCode == Enum.KeyCode.W then CONTROL.F = self.Speed end
            if input.KeyCode == Enum.KeyCode.S then CONTROL.B = -self.Speed end
            if input.KeyCode == Enum.KeyCode.A then CONTROL.L = -self.Speed end
            if input.KeyCode == Enum.KeyCode.D then CONTROL.R = self.Speed end
        end)

        local keyUp = UserInputService.InputEnded:Connect(function(input, processed)
            if input.KeyCode == Enum.KeyCode.W then CONTROL.F = 0 end
            if input.KeyCode == Enum.KeyCode.S then CONTROL.B = 0 end
            if input.KeyCode == Enum.KeyCode.A then CONTROL.L = 0 end
            if input.KeyCode == Enum.KeyCode.D then CONTROL.R = 0 end
        end)

        table.insert(flyConnections, keyDown)
        table.insert(flyConnections, keyUp)

        task.spawn(function()
            repeat task.wait()
                local camera = workspace.CurrentCamera
                if humanoid then humanoid.PlatformStand = true end

                local speed = (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and 50 or 0

                if speed ~= 0 then
                    BV.Velocity = ((camera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + 
                        ((camera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - camera.CFrame.p)) * speed
                else
                    BV.Velocity = Vector3.new(0, 0, 0)
                end

                BG.CFrame = camera.CFrame
            until not self.Active

            CONTROL = {F = 0, B = 0, L = 0, R = 0}
            BG:Destroy()
            BV:Destroy()
            if humanoid then humanoid.PlatformStand = false end
        end)
    end

    function FlyModule:StartMobileFly()
        if not self.IsOnMobile then return end
        
        self.Active = true
        local char = getCharacter()
        local humanoid = char:WaitForChild("Humanoid")
        local root = getRoot(char)
        local camera = workspace.CurrentCamera
        local controlModule = require(lp.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

        local bv = Instance.new("BodyVelocity")
        bv.Name = "MobileFlyBV"
        bv.Parent = root
        bv.MaxForce = Vector3.new(0, 0, 0)
        bv.Velocity = Vector3.new(0, 0, 0)

        local bg = Instance.new("BodyGyro")
        bg.Name = "MobileFlyBG"
        bg.Parent = root
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 1000
        bg.D = 50

        local conn = RunService.RenderStepped:Connect(function()
            if self.Active and root and humanoid and root:FindFirstChild("MobileFlyBV") and root:FindFirstChild("MobileFlyBG") then
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                humanoid.PlatformStand = true
                bg.CFrame = camera.CFrame

                local direction = controlModule:GetMoveVector()
                bv.Velocity = (camera.CFrame.LookVector * -direction.Z + camera.CFrame.RightVector * direction.X) * self.Speed * 50
            end
        end)

        table.insert(flyConnections, conn)
    end

    function FlyModule:Stop()
        self.Active = false
        
        for _, conn in pairs(flyConnections) do
            conn:Disconnect()
        end
        flyConnections = {}

        local char = getCharacter()
        if char then
            local root = getRoot(char)
            if root:FindFirstChild("MobileFlyBV") then root.MobileFlyBV:Destroy() end
            if root:FindFirstChild("MobileFlyBG") then root.MobileFlyBG:Destroy() end
            
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.PlatformStand = false end
        end

        CONTROL = {F = 0, B = 0, L = 0, R = 0}
    end

    -- WalkSpeed & JumpPower Module
    local MovementModule = {}
    MovementModule.DefaultWS = 16
    MovementModule.DefaultJP = 50
    MovementModule.WalkSpeed = 16
    MovementModule.JumpPower = 50
    MovementModule.BypassActive = false
    
    local wsLoop = nil
    local jpLoop = nil

    function MovementModule:ActivateBypass()
        if self.BypassActive then
            return false, "Bypass sudah aktif!"
        end

        local success, err = pcall(function()
            local mt = getrawmetatable(game)
            local old = mt.__newindex
            setreadonly(mt, false)

            mt.__newindex = newcclosure(function(t, k, v)
                if (t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower" or k == "JumpHeight")) then
                    return
                end
                return old(t, k, v)
            end)

            setreadonly(mt, true)
        end)

        if success then
            self.BypassActive = true
            return true, "WalkSpeed & JumpPower dilindungi!"
        else
            return false, "Gagal mengaktifkan bypass: " .. tostring(err)
        end
    end

    function MovementModule:SetWalkSpeed(enabled)
        if enabled then
            local hum = getHumanoid()
            if hum then 
                hum.WalkSpeed = self.WalkSpeed 
            end

            wsLoop = RunService.Heartbeat:Connect(function()
                local hum = getHumanoid()
                if hum and hum.WalkSpeed ~= self.WalkSpeed then
                    hum.WalkSpeed = self.WalkSpeed
                end
            end)
        else
            if wsLoop then 
                wsLoop:Disconnect() 
                wsLoop = nil 
            end
            
            local hum = getHumanoid()
            if hum then 
                hum.WalkSpeed = self.DefaultWS 
            end
        end
    end

    function MovementModule:UpdateWalkSpeed(value)
        self.WalkSpeed = value
        local hum = getHumanoid()
        if hum and wsLoop then
            hum.WalkSpeed = value
        end
    end

    function MovementModule:SetJumpPower(enabled)
        if enabled then
            local hum = getHumanoid()
            if hum then
                if hum.UseJumpPower then
                    hum.JumpPower = self.JumpPower
                else
                    hum.JumpHeight = self.JumpPower
                end
            end

            jpLoop = RunService.Heartbeat:Connect(function()
                local hum = getHumanoid()
                if hum then
                    if hum.UseJumpPower and hum.JumpPower ~= self.JumpPower then
                        hum.JumpPower = self.JumpPower
                    elseif not hum.UseJumpPower and hum.JumpHeight ~= self.JumpPower then
                        hum.JumpHeight = self.JumpPower
                    end
                end
            end)
        else
            if jpLoop then 
                jpLoop:Disconnect() 
                jpLoop = nil 
            end
            
            local hum = getHumanoid()
            if hum then
                if hum.UseJumpPower then
                    hum.JumpPower = self.DefaultJP
                else
                    hum.JumpHeight = self.DefaultJP
                end
            end
        end
    end

    function MovementModule:UpdateJumpPower(value)
        self.JumpPower = value
        local hum = getHumanoid()
        if hum and jpLoop then
            if hum.UseJumpPower then
                hum.JumpPower = value
            else
                hum.JumpHeight = value
            end
        end
    end

    -- ====================
    -- AUTO FARM MODULE - MOUNT STECU
    -- ====================
    local AutoFarm = {}
    AutoFarm.Active = false

    function AutoFarm:RunInstant(notifyCallback)
        task.spawn(function()
            while self.Active do
                -- Go through all checkpoints (1-25)
                for i = 1, 25 do
                    if not self.Active then break end
                    
                    local hrp = getHRP()
                    hrp.CFrame = GameData.Checkpoints[i]
                    
                    if notifyCallback then
                        notifyCallback("Checkpoint Progress", "CP " .. i .. "/25", 2)
                    end
                    
                    task.wait(4)
                end

                -- After cp25, go to summit (cp26)
                if self.Active then
                    local hrp = getHRP()
                    hrp.CFrame = GameData.SummitCP
                    
                    if notifyCallback then
                        notifyCallback("Summit Reached!", "Total Summits: " .. Utils.getTotalSummit(), 5)
                    end
                    
                    task.wait(4)
                end

                -- Reset to basecamp
                task.wait(2)
                Utils.resetToBasecamp()
                
                if notifyCallback then
                    notifyCallback("Reset Complete", "Kembali ke basecamp", 3)
                end
                
                task.wait(4)
            end
        end)
    end

    -- ====================
    -- UI SETUP
    -- ====================
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({
        Name = "Mount Stecu",
        LoadingTitle = "Auto Summit Mount",
        LoadingSubtitle = "by Zull",
        Theme = "Amethyst",
        DisableRayfieldPrompts = false,
        KeySystem = false
    })

    -- ====================
    -- MAIN TAB - MOUNT STECU
    -- ====================
    local Main = Window:CreateTab("Main", nil)
    
    Main:CreateSection("Auto Farm Summit :")
    
    Main:CreateParagraph({
        Title = "Auto Summit Info :",
        Content = "Sebelum Auto Summit wajib reset ke basecamp (tekan tombol Reset ke Basecamp). Auto Summit akan otomatis farm dari CP1 sampai Summit (26 checkpoints total), lalu kembali ke basecamp untuk reset. Script akan loop terus sampai toggle dimatikan."
    })

    Main:CreateButton({
        Name = "Reset ke Basecamp",
        Callback = function()
            Utils.resetToBasecamp()
            Rayfield:Notify({
                Title = "Teleport Basecamp",
                Content = "Kembali ke basecamp",
                Duration = 3
            })
        end
    })

    Main:CreateToggle({
        Name = "Auto Summit",
        CurrentValue = false,
        Flag = "AutoSummitInstant",
        Callback = function(Value)
            AutoFarm.Active = Value
            if Value then
                AutoFarm:RunInstant(function(title, content, duration)
                    Rayfield:Notify({
                        Title = title,
                        Content = content,
                        Duration = duration
                    })
                end)
            end
        end
    })

    -- ====================
    -- TOOLS TAB
    -- ====================
    local Tools = Window:CreateTab("Tools", nil)

    -- Teleport Section
    Tools:CreateSection("Teleport to CP :")
    
    Tools:CreateParagraph({
        Title = "Info :",
        Content = "Teleport ke basecamp akan mereset checkpoint anda menggunakan sistem game. Total ada 26 checkpoints (CP1-CP25 + Summit)."
    })

    Tools:CreateButton({
        Name = "Teleport to Basecamp",
        Callback = function()
            Utils.resetToBasecamp()
            Rayfield:Notify({
                Title = "Teleport",
                Content = "Kembali ke basecamp",
                Duration = 3
            })
        end
    })

    local selectedCP = "Checkpoint 1"

    Tools:CreateDropdown({
        Name = "Pilih Checkpoint",
        Options = {
            "Checkpoint 1", "Checkpoint 2", "Checkpoint 3", "Checkpoint 4", "Checkpoint 5",
            "Checkpoint 6", "Checkpoint 7", "Checkpoint 8", "Checkpoint 9", "Checkpoint 10",
            "Checkpoint 11", "Checkpoint 12", "Checkpoint 13", "Checkpoint 14", "Checkpoint 15",
            "Checkpoint 16", "Checkpoint 17", "Checkpoint 18", "Checkpoint 19", "Checkpoint 20",
            "Checkpoint 21", "Checkpoint 22", "Checkpoint 23", "Checkpoint 24", "Checkpoint 25",
            "Summit"
        },
        CurrentOption = {"Checkpoint 1"},
        MultipleOptions = false,
        Flag = "CPDropdown",
        Callback = function(Option)
            selectedCP = Option[1]
        end
    })

    Tools:CreateButton({
        Name = "Teleport to Checkpoint",
        Callback = function()
            local hrp = getHRP()
            
            if selectedCP == "Summit" then
                hrp.CFrame = GameData.SummitCP
                local part = Utils.getCheckpointPart(26)
                if part then Utils.fireTouch(part) end
                Utils.doJump()
                Rayfield:Notify({Title = "Teleport", Content = "Teleport ke Summit", Duration = 3})
            else
                local index = tonumber(selectedCP:match("%d+"))
                if index and GameData.Checkpoints[index] then
                    hrp.CFrame = GameData.Checkpoints[index]
                    local part = Utils.getCheckpointPart(index)
                    if part then Utils.fireTouch(part) end
                    Utils.doJump()
                    Rayfield:Notify({Title = "Teleport", Content = "Teleport ke CP " .. index, Duration = 3})
                end
            end
        end
    })

    -- Teleport to Player Section
    Tools:CreateSection("Teleport to Player :")

    local playerList = {}
    local selectedPlayer = nil
    local playerDropdown = nil

    local function getPlayerList()
        local players = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= lp then
                table.insert(players, player.Name)
            end
        end
        return players
    end

    local function refreshPlayerList()
        playerList = getPlayerList()
        if #playerList == 0 then
            playerList = {"No players available"}
            selectedPlayer = nil
        else
            selectedPlayer = playerList[1]
        end
        return playerList
    end

    refreshPlayerList()

    playerDropdown = Tools:CreateDropdown({
        Name = "Select Player",
        Options = playerList,
        CurrentOption = {playerList[1] or "No players available"},
        MultipleOptions = false,
        Flag = "PlayerDropdown",
        Callback = function(Option)
            selectedPlayer = Option[1]
        end
    })

    Tools:CreateButton({
        Name = "Refresh Player List",
        Callback = function()
            local newPlayerList = refreshPlayerList()
            
            if playerDropdown then
                playerDropdown:Refresh(newPlayerList)
            end
            
            Rayfield:Notify({
                Title = "Player List",
                Content = "Found " .. (#newPlayerList == 1 and newPlayerList[1] == "No players available" and "0" or tostring(#newPlayerList)) .. " players",
                Duration = 2
            })
        end
    })

    Tools:CreateButton({
        Name = "Teleport to Player",
        Callback = function()
            if not selectedPlayer or selectedPlayer == "No players available" then
                Rayfield:Notify({
                    Title = "Teleport Failed",
                    Content = "No player selected!",
                    Duration = 3
                })
                return
            end

            local targetPlayer = Players:FindFirstChild(selectedPlayer)
            if not targetPlayer then
                Rayfield:Notify({
                    Title = "Teleport Failed",
                    Content = "Player not found or left the game!",
                    Duration = 3
                })
                return
            end

            local targetChar = targetPlayer.Character
            if not targetChar then
                Rayfield:Notify({
                    Title = "Teleport Failed",
                    Content = "Player character not loaded!",
                    Duration = 3
                })
                return
            end

            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
            if not targetHRP then
                Rayfield:Notify({
                    Title = "Teleport Failed",
                    Content = "Cannot find player position!",
                    Duration = 3
                })
                return
            end

            local hrp = getHRP()
            hrp.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
            
            Rayfield:Notify({
                Title = "Teleport Success",
                Content = "Teleported to " .. selectedPlayer,
                Duration = 3
            })
        end
    })

    -- Teleport Tool Section
    Tools:CreateSection("Teleport Tool :")

    Tools:CreateParagraph({
        Title = "Teleport Tool Info",
        Content = "Get a Teleport Tool in your inventory. PC: Click to teleport. Mobile: Tap to teleport."
    })

    Tools:CreateButton({
        Name = "Get Teleport Tool",
        Callback = function()
            local TpTool = Instance.new("Tool")
            TpTool.Name = "Teleport Tool"
            TpTool.RequiresHandle = false
            TpTool.CanBeDropped = false
            TpTool.Parent = lp.Backpack
            
            TpTool.Activated:Connect(function()
                local Char = getCharacter()
                local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
                
                if not Char or not HRP then
                    Rayfield:Notify({
                        Title = "Teleport Failed",
                        Content = "Cannot find character!",
                        Duration = 3
                    })
                    return
                end
                
                local Mouse = lp:GetMouse()
                local targetPosition = nil
                
                if UserInputService.TouchEnabled then
                    local camera = workspace.CurrentCamera
                    local screenCenter = camera.ViewportSize / 2
                    local ray = camera:ViewportPointToRay(screenCenter.X, screenCenter.Y)
                    
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {Char}
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    
                    local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
                    
                    if raycastResult then
                        targetPosition = raycastResult.Position
                    end
                else
                    if Mouse.Hit then
                        targetPosition = Mouse.Hit.Position
                    end
                end
                
                if targetPosition then
                    HRP.CFrame = CFrame.new(targetPosition.X, targetPosition.Y + 3, targetPosition.Z) * CFrame.Angles(0, math.rad(HRP.CFrame:ToEulerAnglesXYZ()), 0)
                    
                    Rayfield:Notify({
                        Title = "Teleport Tool",
                        Content = "Teleported successfully!",
                        Duration = 2
                    })
                else
                    Rayfield:Notify({
                        Title = "Teleport Failed",
                        Content = "Cannot find target location!",
                        Duration = 3
                    })
                end
            end)
            
            Rayfield:Notify({
                Title = "Teleport Tool",
                Content = "Tool added to inventory! " .. (UserInputService.TouchEnabled and "Tap to teleport!" or "Click to teleport!"),
                Duration = 3
            })
        end
    })

    Tools:CreateButton({
        Name = "Remove Teleport Tool",
        Callback = function()
            local toolRemoved = false
            
            local backpackTool = lp.Backpack:FindFirstChild("Teleport Tool")
            if backpackTool then
                backpackTool:Destroy()
                toolRemoved = true
            end
            
            local char = getCharacter()
            if char then
                local equippedTool = char:FindFirstChild("Teleport Tool")
                if equippedTool then
                    equippedTool:Destroy()
                    toolRemoved = true
                end
            end
            
            if toolRemoved then
                Rayfield:Notify({
                    Title = "Teleport Tool",
                    Content = "Tool removed from inventory!",
                    Duration = 3
                })
            else
                Rayfield:Notify({
                    Title = "Teleport Tool",
                    Content = "No tool found to remove!",
                    Duration = 3
                })
            end
        end
    })

    -- Movement Tools Section
    Tools:CreateSection("Movement :")

    Tools:CreateButton({
        Name = "Bypass AntiCheat",
        Callback = function()
            local success, message = MovementModule:ActivateBypass()
            Rayfield:Notify({
                Title = success and "Bypass Activated" or "Bypass",
                Content = message,
                Duration = success and 5 or 3
            })
        end
    })

    Tools:CreateToggle({
        Name = "Custom WalkSpeed",
        CurrentValue = false,
        Flag = "ToggleWS",
        Callback = function(Value)
            MovementModule:SetWalkSpeed(Value)
            Rayfield:Notify({
                Title = "WalkSpeed",
                Content = Value and "WalkSpeed aktif!" or "WalkSpeed default",
                Duration = 2
            })
        end
    })

    Tools:CreateSlider({
        Name = "WalkSpeed Value",
        Range = {16, 300},
        Increment = 1,
        Suffix = " WS",
        CurrentValue = 16,
        Flag = "WSSlider",
        Callback = function(Value)
            MovementModule:UpdateWalkSpeed(Value)
        end
    })

    Tools:CreateToggle({
        Name = "Custom JumpPower",
        CurrentValue = false,
        Flag = "ToggleJP",
        Callback = function(Value)
            MovementModule:SetJumpPower(Value)
            Rayfield:Notify({
                Title = "JumpPower",
                Content = Value and "JumpPower aktif!" or "JumpPower default",
                Duration = 2
            })
        end
    })

    Tools:CreateSlider({
        Name = "JumpPower Value",
        Range = {50, 300},
        Increment = 5,
        Suffix = " JP",
        CurrentValue = 50,
        Flag = "JPSlider",
        Callback = function(Value)
            MovementModule:UpdateJumpPower(Value)
        end
    })

    Tools:CreateButton({
        Name = "Reset to Default Movement",
        Callback = function()
            MovementModule:SetWalkSpeed(false)
            MovementModule:SetJumpPower(false)
            
            MovementModule.WalkSpeed = MovementModule.DefaultWS
            MovementModule.JumpPower = MovementModule.DefaultJP
            
            local hum = getHumanoid()
            if hum then
                hum.WalkSpeed = MovementModule.DefaultWS
                if hum.UseJumpPower then
                    hum.JumpPower = MovementModule.DefaultJP
                else
                    hum.JumpHeight = MovementModule.DefaultJP
                end
            end
            
            Rayfield:Notify({
                Title = "Movement Reset",
                Content = "WalkSpeed dan JumpPower kembali ke default!",
                Duration = 3
            })
        end
    })

    -- Fly Section
    Tools:CreateSection("Fly :")
    
    Tools:CreateParagraph({
        Title = "Fly Controls",
        Content = "PC: WASD to move. Mobile: Use joystick to move."
    })

    Tools:CreateToggle({
        Name = "Normal Fly",
        CurrentValue = false,
        Flag = "ToggleFly",
        Callback = function(Value)
            if Value then
                if FlyModule.IsOnMobile then
                    FlyModule:StartMobileFly()
                else
                    FlyModule:StartPCFly()
                end
                Rayfield:Notify({Title = "Fly Activated", Content = "Fly mode aktif!", Duration = 3})
            else
                FlyModule:Stop()
                Rayfield:Notify({Title = "Fly Deactivated", Content = "Fly mode dimatikan", Duration = 3})
            end
        end
    })
  
    Tools:CreateSlider({
        Name = "Fly Speed",
        Range = {0, 100},
        Increment = 1,
        Suffix = " speed",
        CurrentValue = 1,
        Flag = "FlySpeed",
        Callback = function(Value)
            FlyModule.Speed = Value
        end
    })

    -- ====================
    -- MISC TAB - MOUNT STECU
    -- ====================
    local Misc = Window:CreateTab("Misc", nil)
    
    local function getPlayerInfo()
        local nickname = lp.Name
        local checkpointValue = Utils.getCurrentCheckpoint()
        local checkpointText = ""
        
        if checkpointValue == 0 then
            checkpointText = "You're at Basecamp"
        elseif checkpointValue == 26 then
            checkpointText = "You're at Summit"
        else
            checkpointText = "You're at Checkpoint " .. checkpointValue
        end
        
        local totalSummit = Utils.getTotalSummit()
        local bestTime = Utils.getBestTime()
        
        return string.format(
            "Nickname : %s\nCheckpoint : %s\nTotal Summit : %d\nBest Time : %s",
            nickname,
            checkpointText,
            totalSummit,
            tostring(bestTime)
        )
    end
    
    local PlayerInfoParagraph = Misc:CreateParagraph({
        Title = "Information Player :",
        Content = getPlayerInfo()
    })
    
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                PlayerInfoParagraph:Set({
                    Title = "Information Player :",
                    Content = getPlayerInfo()
                })
            end)
        end
    end)
    
    if lp:FindFirstChild("leaderstats") then
        local leaderstats = lp.leaderstats
        
        if leaderstats:FindFirstChild("Checkpoint") then
            leaderstats.Checkpoint.Changed:Connect(function()
                pcall(function()
                    PlayerInfoParagraph:Set({
                        Title = "Information Player :",
                        Content = getPlayerInfo()
                    })
                end)
            end)
        end
        
        if leaderstats:FindFirstChild("Summit") then
            leaderstats.Summit.Changed:Connect(function()
                pcall(function()
                    PlayerInfoParagraph:Set({
                        Title = "Information Player :",
                        Content = getPlayerInfo()
                    })
                end)
            end)
        end
        
        if leaderstats:FindFirstChild("BestTime") then
            leaderstats.BestTime.Changed:Connect(function()
                pcall(function()
                    PlayerInfoParagraph:Set({
                        Title = "Information Player :",
                        Content = getPlayerInfo()
                    })
                end)
            end)
        end
    end
    
    Misc:CreateSection("created by Zu11")

end 