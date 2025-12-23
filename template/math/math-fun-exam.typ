#import "math.typ": color-themes, math-fun-exam
#import "../util/util.typ": _example-answers, dic-he-ma, f-numbering-ref

// ==================== 三种例题类型函数 ====================
// 例题
#let example(number: true, question: none, choices: none, answer: none) = math-fun-exam(
  main-color: color-themes.main,
  kind: "例",
  number: number,
  question: question,
  choices: choices,
  answer: answer,
)

// 例题（带"例题"标识）
#let problem(number: true, question: none, choices: none, answer: none) = math-fun-exam(
  main-color: color-themes.main,
  kind: "例题",
  number: number,
  question: question,
  choices: choices,
  answer: answer,
)

// 练习
#let exercise(number: true, question: none, choices: none, answer: none) = math-fun-exam(
  main-color: color-themes.main,
  kind: "练习",
  number: number,
  question: question,
  choices: choices,
  answer: answer,
)

// ==================== 在文档末尾显示所有答案 ====================
#let show-answers(title: "例题答案") = context {
  let answers = _example-answers.final()
  if answers.len() > 0 {
    pagebreak() // 新起一页
    [#heading(numbering: none, [#title])] // 显示答案标题
    for (idx, item) in answers.enumerate() {
      // 逐个显示答案
      block(
        breakable: true,
        width: 100%,
        [
          #text(fill: color-themes.main, weight: "bold")[
            例 #f-numbering-ref(item.loc, item.kind)
          ]
          #h(0.5em)
          #block(
            // 显示答案内容
            fill: color-themes.main.lighten(95%),
            inset: 0.8em,
            radius: 3pt,
            width: 100%,
          )[#item.answer]
        ],
      )
      v(0.5em)
    }
  }
}

// ==================== 选择题排版 ====================
#let _choice-renderer(
  args,
  indent: 0em,
  columns: 1,
  strong_label: false,
  row-gutter: 1em,
) = {
  // 1. 处理缩进值：如果是布尔值 true，则给默认 2em，否则使用传入的长度
  let indent-val = if type(indent) == bool and indent == true { 2em } else { indent }

  // 2. 获取位置参数（即选项内容）
  let opts = args.pos()

  // 3. 生成 Grid
  pad(left: indent-val, y: 0em, grid(
    columns: columns, // 列数由外部决定
    row-gutter: row-gutter, // 行间距
    column-gutter: 1em, // 列间距
    // 4. 遍历选项，自动添加 A. B. C. ...
    ..opts
      .enumerate()
      .map(((index, content)) => {
        let label = numbering("A.", index + 1)
        let lbl = if strong_label { strong(label) } else { label }
        grid(
          columns: (auto, 1fr),
          column-gutter: 0.3em,
          align: (left + horizon, left + horizon),  // 水平+垂直居中
          lbl,
          content,
        )
      })
  ))
}

// ==================== 修改后的三大函数 ====================

// 1. 双列布局 (2*2) - 最常用
#let choices22(
  indent: 2em,
  row-gutter: 1em,
  ..args,
) = {
  _choice-renderer(args, indent: indent, columns: (1fr, 1fr), row-gutter: row-gutter)
}

// 2. 单行布局 (1*4) - 选项很短时用
#let choices14(
  indent: 2em,
  row-gutter: 1em,
  ..args,
) = {
  _choice-renderer(args, indent: indent, columns: (1fr, 1fr, 1fr, 1fr), row-gutter: row-gutter)
}

// 3. 单列布局 (4*1) - 选项很长时用
#let choices41(
  indent: 2em,
  row-gutter: 1em,
  ..args,
) = {
  _choice-renderer(args, indent: indent, columns: 1fr, row-gutter: row-gutter)
}

// --- B. 填空题下划线 ---
#let blank(width: 3em) = {
  box(width: width, stroke: (bottom: 0.5pt))
}
