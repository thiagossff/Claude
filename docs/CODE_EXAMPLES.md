# 💻 Exemplos de Código - Adventure Obby

Este documento contém exemplos práticos de como expandir e personalizar o jogo.

## 🎯 Criando Obstáculos Personalizados

### Plataforma que Desaparece

```lua
-- Coloque este script em uma Part que será o obstáculo
local platform = script.Parent
local disappearTime = 2  -- Tempo visível (segundos)
local reappearTime = 3   -- Tempo invisível (segundos)

while true do
    -- Plataforma visível e sólida
    platform.Transparency = 0
    platform.CanCollide = true
    wait(disappearTime)

    -- Plataforma invisível e intangível
    platform.Transparency = 1
    platform.CanCollide = false
    wait(reappearTime)
end
```

### Plataforma Móvel

```lua
-- Coloque em uma Part
local platform = script.Parent
local TweenService = game:GetService("TweenService")

local startPos = platform.Position
local endPos = startPos + Vector3.new(20, 0, 0)  -- Move 20 studs no eixo X

local tweenInfo = TweenInfo.new(
    3,                              -- Duração
    Enum.EasingStyle.Linear,        -- Estilo
    Enum.EasingDirection.InOut,     -- Direção
    -1,                             -- Repetir infinitamente
    true                            -- Reverter
)

local tween = TweenService:Create(platform, tweenInfo, {Position = endPos})
tween:Play()
```

### Laser Mortal

```lua
-- Coloque em uma Part vermelha que será o laser
local laser = script.Parent
laser.BrickColor = BrickColor.new("Really red")
laser.Material = Enum.Material.Neon

laser.Touched:Connect(function(hit)
    local humanoid = hit.Parent:FindFirstChild("Humanoid")
    if humanoid then
        -- Mata o jogador (respawn no checkpoint)
        humanoid.Health = 0
    end
end)
```

## ⭐ Criando Estrelas Especiais

### Estrela Arco-Íris

```lua
-- Coloque em ServerScriptService
local StarCollectionService = require(game.ReplicatedStorage.Services.StarCollectionService)
local TweenService = game:GetService("TweenService")

local star = StarCollectionService:CreateStar(
    Vector3.new(0, 15, 50),
    100,  -- Vale 100 pontos!
    true  -- É estrela bônus
)

-- Anima as cores
spawn(function()
    while star and star.Parent do
        local colors = {
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(255, 127, 0),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(75, 0, 130),
            Color3.fromRGB(148, 0, 211)
        }

        for _, color in ipairs(colors) do
            if not star or not star.Parent then break end
            star.Color = color
            wait(0.5)
        end
    end
end)
```

### Estrela que Se Move

```lua
local star = StarCollectionService:CreateStar(
    Vector3.new(10, 10, 30),
    25,
    false
)

-- Movimento circular
local radius = 5
local speed = 2
local angle = 0
local center = star.Position

game:GetService("RunService").Heartbeat:Connect(function(dt)
    if not star or not star.Parent then return end

    angle = angle + speed * dt
    local x = center.X + math.cos(angle) * radius
    local z = center.Z + math.sin(angle) * radius

    star.Position = Vector3.new(x, center.Y, z)
end)
```

## 🚀 Novos Power-ups

### Criar Power-up de Invisibilidade

Adicione em `PowerUpService.lua`:

```lua
-- No topo, adicione à tabela POWERUP_TYPES:
Invisibility = {
    Name = "Invisibilidade",
    Color = Color3.fromRGB(200, 200, 200),
    Icon = "👻",
    Duration = 8,
}

-- Adicione nova função:
function PowerUpService:ApplyInvisibility(player, character, config)
    -- Torna todas as partes transparentes
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local originalTransparency = part.Transparency
            part.Transparency = 0.8

            -- Restaura após duração
            delay(config.Duration, function()
                part.Transparency = originalTransparency
            end)
        end
    end
end

-- No método ActivatePowerUp, adicione:
elseif powerUpType == "Invisibility" then
    self:ApplyInvisibility(player, character, config)
```

### Criar Power-up de Voo

```lua
-- Em POWERUP_TYPES:
Flight = {
    Name = "Voo",
    Color = Color3.fromRGB(135, 206, 235),
    Icon = "🕊️",
    Duration = 12,
}

-- Nova função:
function PowerUpService:ApplyFlight(player, character, config)
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end

    -- Cria força de voo
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(0, 4000, 0)
    bodyVelocity.Parent = character.HumanoidRootPart

    -- Remove após duração
    game:GetService("Debris"):AddItem(bodyVelocity, config.Duration)

    -- Efeito de asas (opcional)
    local leftWing = Instance.new("Part")
    leftWing.Size = Vector3.new(0.2, 3, 1)
    leftWing.Color = Color3.fromRGB(255, 255, 255)
    leftWing.Material = Enum.Material.Neon
    leftWing.CanCollide = false

    local weld = Instance.new("Weld")
    weld.Part0 = character.UpperTorso or character.Torso
    weld.Part1 = leftWing
    weld.C0 = CFrame.new(-2, 0, 0)
    weld.Parent = leftWing
    leftWing.Parent = character

    game:GetService("Debris"):AddItem(leftWing, config.Duration)
end
```

## 🏆 Sistema de Conquistas

### Adicionar Conquistas Personalizadas

Crie um novo arquivo `src/server/Services/AchievementService.lua`:

```lua
local AchievementService = {}

local ACHIEVEMENTS = {
    first_star = {
        Name = "Primeira Estrela",
        Description = "Colete sua primeira estrela!",
        Icon = "⭐",
        Reward = 50
    },
    speed_demon = {
        Name = "Demônio da Velocidade",
        Description = "Use 10 power-ups de velocidade",
        Icon = "⚡",
        Reward = 100
    },
    checkpoint_master = {
        Name = "Mestre dos Checkpoints",
        Description = "Alcance o checkpoint 10",
        Icon = "🏁",
        Reward = 200
    }
}

function AchievementService:CheckAchievement(player, achievementId)
    local achievement = ACHIEVEMENTS[achievementId]
    if not achievement then return end

    -- Verifica se jogador já tem
    local PlayerData = require(game.ReplicatedStorage.Shared.Modules.PlayerData)
    local data = PlayerData.new(player)

    if data:AddAchievement(achievementId) then
        -- Notifica jogador
        local event = game.ReplicatedStorage:FindFirstChild("AchievementUnlocked")
        if event then
            event:FireClient(player, achievement)
        end

        print(string.format("%s desbloqueou: %s", player.Name, achievement.Name))
    end
end

return AchievementService
```

### Conectar Conquistas aos Eventos

Em `StarCollectionService.lua`, adicione:

```lua
-- No topo
local AchievementService = require(script.Parent.AchievementService)

-- Na função CollectStar, após coletar primeira estrela:
if #playerStars == 1 then
    AchievementService:CheckAchievement(player, "first_star")
end
```

## 🎨 Efeitos Visuais Avançados

### Rastro Colorido ao Correr

```lua
-- LocalScript em StarterCharacterScripts
local character = script.Parent
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local trail = Instance.new("Trail")
trail.Lifetime = 0.5
trail.MinLength = 0.1
trail.FaceCamera = true

-- Gradiente de cores
trail.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
})

trail.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.5),
    NumberSequenceKeypoint.new(1, 1)
})

local attachment0 = Instance.new("Attachment")
attachment0.Position = Vector3.new(-0.5, 0, 0)
attachment0.Parent = humanoidRootPart

local attachment1 = Instance.new("Attachment")
attachment1.Position = Vector3.new(0.5, 0, 0)
attachment1.Parent = humanoidRootPart

trail.Attachment0 = attachment0
trail.Attachment1 = attachment1
trail.Parent = humanoidRootPart

-- Só mostra quando está correndo
game:GetService("RunService").Heartbeat:Connect(function()
    if humanoid.MoveVector.Magnitude > 0 then
        trail.Enabled = true
    else
        trail.Enabled = false
    end
end)
```

### Partículas de Confete ao Completar Fase

```lua
-- Em CheckpointService.lua, na função PlayerReachedCheckpoint:

-- Adicione após marcar checkpoint
if stage % 5 == 0 then  -- A cada 5 fases
    local confetti = Instance.new("ParticleEmitter")
    confetti.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    confetti.Rate = 100
    confetti.Lifetime = NumberRange.new(2, 4)
    confetti.Speed = NumberRange.new(10, 20)
    confetti.SpreadAngle = Vector2.new(180, 180)
    confetti.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
    })

    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        confetti.Parent = hrp
        confetti:Emit(50)
        game:GetService("Debris"):AddItem(confetti, 5)
    end
end
```

## 📊 Sistema de Leaderboard

### Criar Leaderboard Global

```lua
-- Script em ServerScriptService
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local stars = Instance.new("IntValue")
    stars.Name = "⭐ Estrelas"
    stars.Value = 0
    stars.Parent = leaderstats

    local stage = Instance.new("IntValue")
    stage.Name = "🏁 Fase"
    stage.Value = 1
    stage.Parent = leaderstats
end)

-- Conecte aos eventos para atualizar
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local starEvent = ReplicatedStorage:WaitForChild("StarCollected")
starEvent.OnServerEvent:Connect(function(player, value)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        leaderstats["⭐ Estrelas"].Value += value
    end
end)
```

## 🎵 Sistema de Música por Zona

```lua
-- LocalScript em StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local currentMusic = nil
local zones = {
    {
        Part = workspace.Zones.Zone1,
        MusicId = "rbxassetid://1837849285",
        Volume = 0.3
    },
    {
        Part = workspace.Zones.Zone2,
        MusicId = "rbxassetid://1234567890",
        Volume = 0.4
    }
}

local function playMusic(musicId, volume)
    if currentMusic then
        currentMusic:Stop()
        currentMusic:Destroy()
    end

    currentMusic = Instance.new("Sound")
    currentMusic.SoundId = musicId
    currentMusic.Volume = volume
    currentMusic.Looped = true
    currentMusic.Parent = workspace
    currentMusic:Play()
end

-- Verifica zona a cada segundo
while true do
    wait(1)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then continue end

    for _, zone in ipairs(zones) do
        local region = Region3.new(
            zone.Part.Position - zone.Part.Size/2,
            zone.Part.Position + zone.Part.Size/2
        )

        if region:IsInside(hrp.Position) then
            if not currentMusic or currentMusic.SoundId ~= zone.MusicId then
                playMusic(zone.MusicId, zone.Volume)
            end
            break
        end
    end
end
```

## 🎯 Dicas Finais

### Performance
- Use `Debris:AddItem()` para limpar objetos temporários
- Evite loops infinitos sem `wait()`
- Use eventos em vez de verificações constantes quando possível

### Debug
- Sempre adicione prints para rastrear problemas
- Use `warn()` para avisos importantes
- F9 abre o console no Roblox Studio

### Testes
- Teste com múltiplos jogadores (Server mode)
- Teste em dispositivos diferentes (móvel, PC)
- Peça feedback de crianças reais!

---

**Divirta-se criando! 🎮✨**
