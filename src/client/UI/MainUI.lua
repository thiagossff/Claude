--[[
    Interface Principal do Jogo
    UI colorida e amigável para crianças
]]

local MainUI = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configurações de cores vibrantes
local COLORS = {
    Primary = Color3.fromRGB(255, 107, 107),
    Secondary = Color3.fromRGB(78, 205, 196),
    Success = Color3.fromRGB(129, 236, 236),
    Warning = Color3.fromRGB(255, 195, 18),
    Star = Color3.fromRGB(255, 234, 0),
    White = Color3.fromRGB(255, 255, 255),
}

-- Cria a interface principal
function MainUI:CreateUI()
    -- ScreenGui principal
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AdventureObbyUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    -- Container superior (estrelas e stage)
    self:CreateTopBar(screenGui)

    -- Mensagens de feedback
    self:CreateFeedbackLabel(screenGui)

    -- Tutorial inicial
    self:CreateTutorial(screenGui)

    print("[MainUI] Interface criada com sucesso!")
    return screenGui
end

-- Barra superior com informações
function MainUI:CreateTopBar(parent)
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 80)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundTransparency = 1
    topBar.Parent = parent

    -- Container de estrelas
    local starContainer = Instance.new("Frame")
    starContainer.Name = "StarContainer"
    starContainer.Size = UDim2.new(0, 200, 0, 60)
    starContainer.Position = UDim2.new(0, 20, 0, 10)
    starContainer.BackgroundColor3 = COLORS.Star
    starContainer.BorderSizePixel = 0
    starContainer.Parent = topBar

    -- Arredonda cantos
    local starCorner = Instance.new("UICorner")
    starCorner.CornerRadius = UDim.new(0, 15)
    starCorner.Parent = starContainer

    -- Ícone de estrela
    local starIcon = Instance.new("TextLabel")
    starIcon.Size = UDim2.new(0, 40, 0, 40)
    starIcon.Position = UDim2.new(0, 10, 0.5, -20)
    starIcon.BackgroundTransparency = 1
    starIcon.Text = "⭐"
    starIcon.TextSize = 30
    starIcon.Font = Enum.Font.GothamBold
    starIcon.Parent = starContainer

    -- Contador de estrelas
    local starCount = Instance.new("TextLabel")
    starCount.Name = "StarCount"
    starCount.Size = UDim2.new(0, 140, 0, 40)
    starCount.Position = UDim2.new(0, 55, 0.5, -20)
    starCount.BackgroundTransparency = 1
    starCount.Text = "0"
    starCount.TextSize = 32
    starCount.Font = Enum.Font.GothamBold
    starCount.TextColor3 = COLORS.White
    starCount.TextXAlignment = Enum.TextXAlignment.Left
    starCount.Parent = starContainer

    -- Sombra
    local starShadow = Instance.new("ImageLabel")
    starShadow.Size = UDim2.new(1, 6, 1, 6)
    starShadow.Position = UDim2.new(0, -3, 0, 3)
    starShadow.BackgroundTransparency = 1
    starShadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    starShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    starShadow.ImageTransparency = 0.7
    starShadow.ZIndex = -1
    starShadow.Parent = starContainer

    -- Container de Stage
    local stageContainer = Instance.new("Frame")
    stageContainer.Name = "StageContainer"
    stageContainer.Size = UDim2.new(0, 200, 0, 60)
    stageContainer.Position = UDim2.new(0, 240, 0, 10)
    stageContainer.BackgroundColor3 = COLORS.Secondary
    stageContainer.BorderSizePixel = 0
    stageContainer.Parent = topBar

    local stageCorner = Instance.new("UICorner")
    stageCorner.CornerRadius = UDim.new(0, 15)
    stageCorner.Parent = stageContainer

    -- Label de Stage
    local stageLabel = Instance.new("TextLabel")
    stageLabel.Name = "StageLabel"
    stageLabel.Size = UDim2.new(1, -20, 1, 0)
    stageLabel.Position = UDim2.new(0, 10, 0, 0)
    stageLabel.BackgroundTransparency = 1
    stageLabel.Text = "Fase 1"
    stageLabel.TextSize = 28
    stageLabel.Font = Enum.Font.GothamBold
    stageLabel.TextColor3 = COLORS.White
    stageLabel.Parent = stageContainer

    self.StarCountLabel = starCount
    self.StageLabel = stageLabel
end

-- Label de feedback (mensagens temporárias)
function MainUI:CreateFeedbackLabel(parent)
    local feedbackLabel = Instance.new("TextLabel")
    feedbackLabel.Name = "FeedbackLabel"
    feedbackLabel.Size = UDim2.new(0, 400, 0, 80)
    feedbackLabel.Position = UDim2.new(0.5, -200, 0.3, 0)
    feedbackLabel.BackgroundColor3 = COLORS.Success
    feedbackLabel.BorderSizePixel = 0
    feedbackLabel.Text = ""
    feedbackLabel.TextSize = 36
    feedbackLabel.Font = Enum.Font.GothamBold
    feedbackLabel.TextColor3 = COLORS.White
    feedbackLabel.Visible = false
    feedbackLabel.ZIndex = 10
    feedbackLabel.Parent = parent

    local feedbackCorner = Instance.new("UICorner")
    feedbackCorner.CornerRadius = UDim.new(0, 20)
    feedbackCorner.Parent = feedbackLabel

    self.FeedbackLabel = feedbackLabel
end

-- Tutorial inicial
function MainUI:CreateTutorial(parent)
    local tutorial = Instance.new("Frame")
    tutorial.Name = "Tutorial"
    tutorial.Size = UDim2.new(0, 500, 0, 300)
    tutorial.Position = UDim2.new(0.5, -250, 0.5, -150)
    tutorial.BackgroundColor3 = COLORS.Primary
    tutorial.BorderSizePixel = 0
    tutorial.Visible = true
    tutorial.ZIndex = 20
    tutorial.Parent = parent

    local tutorialCorner = Instance.new("UICorner")
    tutorialCorner.CornerRadius = UDim.new(0, 25)
    tutorialCorner.Parent = tutorial

    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 60)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "🎮 Bem-vindo ao Adventure Obby!"
    title.TextSize = 32
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = COLORS.White
    title.Parent = tutorial

    -- Instruções
    local instructions = Instance.new("TextLabel")
    instructions.Size = UDim2.new(1, -40, 0, 140)
    instructions.Position = UDim2.new(0, 20, 0, 90)
    instructions.BackgroundTransparency = 1
    instructions.Text = "⭐ Colete estrelas pelo caminho!\n\n🏁 Alcance os checkpoints verdes\n\n⚡ Pegue power-ups para habilidades!"
    instructions.TextSize = 24
    instructions.Font = Enum.Font.Gotham
    instructions.TextColor3 = COLORS.White
    instructions.TextWrapped = true
    instructions.TextYAlignment = Enum.TextYAlignment.Top
    instructions.Parent = tutorial

    -- Botão começar
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(0, 200, 0, 50)
    startButton.Position = UDim2.new(0.5, -100, 1, -70)
    startButton.BackgroundColor3 = COLORS.Success
    startButton.BorderSizePixel = 0
    startButton.Text = "Começar! 🚀"
    startButton.TextSize = 24
    startButton.Font = Enum.Font.GothamBold
    startButton.TextColor3 = COLORS.White
    startButton.Parent = tutorial

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 15)
    buttonCorner.Parent = startButton

    -- Evento do botão
    startButton.MouseButton1Click:Connect(function()
        self:AnimateOut(tutorial)
    end)

    self.Tutorial = tutorial
end

-- Atualiza contador de estrelas
function MainUI:UpdateStars(amount)
    if self.StarCountLabel then
        self.StarCountLabel.Text = tostring(amount)

        -- Animação de bounce
        local original = self.StarCountLabel.TextSize
        self.StarCountLabel.TextSize = original * 1.3

        local tween = TweenService:Create(
            self.StarCountLabel,
            TweenInfo.new(0.3, Enum.EasingStyle.Bounce),
            {TextSize = original}
        )
        tween:Play()
    end
end

-- Atualiza label de stage
function MainUI:UpdateStage(stageNumber)
    if self.StageLabel then
        self.StageLabel.Text = "Fase " .. tostring(stageNumber)

        -- Animação
        local original = self.StageLabel.TextSize
        self.StageLabel.TextSize = original * 1.2

        local tween = TweenService:Create(
            self.StageLabel,
            TweenInfo.new(0.3, Enum.EasingStyle.Back),
            {TextSize = original}
        )
        tween:Play()
    end
end

-- Mostra mensagem de feedback
function MainUI:ShowFeedback(message, color, duration)
    if not self.FeedbackLabel then return end

    self.FeedbackLabel.Text = message
    self.FeedbackLabel.BackgroundColor3 = color or COLORS.Success
    self.FeedbackLabel.Visible = true

    -- Animação de entrada
    self.FeedbackLabel.Position = UDim2.new(0.5, -200, 0.2, 0)
    local tweenIn = TweenService:Create(
        self.FeedbackLabel,
        TweenInfo.new(0.3, Enum.EasingStyle.Back),
        {Position = UDim2.new(0.5, -200, 0.3, 0)}
    )
    tweenIn:Play()

    -- Esconde após duração
    wait(duration or 2)
    self:AnimateOut(self.FeedbackLabel)
end

-- Anima saída de elemento
function MainUI:AnimateOut(element)
    local tweenOut = TweenService:Create(
        element,
        TweenInfo.new(0.3, Enum.EasingStyle.Back),
        {Position = element.Position + UDim2.new(0, 0, -0.2, 0)}
    )

    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        element.Visible = false
    end)
end

return MainUI
