If game.PlaceId == 93978595733734 then

local Rayfield = loadstring(game:HttpGet('https://[Log in to view URL]'))()

local Window = Rayfield:CreateWindow({
   Name = "Niggers black fuck",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "niggers hub",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://[Log in to view URL]

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = test script, -- Create a custom folder for your hub/game
      FileName = "tecca hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

-- 1. Bikin Tab
local MainTab = Window:CreateTab("Main Features", 4483362458) -- Icon ID bisa diganti

-- 2. Variabel buat kontrol ESP
local ESPEnabled = false

-- 3. Fungsi Logika ESP (Highlight)
local function applyESP()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer and player.Character then
            local char = player.Character
            
            -- Cek apakah sudah ada Highlight, kalau belum ada dan ESPEnabled true, buat baru
            local existing = char:FindFirstChild("RayfieldESP")
            if ESPEnabled then
                if not existing then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "RayfieldESP"
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = char
                end
            else
                if existing then
                    existing:Destroy() -- Hapus kalau dimatikan
                end
            end
        end
    end
end

-- 4. Bikin Toggle di UI
local Button = MainTab:CreateToggle({
   Name = "Enable ESP (Wallhack)",
   CurrentValue = false,
   Flag = "ESP_Toggle", 
   Callback = function(Value)
       ESPEnabled = Value
       
       -- Jalankan loop buat ngecek player
       spawn(function()
           while ESPEnabled do
               applyESP()
               task.wait(1) -- Update tiap 1 detik biar gak lag
           end
           applyESP() -- Panggil sekali lagi buat ngebersihin pas off
       end)
   end,
})

local MovementTab = Window:CreateTab("Movement", 4483362458)

MovementTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WS_Slider",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

MovementTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JP_Slider",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

local InfJumpEnabled = false
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfJumpEnabled then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

MovementTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
       InfJumpEnabled = Value
   end,
})

local NoclipEnabled = false
game:GetService("RunService").Stepped:Connect(function()
    if NoclipEnabled and game.Players.LocalPlayer.Character then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

MovementTab:CreateToggle({
   Name = "Noclip (Tembus Tembok)",
   CurrentValue = false,
   Flag = "NoclipFlag",
   Callback = function(Value)
       NoclipEnabled = Value
   end,
})