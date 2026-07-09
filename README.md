# Educator Resources

Reusable resources for educators who need to create, maintain, and publish
teaching materials. The current project lives under `assessment/` and focuses on
LaTeX templates for multiple-choice theoretical exams.

## Repository Layout

```text
assessment/
  templates/
    fixed-order/          Single-file LaTeX template without shuffling.
    shuffled/             Modular LaTeX/Lua template with shuffling.
  prompts/
    question-generation/  Prompt resources for generating exam items.
  docs/                   Assessment-specific notes and editor setup guidance.
```

The root of the repository is intentionally kept small so other educator
resource families can be added later beside `assessment/`.

## Available Templates

- [Fixed-order template](assessment/templates/fixed-order/README.md):
  a compact, single-file template that can render student and teacher versions.
- [Shuffled template](assessment/templates/shuffled/README.md):
  a modular template that stores questions in section files and uses Lua to
  shuffle questions and alternatives.

## Editorial Guidelines

- Documentation and code comments must be written in English.
- Exam content may be written in any Latin-script language.
- Prefer clear, portable folder names using lowercase words separated by
  hyphens.
- Keep generated or sample PDFs under an `output/` folder when they are useful
  as examples.

## Requirements

- A LaTeX distribution such as TeX Live or MiKTeX.
- LuaLaTeX for the shuffled template.
- PowerShell when using the provided build script.

## License

This project is licensed under the [MIT License](LICENSE).

Calvimontes S. C.
