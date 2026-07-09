# Shuffled Template

Minimal LaTeX/Lua project that demonstrates how to organize, shuffle, and render
multiple-choice theoretical exams.

The project is intentionally compact:

- reusable engine files live in `engine/`;
- reusable template figures live in `figures/`;
- each exam keeps metadata and section files together;
- Lua shuffles questions and alternatives;
- the same content renders a student version or a teacher version.

## Structure

```text
assessment/templates/shuffled/
  README.md
  engine/
    exam.tex
    shuffling.lua
  figures/
    institution-logomark.png
  output/
  scripts/
    build.ps1
  examples/
    generic-course/
      student-version.tex
      teacher-version.tex
      metadata.tex
      sections/
        S01.tex
        S02.tex
```

## Requirements

- LuaLaTeX.
- A LaTeX distribution with common packages such as `fontspec`, `etoolbox`,
  `fancyhdr`, `multicol`, `tikz`, and `luacode`.
- PowerShell, if using the provided build script.

## Build

From this folder:

```powershell
.\scripts\build.ps1 -Path .\examples\generic-course
```

This generates:

- `<date>-P<number>_student-version.pdf`
- `<date>-P<number>_teacher-version.pdf`

The PDFs are written to `output/`. The date and number come from `metadata.tex`.

To build only one output:

```powershell
.\scripts\build.ps1 -Path .\examples\generic-course -StudentOnly
.\scripts\build.ps1 -Path .\examples\generic-course -TeacherOnly
```

The previous `-TestOnly` and `-AnswerKeyOnly` switches remain available as
aliases for compatibility.

To remove common LaTeX temporary files after building:

```powershell
.\scripts\build.ps1 -Path .\examples\generic-course -Clean
```

## Authoring Questions

Each section file follows this pattern:

```latex
\startSection
\sectionTitle{Section title}

\begin{question}{Question statement?}
  \choice{Plausible distractor.}
  \choice[correct]{Correct alternative.}
  \choice{Plausible distractor.}
  \choice{Plausible distractor.}
  \choice{Plausible distractor.}
\end{question}

\shuffleSection
\renderSection
```

The teacher version uses the same questions as the student version. Correct
alternatives are marked by a filled square in the rendered teacher PDF.
