--[[
    Script Principal do Cliente
    Inicializa controllers e interface do usuário
]]

print("=================================")
print("🎮 Adventure Obby - Cliente")
print("=================================")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- Carrega UI
local function loadUI()
    local uiModule = script.Parent.UI:FindFirstChild("MainUI")
    if uiModule then
        local MainUI = require(uiModule)
        local ui = MainUI:CreateUI()

        print("[ClientMain] ✓ Interface criada")
        return MainUI
    else
        warn("[ClientMain] ✗ MainUI não encontrado!")
        return nil
    end
end

-- Conecta eventos do servidor
local function connectServerEvents(mainUI)
    -- Evento: Checkpoint alcançado
    local checkpointEvent = ReplicatedStorage:WaitForChild("CheckpointReached", 5)
    if checkpointEvent then
        checkpointEvent.OnClientEvent:Connect(function(stage)
            if mainUI then
                mainUI:UpdateStage(stage)
                mainUI:ShowFeedback("🏁 Checkpoint " .. stage .. "!", mainUI.COLORS and mainUI.COLORS.Success or Color3.fromRGB(129, 236, 236), 2)
            end

            -- Som de sucesso
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://5153734116"
            sound.Volume = 0.5
            sound.Parent = player:WaitForChild("PlayerGui")
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 2)

            print("[ClientMain] Checkpoint " .. stage .. " alcançado!")
        end)
    end

    -- Evento: Estrela coletada
    local starEvent = ReplicatedStorage:WaitForChild("StarCollected", 5)
    if starEvent then
        local totalStars = 0

        starEvent.OnClientEvent:Connect(function(value, isBonus)
            totalStars = totalStars + value

            if mainUI then
                mainUI:UpdateStars(totalStars)

                local message = isBonus and "⭐ Estrela Bônus! +" .. value or "⭐ +" .. value
                mainUI:ShowFeedback(message, Color3.fromRGB(255, 234, 0), 1.5)
            end

            -- Som de coleta
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://5153734116"
            sound.Volume = 0.6
            sound.Pitch = isBonus and 1.5 or 1.2
            sound.Parent = player:WaitForChild("PlayerGui")
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 2)

            print(string.format("[ClientMain] Estrela coletada! +%d (Total: %d)", value, totalStars))
        end)
    end

    -- Evento: Power-up ativado
    local powerUpEvent = ReplicatedStorage:WaitForChild("PowerUpActivated", 5)
    if powerUpEvent then
        powerUpEvent.OnClientEvent:Connect(function(powerUpType, duration)
            if mainUI then
                local icons = {
                    Speed = "⚡",
                    Jump = "🦘",
                    Shield = "🛡️"
                }

                local icon = icons[powerUpType] or "⭐"
                mainUI:ShowFeedback(icon .. " " .. powerUpType .. " Boost!", Color3.fromRGB(255, 107, 107), duration)
            end

            -- Som de power-up
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://5153734116"
            sound.Volume = 0.7
            sound.Pitch = 0.8
            sound.Parent = player:WaitForChild("PlayerGui")
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 2)

            print(string.format("[ClientMain] Power-up %s ativado por %ds", powerUpType, duration))
        end)
    end
end

-- Adiciona música de fundo (opcional)
local function addBackgroundMusic()
    local sound = Instance.new("Sound")
    sound.Name = "BackgroundMusic"
    sound.SoundId = "rbxassetid://1837849285" -- Música alegre
    sound.Volume = 0.3
    sound.Looped = true
    sound.Parent = workspace

    -- Só toca se o jogador quiser
    wait(2)
    -- sound:Play() -- Descomente para ativar música
end

-- Efeitos visuais do ambiente
local function addEnvironmentEffects()
    -- Adiciona partículas no ambiente
    local effectsFolder = Instance.new("Folder")
    effectsFolder.Name = "EnvironmentEffects"
    effectsFolder.Parent = workspace

    -- Confete caindo (opcional)
    --[[
    local confettiPart = Instance.new("Part")
    confettiPart.Size = Vector3.new(50, 1, 50)
    confettiPart.Position = Vector3.new(0, 50, 0)
    confettiPart.Anchored = true
    confettiPart.Transparency = 1
    confettiPart.CanCollide = false
    confettiPart.Parent = effectsFolder

    local confetti = Instance.new("ParticleEmitter")
    confetti.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    confetti.Rate = 10
    confetti.Lifetime = NumberRange.new(5, 8)
    confetti.Speed = NumberRange.new(5, 10)
    confetti.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 107, 107)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(78, 205, 196)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 234, 0))
    })
    confetti.Parent = confettiPart
    ]]--
end

-- === INICIALIZAÇÃO PRINCIPAL ===

-- Aguarda o jogador carregar
player:WaitForChild("PlayerGui")

-- 1. Carrega UI
local mainUI = loadUI()

-- 2. Conecta eventos
if mainUI then
    connectServerEvents(mainUI)
end

-- 3. Adiciona música e efeitos
addBackgroundMusic()
addEnvironmentEffects()

print("=================================")
print("✓ Cliente inicializado com sucesso!")
print("=================================")
