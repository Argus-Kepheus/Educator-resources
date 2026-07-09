# TeXstudio Setup

Recommended TeXstudio commands for compiling these templates:

- Build and view:
  `txs:///lualatex | txs:///biber | txs:///lualatex | txs:///lualatex | txs:///view-pdf`
- Default compiler:
  `txs:///lualatex`

LuaLaTeX is recommended for both templates because they use `fontspec` and
multilingual content. The shuffled template requires LuaLaTeX because it calls
Lua code during compilation.

## Recommended Workflow

Prefer the provided PowerShell build scripts when working locally:

```powershell
cd assessment/templates/fixed-order
.\scripts\build.ps1 -Path . -Clean

cd ../shuffled
.\scripts\build.ps1 -Path . -Clean
```

The scripts write stable output names:

- `output/student-version.pdf`
- `output/teacher-version.pdf`

## Manual Compilation

For fixed-order manual compilation, open:

```text
assessment/templates/fixed-order/engine/main.tex
```

For shuffled manual compilation, open either:

```text
assessment/templates/shuffled/engine/student-version.tex
assessment/templates/shuffled/engine/teacher-version.tex
```

If compiling manually from TeXstudio, make sure the working directory is the
template root so `metadata.tex`, `sections/`, and `figures/` resolve correctly.
