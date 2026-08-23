# Princípios de Arquitetura de Agentes

Este documento define os pilares arquiteturais para o desenvolvimento, governança e orquestração de agentes de IA inteligentes e seguros.

---

## 1. Modularidade e Desacoplamento

- **Separação de Preocupações**:
  - **Core de Governança (`agent-core`)**: Regras invariantes, postura analítica e convenções da organização.
  - **Skills / Ferramentas**: Blocos reutilizáveis de capacidades operacionais com interfaces claras (`SKILL.md`, scripts auxiliares).
  - **Contexto de Projeto**: Regras locais do projeto que sobrepõem ou estendem a governança global sem alterar a base.
- **Agnosticismo de Runtime**: As convenções e regras de agentes devem ser compatíveis ou facilmente traduzíveis para múltiplos ambientes (Antigravity IDE, Claude Code CLI, Cursor, Copilot/Codex, Aider).

---

## 2. Idempotência e Determinismo

- **Operações Repetíveis**: Qualquer script ou automação gerada pelo agente deve ser idempotente (verificar antes de criar/modificar).
- **Sem Efeitos Colaterais Ocultos**: O agente nunca deve realizar mutações de arquivos ou chamadas de API externas destrutivas sem visibilidade e controle explícito.

---

## 3. Segurança e Prevenção de Perda de Dados

- **Princípio do Menor Privilégio**: As permissões de execução e escopos de credenciais devem ser mínimos necessários.
- **Stop & Verify para Operações Críticas**:
  - Exclusão ou substituição em massa de arquivos.
  - Comandos destrutivos de banco de dados (`DROP`, `TRUNCATE`, `DELETE` sem `WHERE`).
  - Deleção ou recriação de recursos de infraestrutura em nuvem (GCP, AWS, Azure).
- **Isolamento de Segredos**: Nunca expor tokens, chaves de API ou credenciais em commits, logs ou arquivos de regras.

---

## 4. Rastreabilidade e Auditoria

- **Transparência de Decisões**: As alterações devem ser justificadas tecnicamente e acompanhadas de documentação ou planos de implementação.
- **Versionamento Estruturado**: Regras, templates de prompts e skills devem seguir versionamento semântico (Git) e changelogs claros.
