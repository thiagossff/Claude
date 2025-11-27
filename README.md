# 🎮 Adventure Obby - Jogo Roblox para Crianças

Um jogo de obstáculos (Obby) colorido e divertido, projetado especificamente para o público infantil na plataforma Roblox!

## 🌟 Características

### Para Crianças
- ⭐ **Sistema de Coleta de Estrelas** - Colete estrelas brilhantes pelo caminho
- 🏁 **Checkpoints Automáticos** - Nunca perca seu progresso
- ⚡ **Power-ups Divertidos** - Velocidade, pulo alto e escudo protetor
- 🎨 **Interface Colorida** - UI vibrante e fácil de entender
- 🎵 **Sons Alegres** - Efeitos sonoros agradáveis para cada ação
- 🛡️ **Ambiente Seguro** - Configurado para ser apropriado para crianças

### Recursos Técnicos
- Sistema modular e escalável
- Arquitetura cliente-servidor organizada
- Fácil de expandir e personalizar
- Código bem documentado
- Otimizado para performance

## 📁 Estrutura do Projeto

```
Claude/
├── src/
│   ├── server/              # Scripts do servidor
│   │   ├── ServerMain.lua   # Inicialização do servidor
│   │   ├── Services/        # Serviços do jogo
│   │   │   ├── CheckpointService.lua
│   │   │   ├── StarCollectionService.lua
│   │   │   └── PowerUpService.lua
│   │   └── Modules/
│   ├── client/              # Scripts do cliente
│   │   ├── ClientMain.lua   # Inicialização do cliente
│   │   ├── Controllers/
│   │   └── UI/
│   │       └── MainUI.lua   # Interface principal
│   └── shared/              # Código compartilhado
│       ├── Config/
│       │   └── GameConfig.lua
│       └── Modules/
│           └── PlayerData.lua
├── README.md
└── docs/                    # Documentação adicional
```

## 🚀 Como Instalar no Roblox Studio

### Passo 1: Preparar o Roblox Studio

1. Abra o **Roblox Studio**
2. Crie um novo lugar (Place) ou abra um existente
3. Certifique-se de que está em modo de edição

### Passo 2: Configurar a Estrutura

1. No **Explorer**, crie as seguintes estruturas:

#### ServerScriptService
```
ServerScriptService/
└── ServerMain (Script)
```

#### ReplicatedStorage
```
ReplicatedStorage/
├── Shared/
│   ├── Config/
│   │   └── GameConfig (ModuleScript)
│   └── Modules/
│       └── PlayerData (ModuleScript)
└── Services/
    ├── CheckpointService (ModuleScript)
    ├── StarCollectionService (ModuleScript)
    └── PowerUpService (ModuleScript)
```

#### StarterPlayer > StarterPlayerScripts
```
StarterPlayerScripts/
├── ClientMain (LocalScript)
└── UI/
    └── MainUI (ModuleScript)
```

### Passo 3: Copiar o Código

1. Abra cada arquivo `.lua` deste repositório
2. Crie o script/módulo correspondente no Roblox Studio
3. Copie e cole o código

### Passo 4: Configurar o Workspace

O jogo criará automaticamente estas pastas no Workspace quando executado:
- `Checkpoints` - Para os pontos de verificação
- `Stars` - Para as estrelas coletáveis
- `PowerUps` - Para os power-ups
- `Obstacles` - Para os obstáculos do obby

**Nota:** O servidor criará exemplos automaticamente na primeira execução.

### Passo 5: Testar o Jogo

1. Clique em **Play** (ou F5) no Roblox Studio
2. Você verá o tutorial inicial
3. Teste coletando estrelas, alcançando checkpoints e pegando power-ups

## 🎨 Personalização

### Cores do Tema
Edite as cores em `src/shared/Config/GameConfig.lua`:

```lua
Colors = {
    Primary = Color3.fromRGB(255, 107, 107),    -- Rosa/Vermelho
    Secondary = Color3.fromRGB(78, 205, 196),   -- Azul claro
    Success = Color3.fromRGB(129, 236, 236),    -- Ciano
    Warning = Color3.fromRGB(255, 195, 18),     -- Amarelo
    Star = Color3.fromRGB(255, 234, 0),         -- Amarelo estrela
}
```

### Valores de Jogo
Ajuste em `src/shared/Config/GameConfig.lua`:

```lua
StarValue = 10,                -- Pontos por estrela
SpeedBoostMultiplier = 1.5,    -- Multiplicador de velocidade
MaxStages = 20,                -- Número de fases
```

### Criar Checkpoints Manualmente

1. Crie uma `Part` no Workspace
2. Coloque na pasta `Checkpoints`
3. Nomeie como `Checkpoint1`, `Checkpoint2`, etc.
4. Configure:
   - Anchored: ✓
   - CanCollide: ✗
   - Material: Neon
   - BrickColor: Bright green

### Criar Estrelas Manualmente

1. Crie uma `Part` no Workspace
2. Coloque na pasta `Stars`
3. Adicione Attributes:
   - `StarID` (String): identificador único
   - `Value` (Number): pontos que vale (ex: 10)
   - `BonusStar` (Boolean): se é estrela bônus

### Criar Power-ups Manualmente

1. Crie uma `Part` no Workspace
2. Coloque na pasta `PowerUps`
3. Adicione Attribute:
   - `Type` (String): "Speed", "Jump" ou "Shield"

## 🎯 Próximos Passos e Expansões

### Ideias para Desenvolvimento Futuro

1. **Sistema de Obstáculos**
   - Plataformas móveis
   - Lasers para desviar
   - Plataformas que desaparecem
   - Trampolins

2. **Sistema de Níveis**
   - Múltiplos mundos temáticos
   - Níveis progressivamente mais difíceis
   - Chefes (boss) no final de cada mundo

3. **Social**
   - Ranking de jogadores
   - Corridas contra o tempo
   - Modo multiplayer cooperativo

4. **Progressão**
   - Sistema de conquistas
   - Skins para personagens
   - Pets que seguem o jogador
   - Loja de itens cosméticos

5. **Persistência de Dados**
   - Integração com DataStore do Roblox
   - Salvar progresso entre sessões
   - Estatísticas de jogo

6. **Mecânicas Adicionais**
   - Veículos (carrinhos, jetpacks)
   - Áreas secretas
   - Mini-games entre fases
   - Sistema de tutorial interativo

## 🔧 Configurações de Segurança

O jogo já vem configurado com:
- ✓ Chat filtrado habilitado
- ✓ Respawn seguro
- ✓ Auto-save de progresso
- ✓ Ambiente apropriado para crianças

## 📚 Documentação Adicional

- `docs/ARCHITECTURE.md` - Arquitetura do sistema
- `docs/API.md` - Referência de API dos módulos
- `docs/TUTORIAL.md` - Tutorial completo de desenvolvimento

## 🎮 Tendências do Roblox para Público Infantil

Este jogo incorpora elementos das tendências mais populares:

1. **Obby (Obstacle Course)** - Gênero mais popular entre crianças
2. **Sistemas de Coleta** - Engajamento através de colecionáveis
3. **Visual Colorido** - Cores vibrantes e elementos brilhantes
4. **Progressão Clara** - Checkpoints e fases numeradas
5. **Recompensas Frequentes** - Feedback positivo constante
6. **Power-ups** - Mecânicas que fazem a criança se sentir poderosa

## 🤝 Contribuindo

Sinta-se livre para expandir este projeto! Algumas áreas que podem ser melhoradas:

- Adicionar mais tipos de power-ups
- Criar obstáculos únicos e criativos
- Implementar sistema de persistência
- Adicionar mais efeitos visuais
- Criar mundos temáticos (espaço, fundo do mar, floresta, etc.)

## 📝 Licença

Este projeto é fornecido como está para fins educacionais e de desenvolvimento.

## 🎉 Divirta-se!

Esperamos que este projeto seja um ótimo ponto de partida para criar um jogo incrível para crianças no Roblox!

---

**Desenvolvido com ❤️ para a comunidade Roblox**
