# Multiple-Choice Exam LaTeX Template

A simple yet functional LaTeX template for generating multiple-choice exams with automatic answer key generation.

## Overview

This template follows a monolithic approach to exam generation and was one of the first functional implementations developed by Calvimontes S. C. While more sophisticated versions are available in this repository, this template adequately serves most use cases for creating multiple-choice assessments.

## Features

- Automatic question numbering
- Five alternatives per question (`A–E` format)
- Two compilation modes: Student version and Teacher version (with answer key)
- Column-based formatting for space efficiency
- Multilingual support (proof of concept using `babel`)

## Motivation

This template was created to automate the repetitive task of formatting exams for students. It streamlines the process while maintaining a consistent and professional appearance.

## Usage

### Basic Setup

1. Edit the metadata section at the beginning of the document:
   \newcommand{\subject}{Your Subject Name}
   \newcommand{\teacher}{Your Name}
   \newcommand{\examdate}{Exam Date}

2. Add your questions using the provided format:
   \Question
   Your question text here?

   \Alternative{Option A text}{}
   \Alternative{Option B text}{OK}  % Correct answer
   \Alternative{Option C text}{}
   \Alternative{Option D text}{}
   \Alternative{Option E text}{}

3. Switching Between Student and Teacher Versions:
   To toggle between versions, modify the \setboolean{showanswers} line:

   - Student version (no answers marked):
     \setboolean{showanswers}{false}

   - Teacher version (correct answers marked):
     \setboolean{showanswers}{true}

   When compiled with `true`, correct answers will be displayed with filled squares (■), while incorrect answers will show empty squares (□).

4. Multilingual Support:
   The template includes basic support for multiple languages via the `babel` package (Portuguese, Spanish, French, Italian, German, English). This feature is a proof of concept and may require additional configuration for production use.

   To switch languages:
   \selectlanguage{<babel-compatible-desired-language>}

## Requirements

- LaTeX distribution (e.g., TeX Live, MiKTeX)
- Basic LaTeX knowledge
- Text editor (TeXstudio recommended)

## License

This project is licensed under the MIT License. See the LICENSE file or visit https://opensource.org/licenses/MIT for details.