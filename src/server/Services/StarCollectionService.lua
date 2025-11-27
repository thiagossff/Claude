--[[
    Serviço de Coleta de Estrelas
    Gerencia a coleta de estrelas/moedas pelo mapa
]]

local StarCollectionService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Tabela para rastrear estrelas coletadas
local collectedStars = {}

-- Inicializa o serviço
function StarCollectionService:Init()
    print("[StarCollectionService] Iniciando serviço de coleta de estrelas...")

    -- Configura jogadores
    Players.PlayerAdded:Connect(function(player)
        collectedStars[player.UserId] = {}
    end)

    Players.PlayerRemoving:Connect(function(player)
        collectedStars[player.UserId] = nil
    end)

    -- Registra todas as estrelas
    self:RegisterStars()
end

-- Registra todas as estrelas do jogo
function StarCollectionService:RegisterStars()
    local starFolder = workspace:FindFirstChild("Stars")
    if not starFolder then
        warn("[StarCollectionService] Pasta 'Stars' não encontrada no Workspace!")
        -- Cria a pasta se não existir
        starFolder = Instance.new("Folder")
        starFolder.Name = "Stars"
        starFolder.Parent = workspace
    end

    for _, star in ipairs(starFolder:GetChildren()) do
        if star:IsA("BasePart") or star:IsA("Model") then
            self:SetupStar(star)
        end
    end

    print("[StarCollectionService] Estrelas registradas com sucesso!")
end

-- Configura uma estrela individual
function StarCollectionService:SetupStar(star)
    local starPart = star:IsA("Model") and star.PrimaryPart or star
    if not starPart then return end

    -- Configuração visual da estrela
    starPart.BrickColor = BrickColor.new("Bright yellow")
    starPart.Material = Enum.Material.Neon
    starPart.CanCollide = false

    -- Adiciona rotação constante
    self:AddRotation(starPart)

    -- Adiciona brilho
    self:AddSparkle(starPart)

    -- Evento de toque
    starPart.Touched:Connect(function(hit)
        local character = hit.Parent
        local player = Players:GetPlayerFromCharacter(character)

        if player then
            self:CollectStar(player, star)
        end
    end)
end

-- Adiciona rotação à estrela
function StarCollectionService:AddRotation(part)
    local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 2, 0)
    bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
    bodyAngularVelocity.P = 1000
    bodyAngularVelocity.Parent = part
end

-- Adiciona efeito de brilho
function StarCollectionService:AddSparkle(part)
    local sparkle = Instance.new("Sparkles")
    sparkle.SparkleColor = Color3.fromRGB(255, 255, 0)
    sparkle.Parent = part

    local pointLight = Instance.new("PointLight")
    pointLight.Color = Color3.fromRGB(255, 255, 0)
    pointLight.Brightness = 2
    pointLight.Range = 10
    pointLight.Parent = part
end

-- Quando jogador coleta uma estrela
function StarCollectionService:CollectStar(player, star)
    local starId = star:GetAttribute("StarID") or star.Name
    local playerStars = collectedStars[player.UserId]

    -- Verifica se já foi coletada
    if playerStars and not table.find(playerStars, starId) then
        table.insert(playerStars, starId)

        -- Efeito de coleta
        self:PlayCollectionEffect(star)

        -- Esconde a estrela
        star.Parent = game:GetService("ServerStorage")

        -- Determina valor da estrela
        local value = star:GetAttribute("Value") or 10
        local isBonus = star:GetAttribute("BonusStar") or false

        -- Notifica o cliente
        local remoteEvent = ReplicatedStorage:FindFirstChild("StarCollected")
        if remoteEvent then
            remoteEvent:FireClient(player, value, isBonus)
        end

        print(string.format("[StarCollectionService] %s coletou estrela: %s (+%d)",
            player.Name, starId, value))

        return true
    end

    return false
end

-- Efeito visual de coleta
function StarCollectionService:PlayCollectionEffect(star)
    local starPart = star:IsA("Model") and star.PrimaryPart or star
    if not starPart then return end

    -- Som de coleta
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://5153734116" -- Som de coleta
    sound.Volume = 0.5
    sound.Parent = starPart
    sound:Play()

    game:GetService("Debris"):AddItem(sound, 2)

    -- Partículas de explosão
    local particles = Instance.new("ParticleEmitter")
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 0))
    particles.Rate = 100
    particles.Lifetime = NumberRange.new(0.5, 1)
    particles.Speed = NumberRange.new(5, 10)
    particles.Parent = starPart
    particles.Enabled = true

    wait(0.1)
    particles.Enabled = false
    game:GetService("Debris"):AddItem(particles, 1)
end

-- Cria uma nova estrela programaticamente
function StarCollectionService:CreateStar(position, value, isBonus)
    local star = Instance.new("Part")
    star.Name = "Star_" .. tostring(tick())
    star.Size = Vector3.new(2, 2, 0.5)
    star.Position = position
    star.Anchored = true
    star:SetAttribute("Value", value or 10)
    star:SetAttribute("BonusStar", isBonus or false)
    star:SetAttribute("StarID", star.Name)

    local starFolder = workspace:FindFirstChild("Stars")
    if not starFolder then
        starFolder = Instance.new("Folder")
        starFolder.Name = "Stars"
        starFolder.Parent = workspace
    end

    star.Parent = starFolder
    self:SetupStar(star)

    return star
end

-- Reseta estrelas de um jogador
function StarCollectionService:ResetPlayerStars(player)
    collectedStars[player.UserId] = {}
end

return StarCollectionService
