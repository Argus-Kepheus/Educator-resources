local state = {
  questions = {},
  currentQuestion = nil,
  globalCounter = 0
}

local function shuffleList(items)
  for i = #items, 2, -1 do
    local j = math.random(1, i)
    items[i], items[j] = items[j], items[i]
  end
end

function setSeed(seed)
  assert(type(seed) == "number", "Seed must be a number")
  math.randomseed(seed)
  for _ = 1, 10 do
    math.random()
  end
end

function resetGlobalCounter()
  state.globalCounter = 0
end

function resetSectionCounter()
  tex.sprint("\\setcounter{sectionCounter}{0}")
end

function startQuestionSection()
  state.questions = {}
end

function startQuestion(questionIndex)
  state.currentQuestion = {
    questionIndex = questionIndex,
    alternatives = {}
  }
end

function addAlternative(alternativeIndex, correct)
  if state.currentQuestion then
    table.insert(state.currentQuestion.alternatives, {
      alternativeIndex = alternativeIndex,
      correct = correct or false
    })
  end
end

function finalizeQuestion()
  if state.currentQuestion then
    table.insert(state.questions, state.currentQuestion)
    state.currentQuestion = nil
  end
end

function shuffleQuestions()
  shuffleList(state.questions)
end

function shuffleAlternatives()
  for _, question in ipairs(state.questions) do
    shuffleList(question.alternatives)
  end
end

function renderQuestions(showAnswers, questionLabel)
  for _, question in ipairs(state.questions) do
    state.globalCounter = state.globalCounter + 1

    tex.print("\\setlength{\\questionChoiceSpacing}{0.5em}")
    tex.print("\\vspace{\\questionSpacing}")
    tex.print("\\noindent")
    tex.print("\\textbf{\\questionFontSize " .. questionLabel .. " " .. state.globalCounter .. ":}")
    tex.print("\\setlength{\\parindent}{0pt}")
    tex.print("\\useSlot{" .. question.questionIndex .. "}")
    tex.print("")

    for _, alternative in ipairs(question.alternatives) do
      local symbol = "\\testChoiceMarker{}"
      local answerStyle = ""
      if showAnswers and alternative.correct then
        symbol = "\\answerKeyChoiceMarker{}"
        answerStyle = "\\answerKeyChoiceStyle{}"
      end

      tex.print("\\vspace{\\questionChoiceSpacing}")
      tex.print("\\noindent")
      tex.print(symbol)
      tex.print("\\hspace{0.3em}")
      tex.print("\\begin{minipage}[t]{0.88\\linewidth}")
      tex.print("\\raggedright " .. answerStyle .. "\\useSlot{" .. alternative.alternativeIndex .. "}")
      tex.print("\\end{minipage}\\\\[\\choiceSpacing]")
    end

    tex.print("\\setlength{\\questionChoiceSpacing}{0pt}")
    tex.print("")
  end
end
