# 🚀 Início Rápido - Adventure Obby

## Copie e Cole os Arquivos no Roblox Studio

### 📍 PASSO 1: ServerScriptService

1. No Explorer, clique em **ServerScriptService**
2. Clique direito → **Insert Object** → **Script**
3. Renomeie para **ServerMain**
4. Abra o arquivo: `src/server/ServerMain.lua`
5. **Copie TODO o conteúdo** e cole no script ServerMain

---

### 📍 PASSO 2: ReplicatedStorage - Services

1. No Explorer, clique em **ReplicatedStorage**
2. Clique direito → **Insert Object** → **Folder**
3. Renomeie para **Services**
4. Dentro de Services, crie 3 ModuleScripts:

#### CheckpointService
- Clique direito em Services → **Insert Object** → **ModuleScript**
- Renomeie para **CheckpointService**
- Abra: `src/server/Services/CheckpointService.lua`
- Copie e cole o conteúdo

#### StarCollectionService
- Clique direito em Services → **Insert Object** → **ModuleScript**
- Renomeie para **StarCollectionService**
- Abra: `src/server/Services/StarCollectionService.lua`
- Copie e cole o conteúdo

#### PowerUpService
- Clique direito em Services → **Insert Object** → **ModuleScript**
- Renomeie para **PowerUpService**
- Abra: `src/server/Services/PowerUpService.lua`
- Copie e cole o conteúdo

---

### 📍 PASSO 3: ReplicatedStorage - Shared

1. Em **ReplicatedStorage**, crie **Folder** → **Shared**
2. Dentro de Shared, crie **Folder** → **Config**
3. Dentro de Config:
   - **Insert Object** → **ModuleScript** → **GameConfig**
   - Abra: `src/shared/Config/GameConfig.lua`
   - Copie e cole

4. Dentro de Shared, crie **Folder** → **Modules**
5. Dentro de Modules:
   - **Insert Object** → **ModuleScript** → **PlayerData**
   - Abra: `src/shared/Modules/PlayerData.lua`
   - Copie e cole

---

### 📍 PASSO 4: StarterPlayer

1. No Explorer, expanda **StarterPlayer**
2. Entre em **StarterPlayerScripts**
3. Clique direito → **Insert Object** → **LocalScript**
4. Renomeie para **ClientMain**
5. Abra: `src/client/ClientMain.lua`
6. Copie e cole

7. Ainda em StarterPlayerScripts:
   - Clique direito → **Insert Object** → **Folder** → **UI**
   - Dentro de UI → **Insert Object** → **ModuleScript** → **MainUI**
   - Abra: `src/client/UI/MainUI.lua`
   - Copie e cole

---

### 📍 PASSO 5: Testar!

1. Clique no botão **Play** (▶️) ou pressione **F5**
2. Você verá:
   - ✅ Tutorial colorido aparecer
   - ✅ Interface com contador de estrelas
   - ✅ Checkpoints verdes criados automaticamente
   - ✅ Estrelas amarelas girando
   - ✅ Power-ups coloridos

---

## 🎮 Estrutura Final no Explorer

```
Workspace (será preenchido automaticamente ao rodar)

ServerScriptService
└── ServerMain

ReplicatedStorage
├── Services
│   ├── CheckpointService
│   ├── StarCollectionService
│   └── PowerUpService
└── Shared
    ├── Config
    │   └── GameConfig
    └── Modules
        └── PlayerData

StarterPlayer
└── StarterPlayerScripts
    ├── ClientMain
    └── UI
        └── MainUI
```

---

## ⚡ Atalhos Úteis

- **F5** - Play/Test
- **F9** - Console (para ver logs)
- **Ctrl+Shift+X** - Explorer
- **Ctrl+Shift+P** - Properties

---

## 🎯 Próximos Passos

Depois de rodar o jogo:

1. **Construa seu obby** - Crie plataformas e obstáculos
2. **Adicione checkpoints** - Na pasta Workspace/Checkpoints
3. **Espalhe estrelas** - Na pasta Workspace/Stars
4. **Coloque power-ups** - Na pasta Workspace/PowerUps

**Dica:** Consulte `docs/FEATURES.md` para ver como personalizar!

---

## 🆘 Problemas?

Se encontrar erros:
1. Pressione **F9** para ver o Console
2. Verifique se todos os scripts estão nos lugares corretos
3. Confirme que os nomes estão exatos (sensível a maiúsculas)
4. Veja `docs/INSTALLATION_GUIDE.md` para troubleshooting

---

**Divirta-se criando! 🎉**
