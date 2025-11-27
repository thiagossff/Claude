--[[
    Configurações do Jogo Adventure Obby
    Configurações gerais para gameplay infantil
]]

local GameConfig = {
    -- Configurações de Moedas/Estrelas
    StarValue = 10, -- Valor de cada estrela coletada
    BonusStarValue = 50, -- Estrelas especiais

    -- Configurações de Checkpoints
    CheckpointRespawnTime = 3, -- Tempo para respawn no checkpoint (segundos)

    -- Configurações de Power-ups
    SpeedBoostMultiplier = 1.5, -- Aumenta velocidade em 50%
    SpeedBoostDuration = 10, -- Duração do speed boost (segundos)
    JumpBoostMultiplier = 1.5, -- Aumenta pulo em 50%
    JumpBoostDuration = 10,

    -- Configurações de Segurança para Crianças
    ChatFiltered = true,
    SafeRespawn = true,
    AutoSave = true,
    AutoSaveInterval = 60, -- Salvar a cada 60 segundos

    -- Configurações de Interface
    UIAnimationSpeed = 0.5,
    ShowTutorial = true,

    -- Configurações de Jogo
    MaxStages = 20, -- Número total de fases
    StarsPerStage = 3, -- Estrelas por fase

    -- Cores do Tema (cores vibrantes para crianças)
    Colors = {
        Primary = Color3.fromRGB(255, 107, 107), -- Rosa/Vermelho
        Secondary = Color3.fromRGB(78, 205, 196), -- Azul claro
        Success = Color3.fromRGB(129, 236, 236), -- Ciano
        Warning = Color3.fromRGB(255, 195, 18), -- Amarelo
        Star = Color3.fromRGB(255, 234, 0), -- Amarelo estrela
    }
}

return GameConfig
