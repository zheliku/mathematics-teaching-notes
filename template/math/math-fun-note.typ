#import "math.typ": color-themes, math-fun-note

// 提示类环境
#let note(body) = math-fun-note(
  main-color: color-themes.second,
  font: ("Times New Roman", "KaiTi"),
  "笔记",
  body,
)

// 结论类环境
#let conclusion(body) = math-fun-note(
  main-color: color-themes.third,
  font: ("Times New Roman", "KaiTi"),
  "结论",
  body,
)
#let assumption(body) = math-fun-note(
  main-color: color-themes.third,
  font: ("Times New Roman", "KaiTi"),
  "假设",
  body,
)
#let property(body) = math-fun-note(
  main-color: color-themes.third,
  font: ("Times New Roman", "KaiTi"),
  "性质",
  body,
)

#let remark(body) = math-fun-note(main-color: color-themes.second, font: ("Times New Roman", "KaiTi"), "注", body)
#let solution(body) = math-fun-note(main-color: color-themes.main, font: ("Times New Roman", "KaiTi"), "解", body)

#let proof(body) = math-fun-note(
  main-color: color-themes.second,
  font: ("Times New Roman", "KaiTi"),
  "证明",
  body,
)
