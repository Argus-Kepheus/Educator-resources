# Fixed-order Template Notes

The fixed-order template is the repository's legacy implementation. It keeps the full exam engine and sample content in a single LaTeX file, which makes it easy to inspect and adapt but harder to reuse across multiple exams.

## Current Behavior

- `\setboolean{showanswers}{true}` renders the teacher version.
- `\setboolean{showanswers}{false}` renders the student version.
- `\Question` creates automatically numbered questions.
- `\Alternative{...}{OK}` marks the correct answer.
- `\Alternative{...}{}` marks a distractor.

## Editorial Direction

- Keep comments and documentation in English.
- Keep sample exam content in the language that best fits the audience.
- Prefer the shuffled template for new work that needs reusable sections,
  multiple exam versions, or separate answer-key generation.
