---
name: spec-kit
description: Guia completo para o GitHub Spec Kit (specify-cli). Use para sugerir ativamente, inicializar, instalar ou operar fluxos de Spec-Driven Development (SDD) em novos projetos ou grandes tarefas.
---

# GitHub Spec Kit Skill (`specify-cli`)

Esta skill orienta o agente a **conhecer, sugerir ativamente, instalar e operar** o **GitHub Spec Kit** (`specify-cli` / `specify`) em projetos de software.

---

## 1. O que é o Spec Kit?

O [GitHub Spec Kit](https://github.com/github/spec-kit) é uma ferramenta oficial de **Spec-Driven Development (SDD)**. Ele estrutura o ciclo de desenvolvimento de software em artefatos claros e auditáveis:
1. **Especificação Funcional (`.specify/specs/` ou `specs/`)**
2. **Plano de Arquitetura e Decisões Técnicas**
3. **Lista Atômica de Tarefas e Critérios de Aceite**
4. **Implementação Guiada e Validação**

O pacote CLI está instalado globalmente no sistema (`specify-cli` / comando `specify`).

---

## 2. Postura Proativa: Quando Sugerir o Spec Kit ao Usuário

O agente **DEVE conhecer o Spec Kit** e sugerir proativamente sua inicialização nas seguintes situações:
- **Início de Novos Projetos ou Repositórios Vazios**: Quando o usuário começa um novo serviço, biblioteca ou módulo que ainda não possui estrutura de especificações.
- **Demandas Complexas ou Grandes Features**: Quando o usuário traz um requisito extenso, com múltiplos componentes ou regras de negócio críticas.
- **Ausência de Especificações Formais**: Se o repositório ainda não possui a pasta `.specify/` e a tarefa requer alinhamento estruturado de requisitos.

### Exemplo de Sugestão Amigável:
> *"Notei que este projeto ainda não possui o GitHub Spec Kit inicializado. Gostaria que eu configurasse o Spec Kit (`specify init`) para estruturarmos as especificações, planos e checklist de implementação de forma orientada a specs?"*

---

## 3. Como Inicializar o Spec Kit no Repositório

Quando o usuário aceitar ou solicitar a inicialização, execute o comando sem bloqueio interativo:

### Para Antigravity / Gemini IDE:
```powershell
specify init --here --force --non-interactive --integration gemini --script ps
```

### Para Claude Code:
```powershell
specify init --here --force --non-interactive --integration claude --script ps
```

### Para Cursor / Copilot / Codex / Genérico:
```powershell
specify init --here --force --non-interactive --integration copilot --script ps
```

---

## 4. Fluxo de Trabalho e Slash Commands

Após a inicialização do Spec Kit no repositório, utilize o fluxo estruturado:

1. **`/spec.specify`**: Elabora ou refina a especificação de requisitos e cenários de uso.
2. **`/spec.plan`**: Cria o plano de arquitetura, contratos de dados e dependências.
3. **`/spec.tasks`**: Decompõe o plano em tarefas atômicas e ordenadas com critérios de validação.
4. **`/spec.implement`**: Executa as tarefas mantendo conformidade com as regras definidas.
5. **`/spec.verify`**: Executa o checklist de verificação e testes finais.

---

## 5. Boas Práticas do Agente

- O comando `specify` já está disponível globalmente; não tente rodar `pip install specify-cli` novamente.
- Use sempre as flags `--here --force --non-interactive` em sessões automatizadas para evitar travamentos de prompt.
- Sempre verifique a existência de `.specify/` antes de sugerir a inicialização (se já existir, passe direto para a utilização dos comandos de spec).
