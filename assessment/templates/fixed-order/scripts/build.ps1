param(
  [Parameter(Mandatory = $true)]
  [string]$Path,

  [Alias('TestOnly')]
  [switch]$StudentOnly,

  [Alias('AnswerKeyOnly')]
  [switch]$TeacherOnly,

  [switch]$Clean
)

$ErrorActionPreference = 'Stop'

function Remove-LatexTemporaryFiles {
  param([Parameter(Mandatory = $true)][string]$Directory)
  $patterns = @('*.aux', '*.log', '*.out', '*.bcf', '*.run.xml', '*.bbl', '*.blg', '*.synctex.gz')
  foreach ($pattern in $patterns) {
    Get-ChildItem -LiteralPath $Directory -Filter $pattern -File -ErrorAction SilentlyContinue | Remove-Item -Force
  }
}

function Invoke-LuaLaTeX {
  param(
    [Parameter(Mandatory = $true)][string]$InputExpression,
    [Parameter(Mandatory = $true)][string]$JobName,
    [Parameter(Mandatory = $true)][string]$OutputDirectory,
    [int]$Passes = 2
  )

  for ($pass = 1; $pass -le $Passes; $pass++) {
    & lualatex "-jobname=$JobName" "-output-directory=$OutputDirectory" -interaction=nonstopmode -halt-on-error $InputExpression
    if ($LASTEXITCODE -ne 0) {
      throw "LuaLaTeX failed for $JobName on pass $pass"
    }
  }
}

$targetDir = (Resolve-Path -LiteralPath $Path).Path
$templateDir = Split-Path -Parent $PSScriptRoot
$outputDir = Join-Path $templateDir 'output'
$engineDir = Join-Path $targetDir 'engine'
$mainFile = Join-Path $engineDir 'main.tex'

if (-not (Test-Path -LiteralPath $mainFile)) {
  throw "main.tex not found in: $engineDir"
}

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

Push-Location $engineDir
try {
  if (-not $TeacherOnly) {
    Invoke-LuaLaTeX -InputExpression '\def\FixedOrderShowAnswers{false}\input{main.tex}' -JobName 'student-version' -OutputDirectory $outputDir
  }
  if (-not $StudentOnly) {
    Invoke-LuaLaTeX -InputExpression '\def\FixedOrderShowAnswers{true}\input{main.tex}' -JobName 'teacher-version' -OutputDirectory $outputDir
  }
} finally {
  Pop-Location
}

if ($Clean) {
  Remove-LatexTemporaryFiles -Directory $targetDir
  Remove-LatexTemporaryFiles -Directory $outputDir
}

Write-Output "Built exam files in: $outputDir"
