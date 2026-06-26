-- 🧩 Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "CodeNest Hub | Rivals V2",
    LoadingTitle = "CodeNest Hub",
    LoadingSubtitle = "Anti-Detection Active",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
    Theme = "Default"
})

-- === CREATE TABS ===
local MainTab = Window:CreateTab("MAIN", 4483362458)
local VisualsTab = Window:CreateTab("VISUALS", 4483362458)
local GunModsTab = Window:CreateTab("GUN MODS", 4483362458)
local StatsTab = Window:CreateTab("STATS", 4483362458)
local OthersTab = Window:CreateTab("OTHERS", 4483362458)

-- === MAIN TAB ===
MainTab:CreateButton({ 
    Name = "Load Stealth Aimbot", 
    Callback = function() 
        task.spawn(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DanielHubll/DanielHubll/refs/heads/main/Aimbot%20Mobile"))() 
        end)
        Rayfield:Notify({ Title = "CodeNest Hub", Content = "Stealth Aimbot Loaded", Duration = 4 }) 
    end 
})

-- === VISUALS TAB ===
local espEnabled = false
local highlights = {}

local function applyESP(player)
    if player == LocalPlayer then return end
    player.CharacterAdded:Connect(function(char)
        if espEnabled then
            task.wait(0.5)
            local h = Instance.new("Highlight", char)
            h.FillColor = Color3.fromRGB(255, 0, 0)
            highlights[player] = h
        end
    end)
end

VisualsTab:CreateToggle({
    Name = "ESP Chams (Bypass)",
    CurrentValue = false,
    Callback = function(val)
        espEnabled = val
        for _, p in pairs(Players:GetPlayers()) do
            if val then
                if p.Character then
                    local h = Instance.new("Highlight", p.Character)
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                    highlights[p] = h
                end
            else
                if highlights[p] then highlights[p]:Destroy() highlights[p] = nil end
            end
        end
    end
})

-- === GUN MODS TAB ===
GunModsTab:CreateButton({ 
    Name = "Enable Safe Gun Mods", 
    Callback = function() 
        task.spawn(function()
            while task.wait(5) do
                for _, v in pairs(getgc(true)) do
                    if type(v) == "table" and (rawget(v, "ShootCooldown") or rawget(v, "FireRate")) then
                        v.ShootCooldown = 0.05
                        v.ShootSpread = 0
                        v.ShootRecoil = 0
                        v.RecoilData = nil
                    end
                end
            end
        end)
        Rayfield:Notify({ Title = "CodeNest Hub", Content = "Mods Active (Auto-Refresh)", Duration = 4 })
    end 
})

-- === STATS TAB ===
local killsLabel = StatsTab:CreateParagraph({Title = "Kills: 0", Content = "Deaths: 0"})

task.spawn(function()
    while task.wait(1) do
        local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            local k = leaderstats:FindFirstChild("Kills") and leaderstats.Kills.Value or 0
            local d = leaderstats:FindFirstChild("Deaths") and leaderstats.Deaths.Value or 0
            killsLabel:Set({Title = "Kills: "..k, Content = "Deaths: "..d})
        end
    end
end)

-- === OTHERS TAB ===
OthersTab:CreateSlider({ 
    Name = "Safe WalkSpeed", 
    Range = {16, 40}, 
    Increment = 1, 
    CurrentValue = 16, 
    Callback = function(val) 
        if LocalPlayer.Character then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
        end
    end 
})

OthersTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        game:GetService("UserInputService").JumpRequest:Connect(function()
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end)
    end
})

-- Notification that script loaded
Rayfield:Notify({ Title = "CodeNest Hub", Content = "✅ Script Loaded Successfully!", Duration = 4 })