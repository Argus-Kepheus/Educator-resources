# Fixed-order Template Notes

The fixed-order template is the deterministic companion to the shuffled
template. Both templates now share the same metadata file shape and the same
section authoring style.

## Current Behavior

- `engine/main.tex` is the compilable LaTeX entry point.
- `metadata.tex` stores institution, exam, label, and instruction metadata.
- `sections/` stores modular question sections.
- `scripts/build.ps1` builds `output/student-version.pdf` and
  `output/teacher-version.pdf`.
- `\begin{question}{...}` starts an automatically numbered question.
- `\choice[correct]{...}` marks the correct answer.
- `\choice{...}` marks a distractor.
- `\shuffleSection` is intentionally unavailable in this template.

## Metadata Policy

Keep the fixed-order metadata names as the canonical fields:

```latex
\subject
\teacher
\examdate
\period
\examversion
\examduration
```

The shared metadata files also define compatibility aliases used by the
shuffled engine:

```latex
\examSubject
\examDate
\examVersion
\examTime
\instructorName
```

## Editorial Direction

- Keep documentation and code comments in English.
- Keep sample exam content in any Latin-script language that fits the audience.
- Use this template when question order must remain exactly as authored.
- Use the shuffled template when question or alternative order should vary.
