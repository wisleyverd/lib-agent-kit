<#
.SYNOPSIS
    Sincroniza e cria links simbólicos/junções do lib-agent-kit para os diretórios globais de runtime.

.DESCRIPTION
    Script idempotente em PowerShell para mapear regras, convenções e skills deste repositório
    para diretórios de configuração de agentes no Windows (%USERPROFILE%\.gemini, %USERPROFILE%\.claude, etc.).

.PARAMETER Target
    Define qual runtime de agente sincronizar. Opções: 'All', 'Gemini', 'Claude', 'Cursor'. Padrão: 'All'.

.PARAMETER DryRun
    Apenas simula e exibe as ações que seriam executadas sem alterar o sistema de arquivos.

.PARAMETER Force
    Sobrescreve links simbólicos ou arquivos existentes no destino.

.EXAMPLE
    .\sync-symlinks.ps1 -DryRun
    .\sync-symlinks.ps1 -Target Gemini -Force
#>

[CmdletBinding()]
param (
    [ValidateSet('All', 'Gemini', 'Claude', 'Cursor')]
    [string]$Target = 'All',

    [switch]$DryRun,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

# Caminhos base
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$AgentCorePath = Join-Path $RepoRoot "agent-core"
$UserProfile = [Environment]::GetFolderPath("UserProfile")

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  lib-agent-kit | Sincronizador de Symlinks (Windows)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Repo Root   : $RepoRoot"
Write-Host "Agent Core  : $AgentCorePath"
Write-Host "Target      : $Target"
Write-Host "DryRun      : $DryRun"
Write-Host "Force       : $Force"
Write-Host "----------------------------------------------------------"

function Ensure-Symlink {
    param (
        [string]$SourcePath,
        [string]$TargetPath,
        [ValidateSet('File', 'Directory')]
        [string]$ItemType
    )

    if (-not (Test-Path -Path $SourcePath)) {
        Write-Warning "Origem não encontrada: $SourcePath"
        return
    }

    $TargetParent = Split-Path -Parent $TargetPath
    if (-not (Test-Path -Path $TargetParent)) {
        if ($DryRun) {
            Write-Host "[DryRun] Criaria diretório pai: $TargetParent" -ForegroundColor Yellow
        } else {
            New-Item -ItemType Directory -Path $TargetParent -Force | Out-Null
            Write-Host "[OK] Diretório pai criado: $TargetParent" -ForegroundColor Green
        }
    }

    $exists = Test-Path -Path $TargetPath
    if ($exists) {
        $item = Get-Item -Path $TargetPath -Force
        $isLink = [bool]($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint)

        if ($isLink) {
            Write-Host "[SKIP] Link já existe: $TargetPath" -ForegroundColor Gray
            return
        }

        if (-not $Force) {
            Write-Warning "Destino já existe e não é um link (use -Force para substituir): $TargetPath"
            return
        }

        if ($DryRun) {
            Write-Host "[DryRun] Removeria item existente: $TargetPath" -ForegroundColor Yellow
        } else {
            Remove-Item -Path $TargetPath -Recurse -Force
            Write-Host "[FORCE] Item existente removido: $TargetPath" -ForegroundColor Yellow
        }
    }

    if ($DryRun) {
        Write-Host "[DryRun] Criaria link ($ItemType): $TargetPath -> $SourcePath" -ForegroundColor Cyan
    } else {
        try {
            # Tenta criar SymbolicLink (padrão)
            New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath -Force | Out-Null
            Write-Host "[CRIADO] Symlink: $TargetPath -> $SourcePath" -ForegroundColor Green
        } catch {
            # Fallback para Junction caso seja diretório e não tenha permissão de symlink
            if ($ItemType -eq 'Directory') {
                New-Item -ItemType Junction -Path $TargetPath -Target $SourcePath -Force | Out-Null
                Write-Host "[CRIADO] Junction: $TargetPath -> $SourcePath" -ForegroundColor Green
            } else {
                # Fallback para HardLink para arquivos
                New-Item -ItemType HardLink -Path $TargetPath -Target $SourcePath -Force | Out-Null
                Write-Host "[CRIADO] HardLink: $TargetPath -> $SourcePath" -ForegroundColor Green
            }
        }
    }
}

# 1. Sincronização Antigravity / Gemini IDE
if ($Target -in @('All', 'Gemini')) {
    Write-Host "`n[+] Sincronizando configurações para Antigravity/Gemini..." -ForegroundColor Magenta
    
    $GeminiConfigDir = Join-Path $UserProfile ".gemini\config"
    
    # Links para Rules
    $RulesSource = Join-Path $AgentCorePath "rules"
    $RulesTarget = Join-Path $GeminiConfigDir "rules"
    Ensure-Symlink -SourcePath $RulesSource -TargetPath $RulesTarget -ItemType 'Directory'

    # Sincroniza cada Skill individualmente em .gemini\config\skills
    $SkillsSourceDir = Join-Path $AgentCorePath "skills"
    $SkillsTargetDir = Join-Path $GeminiConfigDir "skills"
    if (-not (Test-Path -Path $SkillsTargetDir)) {
        New-Item -ItemType Directory -Path $SkillsTargetDir -Force | Out-Null
    }

    if (Test-Path -Path $SkillsSourceDir) {
        Get-ChildItem -Path $SkillsSourceDir -Directory | ForEach-Object {
            $skillName = $_.Name
            $singleSkillSource = $_.FullName
            $singleSkillTarget = Join-Path $SkillsTargetDir $skillName
            Ensure-Symlink -SourcePath $singleSkillSource -TargetPath $singleSkillTarget -ItemType 'Directory'
        }
    }

    # Sincroniza cada Plugin individualmente em .gemini\config\plugins
    $PluginsSourceDir = Join-Path $AgentCorePath "plugins"
    $PluginsTargetDir = Join-Path $GeminiConfigDir "plugins"
    if (-not (Test-Path -Path $PluginsTargetDir)) {
        New-Item -ItemType Directory -Path $PluginsTargetDir -Force | Out-Null
    }

    if (Test-Path -Path $PluginsSourceDir) {
        Get-ChildItem -Path $PluginsSourceDir -Directory | ForEach-Object {
            $pluginName = $_.Name
            $singlePluginSource = $_.FullName
            $singlePluginTarget = Join-Path $PluginsTargetDir $pluginName
            Ensure-Symlink -SourcePath $singlePluginSource -TargetPath $singlePluginTarget -ItemType 'Directory'
        }
    }


}

# 2. Sincronização Claude Code
if ($Target -in @('All', 'Claude')) {
    Write-Host "`n[+] Sincronizando configurações para Claude Code..." -ForegroundColor Magenta
    
    $ClaudeConfigDir = Join-Path $UserProfile ".claude"
    $ClaudeRuleSource = Join-Path $AgentCorePath "rules\CLAUDE.md"
    $ClaudeRuleTarget = Join-Path $ClaudeConfigDir "CLAUDE.md"
    
    Ensure-Symlink -SourcePath $ClaudeRuleSource -TargetPath $ClaudeRuleTarget -ItemType 'File'
}

# 3. Sincronização Cursor / Agnóstico
if ($Target -in @('All', 'Cursor')) {
    Write-Host "`n[+] Sincronizando configurações para Cursor / Genérico..." -ForegroundColor Magenta
    
    $CursorConfigDir = Join-Path $UserProfile ".cursor"
    $CursorRuleSource = Join-Path $AgentCorePath "rules\AGENTS.md"
    $CursorRuleTarget = Join-Path $CursorConfigDir "AGENTS.md"
    
    Ensure-Symlink -SourcePath $CursorRuleSource -TargetPath $CursorRuleTarget -ItemType 'File'
}

Write-Host "`n[Concluído] Processo de sincronização finalizado com sucesso." -ForegroundColor Green
