#!/usr/bin/env powershell

#Requires -Version 5

param (
    # # The name of the component to be built. Defaults to none
    # [string]$Component,
    # The base hab version to run the build with. Defaults to latest
    [string]$BaseHabVersion="latest",
    # The builder channel to pull from. Defaults to stable
    [string]$SourceChannel="stable"
)

# Import shared functions
. "$PSScriptRoot\shared.ps1" -ErrorAction Stop

Write-Host "--- Setting source package channel to $SourceChannel"
$Env:HAB_BLDR_CHANNEL="$SourceChannel"

Write-Host "--- Installing base habitat binary version: $BaseHabVersion"
$baseHabExe = [HabShared]::install_base_habitat_binary($BaseHabVersion, $SourceChannel)
Write-Host "--- Using hab executable at $baseHabExe"

$thingy = Invoke-Expression "buildkite-agent meta-data get 'version'"
Write-Host "THING: $thingy"

# Invoke-WebRequest "https://api.habitat.sh/v1/depot/pkgs/core/hab/0.68.1-dev/latest?target=x86_64-windows"


# exit $LASTEXITCODE