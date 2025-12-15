#import "../util/color.typ": color-select
#import "../util/util.typ": _example-answers, answer-mode, dic-he-ma, dic-he-ma-update, f-numbering, f-numbering-ref

// 颜色主题
#let color-themes = color-select("blue")

// 定理类环境-框架
#let math-fun-def-frame(main-color, title, content) = {
  v(-0.5em)
  block(
    breakable: false,
    stack(
      dir: btt,
      rect(
        width: 100%,
        radius: 3pt,
        inset: 1.2em,
        stroke: main-color,
        fill: main-color.lighten(95%),
        {
          set text(font: ("Times New Roman", "FZKai-Z03S"))
          content
        },
      ),
      move(
        dx: 2em,
        dy: 0.5em,
        block(
          stroke: none,
          fill: main-color,
          inset: 0.3em,
          outset: (x: 0.8em),
          text(fill: white, weight: "bold", bottom-edge: "descender")[#title],
        ),
      ),
    ),
  )
}

// 定理类环境
#let math-fun-def(main-color: rgb(0, 0, 0), kind: "", number: true, name, content) = {
  if number { dic-he-ma-update(kind) }
  let title = kind + if number { f-numbering(kind) } + name
  math-fun-def-frame(main-color, title, content)
}

// 示例类环境
#let math-fun-exam(
  main-color: rgb(0, 0, 0),
  number: true,
  kind: "",
  question: none,
  choices: none,
  answer: none,
) = context {
  if number { dic-he-ma-update(kind) }
  let title = kind + " " + if number { f-numbering(kind) }
  text(fill: main-color, weight: "bold", font: ("Times New Roman", "FZHei-B01S"))[#title]
  " "
  let loc = here() // 获取当前位置，用于后续生成编号
  // 直接输出 question 和 choices，确保它们受到全局 #show 规则影响
  if question != none [
    #question
  ]
  if choices != none [
    #choices
  ]
  let mode = answer-mode.get() // 4. 根据模式决定答案显示位置
  if answer != none {
    if mode == "inline" {
      // 紧跟在例题后面显示答案
      block(
        fill: color-themes.main.lighten(95%),
        inset: 0.8em,
        radius: 3pt,
        width: 100%,
        [
          #text(fill: color-themes.main, weight: "bold")[答案：]
          #answer
        ],
      )
    } else if mode == "end" {
      _example-answers.update(answers => {
        // 收集到全局状态，稍后在末尾显示
        answers.push((
          loc: loc,
          kind: kind,
          answer: answer,
        ))
        answers
      })
    }
  }
}

// 提示类环境
#let math-fun-note(main-color: rgb(0, 0, 0), font: ("Times New Roman", "FZShuSong-Z01S"), kind, body) = (
  text(fill: main-color, weight: "bold")[#kind]
    + " "
    + {
      set text(font: font)
      body
    }
)

#let set-answer-mode(mode) = {
  assert(mode in ("inline", "end"), message: "答案模式必须是 'inline' (紧跟例题) 或 'end' (文档末尾)")
  answer-mode.update(mode)
}
