--[[
    Script Principal do Servidor
    Inicializa todos os serviços do jogo
]]

print("=================================")
print("🎮 Adventure Obby - Servidor")
print("=================================")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Cria RemoteEvents necessários
local function createRemoteEvents()
    local remoteEvents = {
        "CheckpointReached",
        "StarCollected",
        "PowerUpActivated",
        "UpdatePlayerData"
    }

    for _, eventName in ipairs(remoteEvents) do
        if not ReplicatedStorage:FindFirstChild(eventName) then
            local remoteEvent = Instance.new("RemoteEvent")
            remoteEvent.Name = eventName
            remoteEvent.Parent = ReplicatedStorage
        end
    end

    print("[ServerMain] RemoteEvents criados!")
end

-- Carrega serviços
local function loadServices()
    local services = {}

    -- Tenta carregar CheckpointService
    local checkpointModule = script.Parent.Services:FindFirstChild("CheckpointService")
    if checkpointModule then
        services.CheckpointService = require(checkpointModule)
    end

    -- Tenta carregar StarCollectionService
    local starModule = script.Parent.Services:FindFirstChild("StarCollectionService")
    if starModule then
        services.StarCollectionService = require(starModule)
    end

    -- Tenta carregar PowerUpService
    local powerUpModule = script.Parent.Services:FindFirstChild("PowerUpService")
    if powerUpModule then
        services.PowerUpService = require(powerUpModule)
    end

    return services
end

-- Inicializa serviços
local function initializeServices(services)
    for name, service in pairs(services) do
        if service.Init then
            local success, err = pcall(function()
                service:Init()
            end)

            if success then
                print(string.format("[ServerMain] ✓ %s inicializado", name))
            else
                warn(string.format("[ServerMain] ✗ Erro ao inicializar %s: %s", name, err))
            end
        end
    end
end

-- Configura o ambiente do jogo
local function setupGameEnvironment()
    -- Cria pastas necessárias no Workspace
    local folders = {"Checkpoints", "Stars", "PowerUps", "Obstacles"}

    for _, folderName in ipairs(folders) do
        if not workspace:FindFirstChild(folderName) then
            local folder = Instance.new("Folder")
            folder.Name = folderName
            folder.Parent = workspace
            print(string.format("[ServerMain] Pasta '%s' criada no Workspace", folderName))
        end
    end

    -- Configurações de iluminação para ambiente infantil
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 2
    lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    lighting.Ambient = Color3.fromRGB(100, 100, 100)
    lighting.ClockTime = 14 -- Meio da tarde

    -- Adiciona céu colorido
    if not lighting:FindFirstChildOfClass("Sky") then
        local sky = Instance.new("Sky")
        sky.SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex"
        sky.SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex"
        sky.SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex"
        sky.SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex"
        sky.SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex"
        sky.SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
        sky.Parent = lighting
    end
end

-- Cria exemplos de checkpoints
local function createExampleCheckpoints()
    local checkpointFolder = workspace:FindFirstChild("Checkpoints")
    if not checkpointFolder then return end

    -- Só cria se não houver checkpoints
    if #checkpointFolder:GetChildren() > 0 then return end

    -- Cria 5 checkpoints de exemplo
    for i = 1, 5 do
        local checkpoint = Instance.new("Part")
        checkpoint.Name = "Checkpoint" .. i
        checkpoint.Size = Vector3.new(10, 1, 10)
        checkpoint.Position = Vector3.new(0, 5, i * 20)
        checkpoint.Anchored = true
        checkpoint.BrickColor = BrickColor.new("Bright green")
        checkpoint.Material = Enum.Material.Neon
        checkpoint.Transparency = 0.3
        checkpoint.CanCollide = false
        checkpoint.Parent = checkpointFolder

        print(string.format("[ServerMain] Checkpoint %d criado", i))
    end
end

-- Cria exemplos de estrelas
local function createExampleStars()
    local starFolder = workspace:FindFirstChild("Stars")
    if not starFolder then return end

    -- Só cria se não houver estrelas
    if #starFolder:GetChildren() > 0 then return end

    -- Cria estrelas de exemplo ao longo do percurso
    for i = 1, 10 do
        local star = Instance.new("Part")
        star.Name = "Star" .. i
        star.Size = Vector3.new(2, 2, 0.5)
        star.Position = Vector3.new(math.random(-5, 5), 8, i * 10)
        star.Anchored = true
        star:SetAttribute("Value", 10)
        star:SetAttribute("StarID", "Star" .. i)
        star.Parent = starFolder

        print(string.format("[ServerMain] Estrela %d criada", i))
    end
end

-- Cria exemplos de power-ups
local function createExamplePowerUps()
    local powerUpFolder = workspace:FindFirstChild("PowerUps")
    if not powerUpFolder then return end

    -- Só cria se não houver power-ups
    if #powerUpFolder:GetChildren() > 0 then return end

    local powerUpTypes = {"Speed", "Jump", "Shield"}

    for i, powerType in ipairs(powerUpTypes) do
        local powerUp = Instance.new("Part")
        powerUp.Name = powerType .. "PowerUp"
        powerUp.Size = Vector3.new(2, 2, 2)
        powerUp.Position = Vector3.new(math.random(-8, 8), 7, i * 25)
        powerUp.Anchored = true
        powerUp:SetAttribute("Type", powerType)
        powerUp.Parent = powerUpFolder

        print(string.format("[ServerMain] Power-up %s criado", powerType))
    end
end

-- === INICIALIZAÇÃO PRINCIPAL ===

-- 1. Cria RemoteEvents
createRemoteEvents()

-- 2. Configura ambiente
setupGameEnvironment()

-- 3. Carrega serviços
local services = loadServices()

-- 4. Inicializa serviços
initializeServices(services)

-- 5. Cria exemplos (apenas para desenvolvimento)
wait(1) -- Espera um pouco para garantir que tudo carregou
createExampleCheckpoints()
createExampleStars()
createExamplePowerUps()

print("=================================")
print("✓ Servidor inicializado com sucesso!")
print("=================================")
