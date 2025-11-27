# 📖 Guia de Instalação Detalhado - Adventure Obby

Este guia irá ajudá-lo a configurar o Adventure Obby no Roblox Studio passo a passo.

## 🎯 Pré-requisitos

- Roblox Studio instalado
- Conta Roblox
- Conhecimento básico de navegação no Roblox Studio

## 📋 Passo a Passo Completo

### 1️⃣ Criar Novo Lugar

1. Abra o **Roblox Studio**
2. Clique em **"New"** (Novo)
3. Selecione **"Baseplate"** ou **"Flat Terrain"**
4. Aguarde o projeto carregar

### 2️⃣ Configurar Explorer

No painel **Explorer** (geralmente à direita), você organizará os scripts:

#### A) ServerScriptService

1. Localize **ServerScriptService** no Explorer
2. Clique com botão direito → **Insert Object** → **Script**
3. Renomeie para **ServerMain**
4. Abra o arquivo `src/server/ServerMain.lua` deste repositório
5. Copie todo o conteúdo
6. Cole no script ServerMain do Roblox Studio

#### B) ReplicatedStorage - Configuração

1. Localize **ReplicatedStorage** no Explorer
2. Crie a estrutura de pastas:
   - Clique direito em ReplicatedStorage → **Insert Object** → **Folder**
   - Nomeie como **"Shared"**
   - Dentro de Shared, crie outra **Folder** chamada **"Config"**
   - Dentro de Config, **Insert Object** → **ModuleScript**
   - Renomeie para **GameConfig**
   - Cole o conteúdo de `src/shared/Config/GameConfig.lua`

#### C) ReplicatedStorage - Módulos Compartilhados

1. Em **Shared**, crie **Folder** chamada **"Modules"**
2. Dentro de Modules:
   - **Insert Object** → **ModuleScript** → renomeie para **PlayerData**
   - Cole o conteúdo de `src/shared/Modules/PlayerData.lua`

#### D) ReplicatedStorage - Services

1. Em **ReplicatedStorage** (raiz), crie **Folder** chamada **"Services"**
2. Dentro de Services, crie 3 ModuleScripts:

   **CheckpointService:**
   - **Insert Object** → **ModuleScript**
   - Renomeie para **CheckpointService**
   - Cole conteúdo de `src/server/Services/CheckpointService.lua`

   **StarCollectionService:**
   - **Insert Object** → **ModuleScript**
   - Renomeie para **StarCollectionService**
   - Cole conteúdo de `src/server/Services/StarCollectionService.lua`

   **PowerUpService:**
   - **Insert Object** → **ModuleScript**
   - Renomeie para **PowerUpService**
   - Cole conteúdo de `src/server/Services/PowerUpService.lua`

#### E) StarterPlayer - Cliente

1. Localize **StarterPlayer** no Explorer
2. Expanda e encontre **StarterPlayerScripts**
3. Dentro de StarterPlayerScripts:
   - **Insert Object** → **LocalScript**
   - Renomeie para **ClientMain**
   - Cole conteúdo de `src/client/ClientMain.lua`

4. Ainda em StarterPlayerScripts:
   - **Insert Object** → **Folder** → nomeie como **UI**
   - Dentro de UI: **Insert Object** → **ModuleScript**
   - Renomeie para **MainUI**
   - Cole conteúdo de `src/client/UI/MainUI.lua`

### 3️⃣ Ajustar Referências dos Scripts

Como alguns módulos estão em ReplicatedStorage/Services, precisamos ajustar as referências:

#### No ServerMain.lua:

Localize a função `loadServices()` e ajuste para:

```lua
local function loadServices()
    local services = {}

    local servicesFolder = ReplicatedStorage:FindFirstChild("Services")
    if not servicesFolder then
        warn("[ServerMain] Pasta Services não encontrada!")
        return services
    end

    -- Carrega CheckpointService
    local checkpointModule = servicesFolder:FindFirstChild("CheckpointService")
    if checkpointModule then
        services.CheckpointService = require(checkpointModule)
    end

    -- Carrega StarCollectionService
    local starModule = servicesFolder:FindFirstChild("StarCollectionService")
    if starModule then
        services.StarCollectionService = require(starModule)
    end

    -- Carrega PowerUpService
    local powerUpModule = servicesFolder:FindFirstChild("PowerUpService")
    if powerUpModule then
        services.PowerUpService = require(powerUpModule)
    end

    return services
end
```

### 4️⃣ Criar Mundo Básico (Opcional)

Vamos criar um percurso simples para testar:

#### Plataforma Inicial
1. Em **Workspace**, **Insert Object** → **Part**
2. Configurações:
   - Size: `50, 1, 50`
   - Position: `0, 0, 0`
   - Anchored: ✓
   - BrickColor: **Bright blue**

#### Caminho do Obby
1. Crie várias Parts formando um caminho
2. Configurações para cada Part:
   - Size: `10, 1, 10` (ou variado)
   - Anchored: ✓
   - Material: **Plastic** ou **SmoothPlastic**
   - Espaçamento: deixe gaps para criar desafio

### 5️⃣ Primeira Execução

1. Clique no botão **Play** (▶️) ou pressione **F5**
2. Você deve ver:
   - Console mostrando mensagens de inicialização
   - Tutorial aparecendo na tela
   - Pastas criadas automaticamente no Workspace
   - Checkpoints, estrelas e power-ups de exemplo

### 6️⃣ Verificação de Funcionamento

✅ **Checklist:**
- [ ] Tutorial aparece ao iniciar
- [ ] Interface com contador de estrelas visível
- [ ] Pastas criadas no Workspace (Checkpoints, Stars, PowerUps)
- [ ] Checkpoints de exemplo criados (verde brilhante)
- [ ] Estrelas de exemplo criadas (amarelo girando)
- [ ] Power-ups de exemplo criados (coloridos)
- [ ] Console sem erros vermelhos

### 7️⃣ Testando Funcionalidades

#### Teste de Checkpoint:
1. Caminhe até um checkpoint verde
2. Você deve ver:
   - Mensagem "🏁 Checkpoint X!"
   - Número da fase atualizado
   - Som de sucesso

#### Teste de Estrela:
1. Toque em uma estrela amarela
2. Você deve ver:
   - Estrela desaparecer
   - Contador aumentar
   - Mensagem "⭐ +10"
   - Som de coleta

#### Teste de Power-up:
1. Toque em um power-up colorido
2. Você deve:
   - Sentir o efeito (velocidade/pulo)
   - Ver mensagem do power-up
   - Ouvir som especial

## 🔧 Resolução de Problemas

### ❌ "Attempt to index nil value"

**Solução:** Verifique se todos os módulos foram criados nos lugares corretos.

### ❌ "Services não inicializando"

**Solução:**
1. Verifique se a pasta "Services" está em ReplicatedStorage
2. Confirme que todos os ModuleScripts têm `return NomeDoServico` no final

### ❌ "UI não aparece"

**Solução:**
1. Verifique se ClientMain está em StarterPlayerScripts
2. Confirme que MainUI está em StarterPlayerScripts/UI
3. Verifique o console (F9) para erros

### ❌ "Checkpoints não funcionam"

**Solução:**
1. Certifique-se de que os checkpoints estão na pasta "Checkpoints" no Workspace
2. Verifique se os checkpoints têm CanCollide = false
3. Nomes devem seguir padrão: Checkpoint1, Checkpoint2, etc.

## 📊 Estrutura Final no Explorer

```
Workspace
├── Checkpoints (Folder)
├── Stars (Folder)
├── PowerUps (Folder)
└── Obstacles (Folder)

ServerScriptService
└── ServerMain (Script)

ReplicatedStorage
├── Services (Folder)
│   ├── CheckpointService (ModuleScript)
│   ├── StarCollectionService (ModuleScript)
│   └── PowerUpService (ModuleScript)
└── Shared (Folder)
    ├── Config (Folder)
    │   └── GameConfig (ModuleScript)
    └── Modules (Folder)
        └── PlayerData (ModuleScript)

StarterPlayer
└── StarterPlayerScripts
    ├── ClientMain (LocalScript)
    └── UI (Folder)
        └── MainUI (ModuleScript)
```

## ✅ Próximos Passos

Após a instalação bem-sucedida:

1. **Personalize as cores** em GameConfig.lua
2. **Construa seu próprio obby** no Workspace
3. **Adicione checkpoints** manualmente onde desejar
4. **Coloque estrelas** em locais estratégicos
5. **Distribua power-ups** pelo mapa
6. **Teste e ajuste** dificuldade e valores

## 🎉 Sucesso!

Se tudo funcionou, você está pronto para começar a desenvolver seu Adventure Obby!

**Dica:** Salve seu lugar regularmente (File → Save to Roblox)

---

**Precisa de ajuda?** Consulte a documentação adicional em `/docs/`
