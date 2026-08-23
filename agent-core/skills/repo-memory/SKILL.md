---
name: repo-memory
description: Sistema estruturado de memória de projeto e governança via Architecture Decision Records (ADRs) e Knowledge Items (KIs). Use para consultar histórico de decisões, registrar aprendizados, registrar novas ADRs e evitar repetição de erros passados.
---

# Skill: Repo Memory & Architectural Knowledge (`repo-memory`)

Esta skill orienta o agente a gerenciar a **memória estrutural, persistente e versionada** do projeto através de **ADRs (Architecture Decision Records)** e **Knowledge Items (KIs)** armazenados diretamente no Git.

---

## 1. Princípios da Memória Estrutural

1. **Zero Sobrecarga Externa**: A memória do projeto é mantida em arquivos Markdown puros dentro do próprio repositório (`docs/adr/` e `.knowledge/`).
2. **Imutabilidade e Versionamento**: Toda decisão, restrição técnica e lição aprendida evolui junto com o código-fonte via commits Git.
3. **Leitura Antecipada Obrigatória**: Antes de propor refatorações ou adotar novas bibliotecas, o agente deve consultar as decisões registradas para não violar restrições já deliberadas.

---

## 2. Estrutura Padrão de Memória no Repositório

```text
meu-projeto/
├── docs/
│   └── adr/                       # Decisões arquiteturais formais
│       ├── 0001-escolha-banco-vetorial.md
│       └── 0002-estrategia-de-cache.md
└── .knowledge/                    # Knowledge Items (Gotchas, lições aprendidas, restrições)
    ├── index.md                   # Resumo de todos os KIs
    └── ki-001-limite-rate-api.md
```

---

## 3. Quando o Agente Deve Consultar a Memória

- Ao iniciar tarefas de **arquitetura, refatoração ou escolha de dependências**.
- Ao investigar **bugs recorrentes ou comportamentos não triviais** em módulos centrais.
- Antes de sugerir a substituição de uma tecnologia existente.

---

## 4. Quando o Agente Deve Criar ou Atualizar Registros

- **Novas Decisões Arquiteturais**: Ao definir um padrão arquitetural novo, criar uma nova ADR usando o template em `templates/adr-template.md`.
- **Lições Aprendidas e Gotchas**: Ao resolver um bug complexo ou descobrir uma restrição de biblioteca de terceiros que gerou retrabalho, criar um Knowledge Item (`.knowledge/ki-XXX.md`) usando `templates/knowledge-item-template.md`.
- **Atualização do Índice**: Sempre manter o arquivo `.knowledge/index.md` atualizado com o resumo de cada item.

---

## 5. Templates Disponíveis

- **ADR Template**: Consulte [`templates/adr-template.md`](file:///c:/Projetos/lib-agent-kit/agent-core/skills/repo-memory/templates/adr-template.md)
- **Knowledge Item Template**: Consulte [`templates/knowledge-item-template.md`](file:///c:/Projetos/lib-agent-kit/agent-core/skills/repo-memory/templates/knowledge-item-template.md)
