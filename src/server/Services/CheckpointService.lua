--[[
    Serviço de Checkpoints
    Gerencia os checkpoints do jogo e respawn dos jogadores
]]

local CheckpointService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Tabela para armazenar checkpoints de cada jogador
local playerCheckpoints = {}

-- Inicializa o serviço
function CheckpointService:Init()
    print("[CheckpointService] Iniciando serviço de checkpoints...")

    -- Conecta eventos de jogadores
    Players.PlayerAdded:Connect(function(player)
        self:SetupPlayer(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        playerCheckpoints[player.UserId] = nil
    end)

    -- Procura checkpoints existentes no workspace
    self:RegisterCheckpoints()
end

-- Configura jogador novo
function CheckpointService:SetupPlayer(player)
    playerCheckpoints[player.UserId] = {
        CurrentCheckpoint = nil,
        Stage = 1
    }

    -- Espera o personagem carregar
    player.CharacterAdded:Connect(function(character)
        self:OnCharacterSpawned(player, character)
    end)

    -- Se já tiver personagem, configura
    if player.Character then
        self:OnCharacterSpawned(player, player.Character)
    end
end

-- Quando o personagem spawna
function CheckpointService:OnCharacterSpawned(player, character)
    wait(0.1) -- Pequeno delay para garantir que tudo carregou

    local checkpoint = playerCheckpoints[player.UserId]
    if checkpoint and checkpoint.CurrentCheckpoint then
        -- Teleporta para o último checkpoint
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = checkpoint.CurrentCheckpoint
    end
end

-- Registra todos os checkpoints do jogo
function CheckpointService:RegisterCheckpoints()
    local checkpointFolder = workspace:FindFirstChild("Checkpoints")
    if not checkpointFolder then
        warn("[CheckpointService] Pasta 'Checkpoints' não encontrada no Workspace!")
        return
    end

    for _, checkpoint in ipairs(checkpointFolder:GetChildren()) do
        if checkpoint:IsA("BasePart") then
            self:SetupCheckpoint(checkpoint)
        end
    end

    print("[CheckpointService] Checkpoints registrados com sucesso!")
end

-- Configura um checkpoint individual
function CheckpointService:SetupCheckpoint(checkpoint)
    local stage = tonumber(checkpoint.Name:match("%d+")) or 1

    checkpoint.Touched:Connect(function(hit)
        local character = hit.Parent
        local player = Players:GetPlayerFromCharacter(character)

        if player then
            self:PlayerReachedCheckpoint(player, checkpoint, stage)
        end
    end)

    -- Visual do checkpoint
    checkpoint.BrickColor = BrickColor.new("Bright green")
    checkpoint.Material = Enum.Material.Neon
    checkpoint.Transparency = 0.3
    checkpoint.CanCollide = false
end

-- Quando jogador alcança um checkpoint
function CheckpointService:PlayerReachedCheckpoint(player, checkpoint, stage)
    local playerData = playerCheckpoints[player.UserId]
    if not playerData then return end

    -- Verifica se é um novo checkpoint
    if stage > playerData.Stage then
        playerData.Stage = stage
        playerData.CurrentCheckpoint = checkpoint.CFrame + Vector3.new(0, 5, 0)

        -- Efeito visual
        self:PlayCheckpointEffect(checkpoint)

        -- Notifica o cliente
        local remoteEvent = ReplicatedStorage:FindFirstChild("CheckpointReached")
        if remoteEvent then
            remoteEvent:FireClient(player, stage)
        end

        print(string.format("[CheckpointService] %s alcançou checkpoint %d", player.Name, stage))
    end
end

-- Efeito visual do checkpoint
function CheckpointService:PlayCheckpointEffect(checkpoint)
    -- Animação de brilho
    local originalTransparency = checkpoint.Transparency

    checkpoint.Transparency = 0
    wait(0.1)
    checkpoint.Transparency = 0.5
    wait(0.1)
    checkpoint.Transparency = 0
    wait(0.1)
    checkpoint.Transparency = originalTransparency

    -- Criar partículas (se disponível)
    local particles = checkpoint:FindFirstChildOfClass("ParticleEmitter")
    if particles then
        particles:Emit(20)
    end
end

-- Obtém checkpoint atual do jogador
function CheckpointService:GetPlayerCheckpoint(player)
    local playerData = playerCheckpoints[player.UserId]
    return playerData and playerData.CurrentCheckpoint
end

-- Define checkpoint manualmente
function CheckpointService:SetPlayerCheckpoint(player, cframe, stage)
    local playerData = playerCheckpoints[player.UserId]
    if playerData then
        playerData.CurrentCheckpoint = cframe
        playerData.Stage = stage
    end
end

return CheckpointService
