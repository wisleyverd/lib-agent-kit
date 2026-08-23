# Registro e Catálogo de Skills

Este diretório armazena e organiza as **Skills** (habilidades e ferramentas executáveis) reutilizáveis do ecossistema de agentes.

---

## 1. O que é uma Skill?

Uma **Skill** é um pacote autocontido de instruções, diretrizes de domínio, templates de prompts, e opcionalmente scripts executáveis ou configurações de MCP (Model Context Protocol).

---

## 2. Estrutura Padrão de uma Skill

Cada subdiretório dentro de `agent-core/skills/` representa uma skill:

```text
skills/
└── <nome-da-skill>/
    ├── SKILL.md            # [Obrigatório] Arquivo de instruções com cabeçalho YAML
    ├── scripts/            # [Opcional] Scripts utilitários (Python, PowerShell, Bash)
    ├── templates/          # [Opcional] Modelos de arquivos, prompts ou configurações
    └── references/         # [Opcional] Documentação de apoio ou esquemas
```

### Exemplo de `SKILL.md`:

```markdown
---
name: minha-skill-exemplo
description: Descrição clara do que a skill faz e quando o agente deve ativá-la.
---

# Minha Skill Exemplo

Instruções detalhadas para o agente executar esta tarefa...
```

---

## 3. Distribuição e Sincronização

As skills contidas aqui podem ser vinculadas para diretórios globais como `%USERPROFILE%\.gemini\config\skills` através do script `agent-core/scripts/sync-symlinks.ps1`.
