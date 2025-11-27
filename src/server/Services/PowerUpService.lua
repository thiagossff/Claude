--[[
    Serviço de Power-Ups
    Gerencia power-ups de velocidade, pulo, etc.
]]

local PowerUpService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

-- Tipos de power-ups
local POWERUP_TYPES = {
    Speed = {
        Name = "Speed Boost",
        Color = Color3.fromRGB(0, 255, 255),
        Icon = "⚡",
        Duration = 10,
        Multiplier = 1.5,
    },
    Jump = {
        Name = "Jump Boost",
        Color = Color3.fromRGB(255, 0, 255),
        Icon = "🦘",
        Duration = 10,
        Multiplier = 1.5,
    },
    Shield = {
        Name = "Shield",
        Color = Color3.fromRGB(0, 255, 0),
        Icon = "🛡️",
        Duration = 15,
    }
}

-- Power-ups ativos
local activePowerUps = {}

-- Inicializa o serviço
function PowerUpService:Init()
    print("[PowerUpService] Iniciando serviço de power-ups...")

    -- Limpa power-ups quando jogador sai
    Players.PlayerRemoving:Connect(function(player)
        activePowerUps[player.UserId] = nil
    end)

    -- Registra power-ups do mapa
    self:RegisterPowerUps()
end

-- Registra power-ups no mapa
function PowerUpService:RegisterPowerUps()
    local powerUpFolder = workspace:FindFirstChild("PowerUps")
    if not powerUpFolder then
        warn("[PowerUpService] Pasta 'PowerUps' não encontrada!")
        powerUpFolder = Instance.new("Folder")
        powerUpFolder.Name = "PowerUps"
        powerUpFolder.Parent = workspace
    end

    for _, powerUp in ipairs(powerUpFolder:GetChildren()) do
        if powerUp:IsA("BasePart") or powerUp:IsA("Model") then
            self:SetupPowerUp(powerUp)
        end
    end

    print("[PowerUpService] Power-ups registrados!")
end

-- Configura um power-up
function PowerUpService:SetupPowerUp(powerUp)
    local powerUpPart = powerUp:IsA("Model") and powerUp.PrimaryPart or powerUp
    if not powerUpPart then return end

    local powerUpType = powerUp:GetAttribute("Type") or "Speed"
    local config = POWERUP_TYPES[powerUpType]

    if not config then
        warn("[PowerUpService] Tipo de power-up inválido:", powerUpType)
        return
    end

    -- Visual
    powerUpPart.BrickColor = BrickColor.new(config.Color)
    powerUpPart.Material = Enum.Material.Neon
    powerUpPart.CanCollide = false

    -- Rotação
    self:AddRotation(powerUpPart)

    -- Efeitos visuais
    self:AddVisualEffects(powerUpPart, config.Color)

    -- Evento de toque
    powerUpPart.Touched:Connect(function(hit)
        local character = hit.Parent
        local player = Players:GetPlayerFromCharacter(character)

        if player then
            self:ActivatePowerUp(player, powerUpType, powerUp)
        end
    end)
end

-- Ativa power-up para jogador
function PowerUpService:ActivatePowerUp(player, powerUpType, powerUpObject)
    local config = POWERUP_TYPES[powerUpType]
    if not config then return end

    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    -- Esconde o power-up
    powerUpObject.Parent = game:GetService("ServerStorage")

    -- Efeito visual
    self:PlayCollectionEffect(powerUpObject)

    -- Aplica efeito baseado no tipo
    if powerUpType == "Speed" then
        self:ApplySpeedBoost(player, humanoid, config)
    elseif powerUpType == "Jump" then
        self:ApplyJumpBoost(player, humanoid, config)
    elseif powerUpType == "Shield" then
        self:ApplyShield(player, character, config)
    end

    -- Notifica cliente
    local remoteEvent = ReplicatedStorage:FindFirstChild("PowerUpActivated")
    if remoteEvent then
        remoteEvent:FireClient(player, powerUpType, config.Duration)
    end

    -- Respawn do power-up após um tempo
    wait(30) -- 30 segundos
    powerUpObject.Parent = workspace:FindFirstChild("PowerUps")

    print(string.format("[PowerUpService] %s ativou %s", player.Name, config.Name))
end

-- Aplica boost de velocidade
function PowerUpService:ApplySpeedBoost(player, humanoid, config)
    local originalSpeed = humanoid.WalkSpeed

    humanoid.WalkSpeed = originalSpeed * config.Multiplier

    -- Efeito visual de velocidade
    self:AddSpeedTrail(player.Character)

    -- Remove após duração
    wait(config.Duration)
    humanoid.WalkSpeed = originalSpeed
end

-- Aplica boost de pulo
function PowerUpService:ApplyJumpBoost(player, humanoid, config)
    local originalJumpPower = humanoid.JumpPower

    humanoid.JumpPower = originalJumpPower * config.Multiplier

    -- Remove após duração
    wait(config.Duration)
    humanoid.JumpPower = originalJumpPower
end

-- Aplica escudo
function PowerUpService:ApplyShield(player, character, config)
    -- Cria efeito visual de escudo
    local shield = Instance.new("Part")
    shield.Name = "Shield"
    shield.Shape = Enum.PartType.Ball
    shield.Size = Vector3.new(8, 8, 8)
    shield.Transparency = 0.7
    shield.CanCollide = false
    shield.Material = Enum.Material.ForceField
    shield.BrickColor = BrickColor.new(config.Color)
    shield.Anchored = false

    local weld = Instance.new("Weld")
    weld.Part0 = character:WaitForChild("HumanoidRootPart")
    weld.Part1 = shield
    weld.Parent = shield

    shield.Parent = character

    -- Remove após duração
    Debris:AddItem(shield, config.Duration)
end

-- Adiciona rotação ao power-up
function PowerUpService:AddRotation(part)
    local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 4, 0)
    bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
    bodyAngularVelocity.Parent = part
end

-- Adiciona efeitos visuais
function PowerUpService:AddVisualEffects(part, color)
    local pointLight = Instance.new("PointLight")
    pointLight.Color = color
    pointLight.Brightness = 3
    pointLight.Range = 15
    pointLight.Parent = part

    local particles = Instance.new("ParticleEmitter")
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Color = ColorSequence.new(color)
    particles.Rate = 20
    particles.Lifetime = NumberRange.new(0.5, 1)
    particles.Speed = NumberRange.new(2, 5)
    particles.Parent = part
end

-- Efeito de coleta
function PowerUpService:PlayCollectionEffect(powerUp)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://5153734116"
    sound.Volume = 0.7
    sound.Parent = powerUp
    sound:Play()

    Debris:AddItem(sound, 2)
end

-- Adiciona rastro de velocidade
function PowerUpService:AddSpeedTrail(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local trail = Instance.new("Trail")
    trail.Lifetime = 0.5
    trail.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    trail.Transparency = NumberSequence.new(0.5)
    trail.LightEmission = 1

    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = hrp
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = hrp

    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Parent = hrp

    Debris:AddItem(trail, 10)
end

return PowerUpService
