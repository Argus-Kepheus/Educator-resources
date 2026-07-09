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
    [Parameter(Mandatory = $true)][string]$TexFile,
    [Parameter(Mandatory = $true)][string]$JobName,
    [Parameter(Mandatory = $true)][string]$OutputDirectory,
    [int]$Passes = 2
  )

  for ($pass = 1; $pass -le $Passes; $pass++) {
    & lualatex "-jobname=$JobName" "-output-directory=$OutputDirectory" -interaction=nonstopmode -halt-on-error $TexFile
    if ($LASTEXITCODE -ne 0) {
      throw "LuaLaTeX failed for $TexFile on pass $pass"
    }
  }
}

function Get-TexCommandValue {
  param(
    [Parameter(Mandatory = $true)][string]$File,
    [Parameter(Mandatory = $true)][string]$Command
  )

  if (-not (Test-Path -LiteralPath $File)) {
    return ''
  }

  $pattern = "\\(?:newcommand|renewcommand)\{\\$Command\}\{([^}]*)\}"
  foreach ($line in Get-Content -LiteralPath $File) {
    if ($line -match $pattern) {
      return $Matches[1]
    }
  }
  return ''
}

$targetDir = (Resolve-Path -LiteralPath $Path).Path
$templateDir = Split-Path -Parent $PSScriptRoot
$outputDir = Join-Path $templateDir 'output'
$engineDir = Join-Path $targetDir 'engine'
$studentVersion = Join-Path $engineDir 'student-version.tex'
$teacherVersion = Join-Path $engineDir 'teacher-version.tex'
$metadata = Join-Path $targetDir 'metadata.tex'

if (-not (Test-Path -LiteralPath $studentVersion)) {
  throw "student-version.tex not found in: $engineDir"
}
if (-not $StudentOnly -and -not (Test-Path -LiteralPath $teacherVersion)) {
  throw "teacher-version.tex not found in: $engineDir"
}

$examDate = Get-TexCommandValue -File $metadata -Command 'examDate'
$examNumber = Get-TexCommandValue -File $metadata -Command 'examNumber'
if ([string]::IsNullOrWhiteSpace($examNumber)) {
  $examNumber = '1'
}

if ($examDate -match '^\d{4}-\d{2}-\d{2}$') {
  $jobPrefix = "$examDate-P$examNumber"
} else {
  $jobPrefix = "$(Split-Path -Leaf $targetDir)-P$examNumber"
}

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

Push-Location $targetDir
try {
  if (-not $TeacherOnly) {
    Invoke-LuaLaTeX -TexFile 'engine/student-version.tex' -JobName "${jobPrefix}_student-version" -OutputDirectory $outputDir
  }
  if (-not $StudentOnly) {
    Invoke-LuaLaTeX -TexFile 'engine/teacher-version.tex' -JobName "${jobPrefix}_teacher-version" -OutputDirectory $outputDir
  }
} finally {
  Pop-Location
}

if ($Clean) {
  Remove-LatexTemporaryFiles -Directory $targetDir
  Remove-LatexTemporaryFiles -Directory $outputDir
}

Write-Output "Built exam files in: $outputDir"
