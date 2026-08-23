# lib-agent-kit

Repositório central, versionado e agnóstico para **Governança, Convenções de Engenharia, Regras Globais e Skills de Agentes de IA**.

---

## 🎯 Objetivos

1. **Governança e Convenções Centralizadas**: Definir padrões de engenharia de software, Clean Code, arquitetura e postura analítica compartilhados por todos os agentes.
2. **Multi-Agente & Agnóstico**: Compatível com múltiplos runtimes de IA (Antigravity/Gemini IDE, Claude Code, Cursor, Copilot/Codex, Aider).
3. **Distribuição Idempotente**: Mecanismos baseados em PowerShell para sincronizar configurações do repositório para os diretórios globais do usuário via Symbolic Links e Junctions.

---

## 📁 Estrutura do Repositório

```text
lib-agent-kit/
├── agent-core/
│   ├── conventions/       # Padrões de código, princípios arquiteturais e postura analítica
│   │   ├── code-standards.md
│   │   ├── architecture-principles.md
│   │   └── analytical-posture.md
│   ├── rules/             # Regras globais exportáveis (GEMINI.md, AGENTS.md, CLAUDE.md)
│   │   ├── GEMINI.md
│   │   ├── AGENTS.md
│   │   └── CLAUDE.md
│   ├── skills/            # Registro e repositório de skills customizadas
│   │   └── README.md
│   ├── scripts/           # Automação de sincronização via Symlinks/Junctions (PowerShell)
│   │   ├── sync-symlinks.ps1
│   │   └── verify-links.ps1
│   └── README.md
├── .gitignore
└── README.md              # Documentação principal
```

---

## 🚀 Como Utilizar

### Sincronização de Configurações (Windows)

Abra o terminal do PowerShell no diretório do repositório:

1. **Simulação (Dry Run)**:
   ```powershell
   .\agent-core\scripts\sync-symlinks.ps1 -DryRun
   ```

2. **Sincronização Completa**:
   ```powershell
   .\agent-core\scripts\sync-symlinks.ps1 -Target All
   ```

3. **Verificação de Links Criados**:
   ```powershell
   .\agent-core\scripts\verify-links.ps1
   ```

---

## 🛡️ Governança e Boas Práticas

- **Inspeção Prévia**: Analise o estado do projeto antes de propor mutações de código.
- **Idempotência**: Garanta que scripts e ferramentas possam ser reexecutados sem causar efeitos colaterais.
- **Prevenção de Perda de Dados**: Ações destrutivas de banco de dados, infraestrutura em nuvem e exclusões em lote exigem verificação e confirmação explícitas.
