# Submódulo `agent-core`

O `agent-core` é o núcleo agnóstico de governança e engenharia para agentes de IA do repositório `lib-agent-kit`.

---

## Estrutura de Diretórios

- **[`conventions/`](file:///c:/Projetos/lib-agent-kit/agent-core/conventions)**:
  - [`code-standards.md`](file:///c:/Projetos/lib-agent-kit/agent-core/conventions/code-standards.md): Diretrizes de Clean Code, tipagem, formatação e tratamento de erros.
  - [`architecture-principles.md`](file:///c:/Projetos/lib-agent-kit/agent-core/conventions/architecture-principles.md): Princípios de desacoplamento, idempotência e governança.
  - [`analytical-posture.md`](file:///c:/Projetos/lib-agent-kit/agent-core/conventions/analytical-posture.md): Postura de diagnóstico, raciocínio de causa-raiz e comunicação.
- **[`rules/`](file:///c:/Projetos/lib-agent-kit/agent-core/rules)**:
  - [`GEMINI.md`](file:///c:/Projetos/lib-agent-kit/agent-core/rules/GEMINI.md): Regras operacionais para o ambiente Antigravity/Gemini IDE.
  - [`AGENTS.md`](file:///c:/Projetos/lib-agent-kit/agent-core/rules/AGENTS.md): Regras agnósticas para ferramentas de agentes.
  - [`CLAUDE.md`](file:///c:/Projetos/lib-agent-kit/agent-core/rules/CLAUDE.md): Regras e comandos para Claude Code CLI.
- **[`plugins/`](file:///c:/Projetos/lib-agent-kit/agent-core/plugins)**:
  - [`spec-kit/`](file:///c:/Projetos/lib-agent-kit/agent-core/plugins/spec-kit): Pacote de plugin global para o GitHub Spec Kit (`plugin.json`).
- **[`skills/`](file:///c:/Projetos/lib-agent-kit/agent-core/skills)**:
  - [`repo-memory/`](file:///c:/Projetos/lib-agent-kit/agent-core/skills/repo-memory): Gestão de memória persistente, templates de ADRs e KIs.
  - [`spec-kit/`](file:///c:/Projetos/lib-agent-kit/agent-core/skills/spec-kit): Skill e orientações do GitHub Spec Kit.
- **[`scripts/`](file:///c:/Projetos/lib-agent-kit/agent-core/scripts)**:
  - [`sync-symlinks.ps1`](file:///c:/Projetos/lib-agent-kit/agent-core/scripts/sync-symlinks.ps1): Script de sincronização via symlinks/junções no Windows.
  - [`verify-links.ps1`](file:///c:/Projetos/lib-agent-kit/agent-core/scripts/verify-links.ps1): Script de verificação de integridade dos links.

