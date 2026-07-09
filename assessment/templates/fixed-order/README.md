# Fixed-order Template

A fixed-order LaTeX template for generating multiple-choice exams with optional
answer-key rendering.

This template follows a fixed-order approach: metadata and layout commands live
in `main.tex`, while question content lives in separate files under `sections/`.
It is useful when the assessment should keep the authored question order but use
the same section-file style as the shuffled template.

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
  main.tex
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

Edit the metadata section at the beginning of `main.tex`:

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

Include section files from `main.tex` in the exact order they should appear:

```latex
\input{sections/S01.tex}
\input{sections/S02.tex}
```

Switch between student and teacher versions by changing:

```latex
\setboolean{showanswers}{false}
```

Use `false` for the student version and `true` for the teacher version. When
answers are shown, correct alternatives render with filled squares and incorrect
alternatives render with empty squares.

## Requirements

- A LaTeX distribution such as TeX Live or MiKTeX.
- LuaLaTeX, recommended for Unicode content through `fontspec`.
- A LaTeX editor such as TeXstudio, Overleaf, or VS Code with LaTeX tooling.

## Notes

The bundled PDFs under `output/` are examples generated from the template. They
are included as reference artifacts, not as source files.
