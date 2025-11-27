# 📖 INSTALAÇÃO DETALHADA - Passo a Passo Completo

## 🎯 ÍNDICE
- [Parte 1: Preparação](#parte-1-preparação)
- [Parte 2: Servidor - ServerMain](#parte-2-servidor---servermain)
- [Parte 3: Services (3 arquivos)](#parte-3-services)
- [Parte 4: Shared/Config](#parte-4-sharedconfig)
- [Parte 5: Shared/Modules](#parte-5-sharedmodules)
- [Parte 6: Cliente](#parte-6-cliente)
- [Parte 7: Testar](#parte-7-testar)

---

## PARTE 1: Preparação

### Passo 1: Abrir Roblox Studio
1. Abra o **Roblox Studio**
2. Clique em **"New"**
3. Escolha **"Baseplate"**
4. Aguarde carregar

### Passo 2: Verificar Painel Explorer
- O painel **Explorer** deve estar visível no lado direito
- Se não estiver: Pressione `Ctrl + Shift + X`
- Você verá: Workspace, Players, Lighting, ReplicatedStorage, ServerScriptService, etc.

---

## PARTE 2: Servidor - ServerMain

### O QUE FAZER:
Criar o script principal do servidor que inicializa tudo.

### LOCALIZAÇÃO NO ROBLOX:
📂 **ServerScriptService** → ServerMain (Script)

### PASSOS:

1. **No Explorer**, clique com botão DIREITO em **"ServerScriptService"**

2. **Insert Object** → **Script**

3. **Renomear**:
   - Clique no script "Script"
   - Pressione `F2`
   - Digite: `ServerMain`
   - Enter

4. **Abrir o código**:
   - Clique DUAS VEZES em "ServerMain"

5. **Copiar o arquivo**:
   - Abra: `src/server/ServerMain.lua` no seu computador
   - Selecione tudo (Ctrl+A)
   - Copie (Ctrl+C)

6. **Colar no Roblox**:
   - Selecione todo código padrão (Ctrl+A)
   - Cole (Ctrl+V)
   - Salve (Ctrl+S)

✅ **ServerMain criado!**

---

## PARTE 3: Services

Vamos criar uma pasta "Services" com 3 ModuleScripts dentro.

### Passo 3.1: Criar Pasta Services

1. **No Explorer**, clique DIREITO em **"ReplicatedStorage"**

2. **Insert Object** → **Folder**

3. **Renomear** para `Services` (F2 → digita → Enter)

### Passo 3.2: CheckpointService

**LOCALIZAÇÃO:** 📂 ReplicatedStorage → Services → CheckpointService (ModuleScript)

**PASSOS:**

1. Clique DIREITO na pasta **"Services"**

2. **Insert Object** → **ModuleScript**

3. **Renomear** para `CheckpointService`

4. **Abrir** (duplo clique)

5. **Copiar arquivo**:
   - Abra: `src/server/Services/CheckpointService.lua`
   - Ctrl+A → Ctrl+C

6. **Colar** no ModuleScript:
   - Ctrl+A → Ctrl+V → Ctrl+S

✅ **CheckpointService criado!**

### Passo 3.3: StarCollectionService

**LOCALIZAÇÃO:** 📂 ReplicatedStorage → Services → StarCollectionService (ModuleScript)

**PASSOS:**

1. Clique DIREITO na pasta **"Services"**

2. **Insert Object** → **ModuleScript**

3. **Renomear** para `StarCollectionService`

4. **Abrir** (duplo clique)

5. **Copiar arquivo**:
   - Abra: `src/server/Services/StarCollectionService.lua`
   - Ctrl+A → Ctrl+C

6. **Colar** no ModuleScript:
   - Ctrl+A → Ctrl+V → Ctrl+S

✅ **StarCollectionService criado!**

### Passo 3.4: PowerUpService

**LOCALIZAÇÃO:** 📂 ReplicatedStorage → Services → PowerUpService (ModuleScript)

**PASSOS:**

1. Clique DIREITO na pasta **"Services"**

2. **Insert Object** → **ModuleScript**

3. **Renomear** para `PowerUpService`

4. **Abrir** (duplo clique)

5. **Copiar arquivo**:
   - Abra: `src/server/Services/PowerUpService.lua`
   - Ctrl+A → Ctrl+C

6. **Colar** no ModuleScript:
   - Ctrl+A → Ctrl+V → Ctrl+S

✅ **PowerUpService criado!**

---

## PARTE 4: Shared/Config

### Passo 4.1: Criar Pasta "Shared"

1. Clique DIREITO em **"ReplicatedStorage"**

2. **Insert Object** → **Folder**

3. **Renomear** para `Shared`

### Passo 4.2: Criar Pasta "Config" dentro de Shared

1. Clique DIREITO na pasta **"Shared"**

2. **Insert Object** → **Folder**

3. **Renomear** para `Config`

### Passo 4.3: GameConfig

**LOCALIZAÇÃO:** 📂 ReplicatedStorage → Shared → Config → GameConfig (ModuleScript)

**PASSOS:**

1. Clique DIREITO na pasta **"Config"**

2. **Insert Object** → **ModuleScript**

3. **Renomear** para `GameConfig`

4. **Abrir** (duplo clique)

5. **Copiar arquivo**:
   - Abra: `src/shared/Config/GameConfig.lua`
   - Ctrl+A → Ctrl+C

6. **Colar** no ModuleScript:
   - Ctrl+A → Ctrl+V → Ctrl+S

✅ **GameConfig criado!**

---

## PARTE 5: Shared/Modules

### Passo 5.1: Criar Pasta "Modules" dentro de Shared

1. Clique DIREITO na pasta **"Shared"**

2. **Insert Object** → **Folder**

3. **Renomear** para `Modules`

### Passo 5.2: PlayerData

**LOCALIZAÇÃO:** 📂 ReplicatedStorage → Shared → Modules → PlayerData (ModuleScript)

**PASSOS:**

1. Clique DIREITO na pasta **"Modules"**

2. **Insert Object** → **ModuleScript**

3. **Renomear** para `PlayerData`

4. **Abrir** (duplo clique)

5. **Copiar arquivo**:
   - Abra: `src/shared/Modules/PlayerData.lua`
   - Ctrl+A → Ctrl+C

6. **Colar** no ModuleScript:
   - Ctrl+A → Ctrl+V → Ctrl+S

✅ **PlayerData criado!**

---

## PARTE 6: Cliente

Agora vamos criar os scripts que rodam no cliente (jogador).

### Passo 6.1: Encontrar StarterPlayerScripts

1. **No Explorer**, localize **"StarterPlayer"**

2. **Clique na setinha** ao lado de StarterPlayer para expandir

3. Você verá **"StarterPlayerScripts"** dentro

### Passo 6.2: ClientMain

**LOCALIZAÇÃO:** 📂 StarterPlayer → StarterPlayerScripts → ClientMain (LocalScript)

**PASSOS:**

1. Clique DIREITO em **"StarterPlayerScripts"**

2. **Insert Object** → **LocalScript** (NÃO é Script normal!)

3. **Renomear** para `ClientMain`

4. **Abrir** (duplo clique)

5. **Copiar arquivo**:
   - Abra: `src/client/ClientMain.lua`
   - Ctrl+A → Ctrl+C

6. **Colar** no LocalScript:
   - Ctrl+A → Ctrl+V → Ctrl+S

✅ **ClientMain criado!**

### Passo 6.3: Pasta UI

1. Clique DIREITO em **"StarterPlayerScripts"**

2. **Insert Object** → **Folder**

3. **Renomear** para `UI`

### Passo 6.4: MainUI

**LOCALIZAÇÃO:** 📂 StarterPlayer → StarterPlayerScripts → UI → MainUI (ModuleScript)

**PASSOS:**

1. Clique DIREITO na pasta **"UI"**

2. **Insert Object** → **ModuleScript**

3. **Renomear** para `MainUI`

4. **Abrir** (duplo clique)

5. **Copiar arquivo**:
   - Abra: `src/client/UI/MainUI.lua`
   - Ctrl+A → Ctrl+C

6. **Colar** no ModuleScript:
   - Ctrl+A → Ctrl+V → Ctrl+S

✅ **MainUI criado!**

---

## PARTE 7: Testar!

### Estrutura Final deve estar assim:

```
📂 Workspace

📂 ServerScriptService
└── 📄 ServerMain (Script)

📂 ReplicatedStorage
├── 📁 Services
│   ├── 📄 CheckpointService (ModuleScript)
│   ├── 📄 StarCollectionService (ModuleScript)
│   └── 📄 PowerUpService (ModuleScript)
└── 📁 Shared
    ├── 📁 Config
    │   └── 📄 GameConfig (ModuleScript)
    └── 📁 Modules
        └── 📄 PlayerData (ModuleScript)

📂 StarterPlayer
└── 📂 StarterPlayerScripts
    ├── 📄 ClientMain (LocalScript)
    └── 📁 UI
        └── 📄 MainUI (ModuleScript)
```

### Executar o Jogo:

1. **Clique no botão Play** (▶️) no topo da tela
   - OU pressione **F5**

2. **Aguarde carregar**

3. **O que você deve ver:**
   - ✅ Um tutorial colorido aparece na tela
   - ✅ Interface com contador de estrelas (canto superior esquerdo)
   - ✅ Indicador de "Fase 1"
   - ✅ No Workspace, pastas criadas automaticamente:
     - Checkpoints (com 5 checkpoints verdes)
     - Stars (com 10 estrelas amarelas girando)
     - PowerUps (com 3 power-ups coloridos)

4. **Pressione F9** para ver o Console:
   - Você deve ver mensagens como:
     ```
     🎮 Adventure Obby - Servidor
     [CheckpointService] Iniciando...
     [StarCollectionService] Iniciando...
     [PowerUpService] Iniciando...
     ```

### Testar Funcionalidades:

1. **Caminhe até um checkpoint verde**
   - Você verá: mensagem "🏁 Checkpoint 1!"
   - Som de sucesso

2. **Toque em uma estrela amarela**
   - Ela desaparece
   - Contador aumenta
   - Mensagem "⭐ +10"

3. **Pegue um power-up**
   - Você sente o efeito (mais rápido/pula mais alto)
   - Mensagem do power-up aparece

---

## 🆘 SOLUÇÃO DE PROBLEMAS

### ❌ Erro: "attempt to index nil"

**Causa:** Algum módulo não foi criado ou está no lugar errado

**Solução:**
1. Pressione F9 para ver qual módulo está faltando
2. Verifique se todos os nomes estão corretos (maiúsculas/minúsculas)
3. Confirme a estrutura de pastas

### ❌ UI não aparece

**Solução:**
1. Verifique se ClientMain está em **StarterPlayerScripts**
2. Confirme que é um **LocalScript**, não Script normal
3. Verifique se MainUI está em **StarterPlayerScripts/UI**

### ❌ Checkpoints não funcionam

**Solução:**
1. Verifique se CheckpointService está em **ReplicatedStorage/Services**
2. Confirme que ServerMain está carregando os serviços corretamente

### ❌ Console mostra erros vermelhos

**Solução:**
1. Leia a mensagem de erro
2. Ela dirá qual linha e qual arquivo tem problema
3. Verifique se copiou o código completo
4. Confirme que não faltou nenhum "end" no final

---

## ✅ CHECKLIST FINAL

Antes de testar, verifique:

- [ ] ServerMain em ServerScriptService (Script)
- [ ] CheckpointService em ReplicatedStorage/Services (ModuleScript)
- [ ] StarCollectionService em ReplicatedStorage/Services (ModuleScript)
- [ ] PowerUpService em ReplicatedStorage/Services (ModuleScript)
- [ ] GameConfig em ReplicatedStorage/Shared/Config (ModuleScript)
- [ ] PlayerData em ReplicatedStorage/Shared/Modules (ModuleScript)
- [ ] ClientMain em StarterPlayerScripts (LocalScript)
- [ ] MainUI em StarterPlayerScripts/UI (ModuleScript)

**Todos os nomes estão EXATAMENTE como mostrado acima?** (case-sensitive!)

---

## 🎯 PRÓXIMOS PASSOS

Depois que o jogo funcionar:

1. **Construa seu Obby:**
   - Crie Parts no Workspace
   - Faça plataformas e obstáculos
   - Seja criativo!

2. **Adicione Checkpoints Personalizados:**
   - Crie uma Part
   - Mova para a pasta Workspace/Checkpoints
   - Nomeie: Checkpoint6, Checkpoint7, etc.

3. **Espalhe Estrelas:**
   - Crie Parts no Workspace/Stars
   - Configure Attributes (clique direito → Add Attribute):
     - StarID (String): "StarX"
     - Value (Number): 10

4. **Personalize:**
   - Abra GameConfig
   - Mude cores, valores, durações

---

## 🎉 PARABÉNS!

Se você chegou até aqui e o jogo funcionou, você instalou com sucesso o Adventure Obby!

**Agora é hora de criar e se divertir! 🎮**
