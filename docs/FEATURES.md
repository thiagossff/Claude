# 🎮 Funcionalidades do Adventure Obby

## 🌟 Funcionalidades Principais

### 1. Sistema de Checkpoints
**Arquivo:** `src/server/Services/CheckpointService.lua`

#### Como Funciona:
- Detecta quando o jogador toca em um checkpoint
- Salva a posição do checkpoint para respawn
- Notifica o cliente com animações e sons
- Suporta múltiplas fases progressivas

#### Características:
- ✅ Salvamento automático de progresso
- ✅ Respawn instantâneo no último checkpoint
- ✅ Efeitos visuais ao alcançar checkpoint
- ✅ Notificação clara para o jogador
- ✅ Sistema de fases numeradas

#### Como Usar:
```lua
-- Criar checkpoint manualmente
local checkpoint = Instance.new("Part")
checkpoint.Name = "Checkpoint1"  -- Número indica a ordem
checkpoint.Size = Vector3.new(10, 1, 10)
checkpoint.Parent = workspace.Checkpoints
-- CheckpointService detecta automaticamente!
```

### 2. Sistema de Coleta de Estrelas
**Arquivo:** `src/server/Services/StarCollectionService.lua`

#### Como Funciona:
- Estrelas rotacionam e brilham constantemente
- Quando coletadas, desaparecem com efeitos
- Pontos são adicionados ao jogador
- Estrelas bônus dão mais pontos

#### Características:
- ✅ Rotação automática das estrelas
- ✅ Efeitos de brilho (Sparkles + PointLight)
- ✅ Som de coleta satisfatório
- ✅ Partículas ao coletar
- ✅ Suporte a estrelas bônus
- ✅ Sistema anti-duplicação (não pode coletar 2x)

#### Como Usar:
```lua
-- Criar estrela manualmente
local star = Instance.new("Part")
star.Name = "Star1"
star.Size = Vector3.new(2, 2, 0.5)
star:SetAttribute("StarID", "UniqueID123")
star:SetAttribute("Value", 10)  -- Pontos
star:SetAttribute("BonusStar", false)  -- true para bônus
star.Parent = workspace.Stars
```

#### Criar Estrela por Código:
```lua
local StarCollectionService = require(...)
StarCollectionService:CreateStar(
    Vector3.new(0, 10, 0),  -- Posição
    50,                      -- Valor em pontos
    true                     -- É estrela bônus?
)
```

### 3. Sistema de Power-ups
**Arquivo:** `src/server/Services/PowerUpService.lua`

#### Tipos Disponíveis:

**⚡ Speed Boost**
- Aumenta velocidade em 50%
- Duração: 10 segundos
- Cor: Ciano
- Efeito visual: Rastro de velocidade

**🦘 Jump Boost**
- Aumenta altura do pulo em 50%
- Duração: 10 segundos
- Cor: Magenta
- Permite alcançar plataformas altas

**🛡️ Shield**
- Proteção visual ao redor do jogador
- Duração: 15 segundos
- Cor: Verde
- Efeito: Esfera brilhante

#### Como Funciona:
- Power-ups rotacionam e emitem luz
- Ao serem coletados, aplicam efeito temporário
- Respawnam após 30 segundos
- Notificam o jogador com UI

#### Como Usar:
```lua
-- Criar power-up manualmente
local powerUp = Instance.new("Part")
powerUp.Name = "SpeedBoost"
powerUp.Size = Vector3.new(2, 2, 2)
powerUp:SetAttribute("Type", "Speed")  -- "Speed", "Jump", ou "Shield"
powerUp.Parent = workspace.PowerUps
```

### 4. Interface do Usuário (UI)
**Arquivo:** `src/client/UI/MainUI.lua`

#### Componentes:

**Barra Superior:**
- Contador de estrelas com ícone ⭐
- Indicador de fase atual
- Design colorido e grande (fácil leitura para crianças)

**Tutorial Inicial:**
- Aparece ao entrar no jogo
- Explica mecânicas básicas
- Botão "Começar!" para fechar

**Mensagens de Feedback:**
- Aparecem quando eventos importantes acontecem
- Animações suaves de entrada/saída
- Cores diferentes para tipos de eventos:
  - Verde: Checkpoints
  - Amarelo: Estrelas
  - Rosa: Power-ups

#### Animações:
- Bounce ao coletar estrelas
- Slide in/out para mensagens
- Scale effect nos contadores

### 5. Sistema de Dados do Jogador
**Arquivo:** `src/shared/Modules/PlayerData.lua`

#### Dados Armazenados:
```lua
{
    Stars = 0,                    -- Total de estrelas
    CurrentStage = 1,             -- Fase atual
    LastCheckpoint = nil,         -- CFrame do último checkpoint
    PowerUpsCollected = 0,        -- Total de power-ups
    TotalPlayTime = 0,            -- Tempo total jogado
    Achievements = {},            -- Lista de conquistas
    Settings = {
        MusicEnabled = true,
        SoundEffectsEnabled = true
    }
}
```

#### Métodos Principais:
- `AddStars(amount)` - Adiciona estrelas
- `SetStage(number)` - Atualiza fase
- `SetCheckpoint(cframe)` - Salva checkpoint
- `AddAchievement(id)` - Adiciona conquista

### 6. Configurações do Jogo
**Arquivo:** `src/shared/Config/GameConfig.lua`

#### Valores Ajustáveis:

**Coleta:**
```lua
StarValue = 10              -- Pontos por estrela normal
BonusStarValue = 50         -- Pontos por estrela bônus
```

**Power-ups:**
```lua
SpeedBoostMultiplier = 1.5  -- 50% mais rápido
SpeedBoostDuration = 10     -- 10 segundos
JumpBoostMultiplier = 1.5   -- 50% mais alto
JumpBoostDuration = 10      -- 10 segundos
```

**Jogo:**
```lua
MaxStages = 20              -- Total de fases
StarsPerStage = 3           -- Estrelas por fase
AutoSaveInterval = 60       -- Salvar a cada 60s
```

**Cores:**
```lua
Colors = {
    Primary = Color3.fromRGB(255, 107, 107),
    Secondary = Color3.fromRGB(78, 205, 196),
    Success = Color3.fromRGB(129, 236, 236),
    Warning = Color3.fromRGB(255, 195, 18),
    Star = Color3.fromRGB(255, 234, 0)
}
```

## 🎨 Personalização Fácil

### Alterar Velocidade do Speed Boost
Em `GameConfig.lua`:
```lua
SpeedBoostMultiplier = 2.0  -- Agora 100% mais rápido!
```

### Alterar Duração dos Power-ups
Em `GameConfig.lua`:
```lua
SpeedBoostDuration = 20     -- Agora dura 20 segundos
```

### Alterar Valor das Estrelas
Em `GameConfig.lua`:
```lua
StarValue = 25              -- Cada estrela vale 25 pontos
BonusStarValue = 100        -- Estrelas bônus valem 100
```

### Alterar Cores da Interface
Em `GameConfig.lua`:
```lua
Colors = {
    Primary = Color3.fromRGB(255, 0, 0),     -- Vermelho
    Secondary = Color3.fromRGB(0, 0, 255),   -- Azul
    -- ...
}
```

## 🔊 Sistema de Som

### Sons Incluídos:
- ✅ Coleta de estrela
- ✅ Alcance de checkpoint
- ✅ Ativação de power-up
- ✅ Música de fundo (opcional, comentada)

### Personalizar Sons:
Em qualquer Service, substitua:
```lua
sound.SoundId = "rbxassetid://SEU_ID_AQUI"
```

## 🎯 Recursos Especiais

### Auto-criação de Exemplos
Na primeira execução, o jogo cria automaticamente:
- 5 checkpoints de exemplo
- 10 estrelas de exemplo
- 3 power-ups (um de cada tipo)

### Segurança para Crianças
- Chat filtrado habilitado
- Respawn seguro
- Sem conteúdo inapropriado
- Interface clara e simples

### Performance
- Sistema modular eficiente
- Uso de Debris para limpeza automática
- Tweens suaves para animações
- Otimizado para múltiplos jogadores

## 📈 Expansões Futuras Possíveis

### Fácil de Adicionar:
1. **Novos Power-ups** - Copie estrutura existente
2. **Mais Tipos de Estrelas** - Use Attributes
3. **Sistema de Ranks** - Use PlayerData
4. **Conquistas** - Já preparado em PlayerData
5. **Persistência** - Integre DataStore
6. **Multiplayer** - Já suporta múltiplos jogadores

## 🛠️ Manutenção

### Logs do Console
O jogo gera logs úteis:
```
[CheckpointService] Iniciando...
[StarCollectionService] Estrela coletada!
[PowerUpService] Speed Boost ativado!
```

### Debug
Todos os serviços têm mensagens de debug que podem ser ativadas/desativadas.

---

**Aproveite todas as funcionalidades e crie um jogo incrível! 🎮**
