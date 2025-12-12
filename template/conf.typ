#import "header/header.typ": header-fun, heading-update
#import "util/color.typ": color-select
#import "util/util.typ": f-heading, dic-he-ma, f-numbering-ref
#import "util/util.typ": heading-style
#import "util/util.typ": equation-heading-update, figure-image-heading-update, math-fun-heading-update

#import "@preview/numbly:0.1.0": numbly

#let indent = h(2em)

#let conf(doc, color-theme: "blue", eq-level: 1, fig-image-level: 1, math-fun-level: 1) = {
  // 颜色
  let color-themes = color-select(color-theme)

  // 页面
  set page(margin: (x: 20mm, y: 25.4mm))
  // 页眉
  show heading: it => it + heading-update(it)
  set page(header: header-fun(color-themes.structure), header-ascent: 20%)
  // 页脚
  set page(
    footer-descent: 12mm,
    footer: context align(center, text(fill: color-themes.structure)[#counter(page).display()]),
  )

  // 段落
  set par(justify: true, leading: 1em, spacing: 1em)

  // 字体
  set text(lang: "zh", region: "cn", size: 12pt)
  set text(font: ("Times New Roman", "FangSong"))
  show emph: set text(font: ("Times New Roman", "KaiTi"))
  show strong: set text(font: ("Times New Roman", "SimHei"))
  show text.where(weight: "bold"): set text(font: ("Times New Roman", "SimHei"))

  // 标题
  show: heading-style.with(color-themes.structure)
  set heading(numbering: numbly("第{1:一}章", default: "1.1"))
  // 标题计数更新
  show heading: it => {
    it
    equation-heading-update(it, eq-level)
    figure-image-heading-update(it, fig-image-level)
    math-fun-heading-update(it, math-fun-level)
  }

  // 数学计数
  set math.equation(
    numbering: _ => [
      (#numbering("1.1",..f-heading(level: eq-level)).#counter(math.equation).display("1"))
    ],
  )
  // 图片计数
  show figure.where(kind: image): set figure(
    numbering: _ => text(weight: "bold", fill: color-themes.structure)[
      #numbering("1.1",..f-heading(level: fig-image-level)).#counter(figure.where(kind: image)).display("1")
    ],
    gap: 0.5em,
    supplement: text(weight: "bold", fill: color-themes.structure)[图],
  )
  show figure.where(kind: image): set block(above: 1em, below: 1.69em)

  // 引用
  show link: set text(fill: rgb(127, 0, 0))
  // math-fun-ref
  let math-fun-ref(element) = {
    let state-update = state("test").update(it => it).func()
    let kind = str(element.label).split(":").first()
    let i = element.children.first()
    if i.func() == state-update {
      if i.fields().values().first() == "dictionary-heading-math" {
        link(element.location(), kind + f-numbering-ref(element.location(), kind))
      }
    }
  }
  show ref: it => {
    set text(fill: rgb(127, 0, 0))
    let e = it.element
    if e != none and e.func() == heading {
      link(e.location(), numbering(e.numbering, ..counter(heading).at(e.location())) + " " + e.body)
    } else if e != none and e.func() == [].func() { math-fun-ref(e) } else {
      it
    }
  }

  // 列表
  set list(
    marker: (
      text(fill: color-themes.structure)[•],
      text(fill: color-themes.structure)[‣],
      text(fill: color-themes.structure)[–],
    ),
    indent: 1em,
  )
  set enum(
    numbering: (..it) => {
      set text(fill: color-themes.structure)
      numbly("{1}.", "({2:a}).", "{3:I}.")(..it.pos())
    },
    full: true,
    indent: 1em,
  )

  // 首行缩进
  set par(first-line-indent: (amount: 2em, all: true))
  set terms(indent: 2em)

  // ⚠️ 重要：此 #show 规则必须放在 #show: conf 之后
  // 自动检测高公式并撑开行距
  show math.equation.where(block: false): it => {
    // 将公式转换为字符串，检查是否包含 display 样式
    let eq-str = repr(it.body)
    
    // 如果公式中包含 display() 或 limits，说明是需要更大垂直空间的公式
    if "display" in eq-str or "limits" in eq-str or "frac" in eq-str or "sum" in eq-str or "int" in eq-str or "prod" in eq-str {
      // 对于包含 display 样式的公式，增加垂直间距并调整基线
      context {
        let size = measure(it)
        // 根据实际高度动态调整 baseline
        // 较高的公式使用较小的 baseline 百分比，以获得更好的视觉对齐
        let baseline-percent = if size.height > 15pt {
          30%
        } else if size.height > 10pt {
          35%
        } else {
          35%
        }
        // [#size.height, #box(it, inset: (y: 0.5em), baseline: baseline-percent)]
        box(it, inset: (y: 0.5em), baseline: baseline-percent)
      }
    } else {
      // 普通行内公式保持原样
      it
    }
  }

  doc
}
