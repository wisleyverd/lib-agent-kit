<#
.SYNOPSIS
    Verifica a integridade e alvos dos links simbólicos criados pelo lib-agent-kit.

.DESCRIPTION
    Inspeciona os diretórios de configuração globais e relata o status de cada link.
#>

[CmdletBinding()]
param()

$UserProfile = [Environment]::GetFolderPath("UserProfile")

$PathsToCheck = @(
    @{ Name = "Gemini Rules";          Path = Join-Path $UserProfile ".gemini\config\rules" },
    @{ Name = "Gemini Plugin: spec-kit"; Path = Join-Path $UserProfile ".gemini\config\plugins\spec-kit" },
    @{ Name = "Gemini Skill: spec-kit";  Path = Join-Path $UserProfile ".gemini\config\skills\spec-kit" },
    @{ Name = "Gemini Skill: repo-memory"; Path = Join-Path $UserProfile ".gemini\config\skills\repo-memory" },
    @{ Name = "Claude Rules";          Path = Join-Path $UserProfile ".claude\CLAUDE.md" },

    @{ Name = "Cursor Rules";          Path = Join-Path $UserProfile ".cursor\AGENTS.md" }
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  lib-agent-kit | Verificação de Links e Integridade" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

foreach ($check in $PathsToCheck) {
    $p = $check.Path
    $name = $check.Name
    
    if (-not (Test-Path -Path $p)) {
        Write-Host "[NÃO ENCONTRADO] $name -> $p" -ForegroundColor DarkGray
        continue
    }

    $item = Get-Item -Path $p -Force
    $isReparse = [bool]($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint)

    if ($isReparse) {
        $target = $item.Target
        Write-Host "[LINK ATIVO] $name" -ForegroundColor Green
        Write-Host "    Origem  : $p"
        Write-Host "    Alvo    : $target"
    } else {
        Write-Host "[ARQUIVO/DIR LOCAL (NÃO É LINK)] $name -> $p" -ForegroundColor Yellow
    }
}

