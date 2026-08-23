# Diretrizes Gerais de Agentes (Agnóstico)

Este documento estabelece regras operacionais agnósticas compatíveis com múltiplos runtimes de agentes (ex.: Cursor, Codex/Copilot, Aider, Devin).

---

## 1. Comportamento do Agente

- **Escopo Delimitado**: Limite as alterações estritamente ao que foi solicitado. Não faça refatorações não autorizadas em código adjacente.
- **Validação Antecipada**: Valide sintaxe, importações e tipos após modificações.
- **Preservação de Padrões**: Respeite os padrões de formatação, nomenclatura e estilos já existentes no projeto.

---

## 2. Gerenciamento de Dependências e Ambiente

- Não instale dependências globais sem necessidade; use ambientes virtuais (`.venv`, `npm`, etc.).
- Verifique se scripts de build e testes estão passando após alterações.
- Respeite arquivos `.gitignore` e não versione artefatos temporários ou segredos.

---

## 3. Formato de Resposta

- Seja conciso e objetivo.
- Liste arquivos modificados e comandos executados para auditoria rápida.

---

## 4. GitHub Spec Kit (`specify-cli`)

- O comando global `specify` está disponível.
- Para inicializar o Spec Kit no repositório atual de acordo com seu agente:
  ```powershell
  specify init --here --force --non-interactive --integration <copilot|claude|gemini|codex> --script ps
  ```

---

## 5. Memória Estrutural e ADRs

- Consulte sempre `docs/adr/` e `.knowledge/` antes de propor grandes alterações.
- Registre novas decisões em `docs/adr/` e lições aprendidas em `.knowledge/` para evitar regressões e repetição de falhas passadas.
