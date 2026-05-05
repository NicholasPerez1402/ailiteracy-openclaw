$currentPath = Get-Location
$env:OPENCLAW_HOME = "$currentPath"
$env:OPENCLAW_CONFIG_PATH = "$currentPath\openclaw.json"

if (!(Test-Path "workspace")) { New-Item -ItemType Directory -Path "workspace" }

# --- NEW BLOCK: Load .env file into the Windows session ---
$envFile = "$currentPath\.env"
if (Test-Path $envFile) {
    Get-Content $envFile | Where-Object { $_ -match '=' -and $_ -notmatch '^#' } | ForEach-Object {
        $name, $value = $_.Split('=', 2)
        Set-Item -Path "env:\$($name.Trim())" -Value $value.Trim()
    }
}

if ($args.Count -eq 0) {
	npx openclaw gateway
}
else {
	npx openclaw @args
}
