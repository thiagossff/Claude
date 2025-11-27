--[[
    Módulo de Dados do Jogador
    Gerencia os dados de progresso de cada jogador
]]

local PlayerData = {}
PlayerData.__index = PlayerData

-- Estrutura padrão de dados do jogador
local DEFAULT_DATA = {
    Stars = 0,
    CurrentStage = 1,
    LastCheckpoint = nil,
    PowerUpsCollected = 0,
    TotalPlayTime = 0,
    Achievements = {},
    Settings = {
        MusicEnabled = true,
        SoundEffectsEnabled = true,
    }
}

-- Cria novos dados de jogador
function PlayerData.new(player)
    local self = setmetatable({}, PlayerData)
    self.Player = player
    self.Data = {}

    -- Copia dados padrão
    for key, value in pairs(DEFAULT_DATA) do
        if type(value) == "table" then
            self.Data[key] = {}
            for k, v in pairs(value) do
                self.Data[key][k] = v
            end
        else
            self.Data[key] = value
        end
    end

    return self
end

-- Adiciona estrelas ao jogador
function PlayerData:AddStars(amount)
    self.Data.Stars = self.Data.Stars + amount
    return self.Data.Stars
end

-- Obtém quantidade de estrelas
function PlayerData:GetStars()
    return self.Data.Stars
end

-- Atualiza a fase atual
function PlayerData:SetStage(stageNumber)
    if stageNumber > self.Data.CurrentStage then
        self.Data.CurrentStage = stageNumber
        return true
    end
    return false
end

-- Obtém a fase atual
function PlayerData:GetStage()
    return self.Data.CurrentStage
end

-- Define o último checkpoint
function PlayerData:SetCheckpoint(checkpointCFrame)
    self.Data.LastCheckpoint = checkpointCFrame
end

-- Obtém o último checkpoint
function PlayerData:GetCheckpoint()
    return self.Data.LastCheckpoint
end

-- Adiciona conquista
function PlayerData:AddAchievement(achievementId)
    if not table.find(self.Data.Achievements, achievementId) then
        table.insert(self.Data.Achievements, achievementId)
        return true
    end
    return false
end

-- Incrementa power-ups coletados
function PlayerData:IncrementPowerUps()
    self.Data.PowerUpsCollected = self.Data.PowerUpsCollected + 1
end

-- Obtém todos os dados
function PlayerData:GetAllData()
    return self.Data
end

-- Carrega dados salvos
function PlayerData:LoadData(savedData)
    if savedData then
        for key, value in pairs(savedData) do
            self.Data[key] = value
        end
    end
end

return PlayerData
