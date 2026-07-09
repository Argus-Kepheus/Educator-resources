# Fixed-order Template

A fixed-order LaTeX template for generating multiple-choice exams with optional
answer-key rendering.

This template follows a fixed-order approach: metadata lives in `metadata.tex`,
layout and rendering commands live in `engine/main.tex`, and question content
lives in separate files under `sections/`. It is useful when the assessment
should keep the authored question order but use the same section-file style as
the shuffled template.

## Features

- Automatic question numbering.
- Five alternatives per question.
- Two compilation modes: student version and teacher version.
- Column-based formatting for print-friendly layouts.
- Multilingual content support through `babel` and `fontspec`.

## Structure

```text
assessment/templates/fixed-order/
  README.md
  metadata.tex
  engine/
    main.tex
  scripts/
    build.ps1
  sections/
    S01.tex
    S02.tex
    ...
  figures/
    institution-logomark.png
  output/
    student-version.pdf
    teacher-version.pdf
```

## Usage

Edit the metadata file:

```latex
\newcommand{\subject}{Your Subject Name}
\newcommand{\teacher}{Your Name}
\newcommand{\examdate}{Exam Date}
```

Add sections in separate files under `sections/`, using the same authoring shape
used by the shuffled template:

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

\renderSection
```

In this fixed-order template, questions render immediately in source order.
`\shuffleSection` is intentionally not defined here; use the shuffled template
when section-level randomization is required.

Include section files from `engine/main.tex` in the exact order they should
appear:

```latex
\input{../sections/S01.tex}
\input{../sections/S02.tex}
```

From this folder, build both PDFs with:

```powershell
.\scripts\build.ps1 -Path . -Clean
```

This generates `student-version.pdf` and `teacher-version.pdf` in `output/`.
The script sets the answer rendering mode automatically. When answers are shown,
correct alternatives render with filled squares and incorrect alternatives
render with empty squares.

## Requirements

- A LaTeX distribution such as TeX Live or MiKTeX.
- LuaLaTeX, recommended for Unicode content through `fontspec`.
- A LaTeX editor such as TeXstudio, Overleaf, or VS Code with LaTeX tooling.

## Notes

The bundled PDFs under `output/` are examples generated from the template. They
are included as reference artifacts, not as source files.
