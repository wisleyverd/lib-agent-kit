# Code Standards & Engineering Guidelines

Este documento estabelece as diretrizes fundamentais de engenharia de software e padrões de código a serem seguidos pelos agentes de IA e desenvolvedores neste ecossistema.

---

## 1. Princípios Gerais de Código (Clean Code)

- **Legibilidade e Clareza**: O código deve ser autoexplicativo. Evite abreviações obscuras ou truques sintáticos desnecessários.
- **Responsabilidade Única (SRP)**: Cada módulo, classe ou função deve ter apenas uma responsabilidade bem definida.
- **DRY (Don't Repeat Yourself)**: Extraia lógicas repetidas em funções auxiliares ou módulos utilitários compartilhados.
- **Fail Fast & Validação Antecipada**: Valide parâmetros de entrada, tipos e estados prévios logo no início das rotinas.

---

## 2. Tipagem e Assinaturas de Código

- **Python**:
  - Uso obrigatório de *Type Hints* em todas as assinaturas de funções e métodos públicos.
  - Utilização de `dataclasses`, `Pydantic` ou `NamedTuple` para estruturas de dados complexas.
  - Docstrings no formato Google Style ou Sphinx documentando parâmetros, retornos e exceções (`Raises`).
- **TypeScript / JavaScript**:
  - Preferência estrita por TypeScript com modo estrito (`strict: true`).
  - Evitar `any` explícito; usar `unknown`, generics ou tipos união quando apropriado.
  - Interfaces ou `type aliases` bem documentados para payloads e contratos de API.
- **PowerShell / Shell Scripts**:
  - Uso de `[CmdletBinding()]` e tipagem de parâmetros com validação (`[ValidateNotNullOrEmpty()]`, `[ValidateSet()]`).
  - Tratamento consistente com `$ErrorActionPreference = 'Stop'` e blocos `try/catch`.

---

## 3. Tratamento de Erros e Resiliência

- **Exceções Específicas**: Capture apenas exceções esperadas; nunca engula erros com blocos vazios de `except:` ou `catch {}`.
- **Mensagens Contextuais**: Ao relançar ou registrar um erro, inclua informações contextuais (ex.: identificador do recurso, caminho do arquivo, payload relevante).
- **Idempotência**: Scripts de automação e transformações de dados devem ser projetados para serem executados repetidamente sem gerar efeitos colaterais duplicados ou inconsistentes.

---

## 4. Testes e Qualidade

- **Testabilidade**: O código deve ser desenhado para facilitar a escrita de testes unitários e de integração (injeção de dependências, desacoplamento de I/O).
- **Linter e Formatadores**: Respeite as configurações do linter do projeto (ex.: `ruff`/`flake8`/`black` para Python, `eslint`/`prettier` para TS/JS, `PSScriptAnalyzer` para PowerShell).
- **Preservação de Integridade**: Nunca remova comentários explicativos ou docstrings úteis a menos que solicitado ou quando o código subjacente for completamente substituído.
