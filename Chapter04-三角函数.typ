#import "template/lib.typ": *
#import "@preview/cetz:0.4.2": angle, canvas, draw
#import "@preview/cuti:0.4.0": show-cn-fakebold
#show: show-cn-fakebold

// 为代码块添加背景色、圆角，并给每一行代码添加行号
#show raw.where(block: true): it => {
  set par(justify: false)
  block(
    fill: luma(245),
    inset: (top: 4pt, bottom: 4pt),
    radius: 4pt,
    width: 100%,
    stack(
      ..it.lines.map(raw_line => block(
        inset: 3pt,
        width: 100%,
        grid(
          columns: (1em + 4pt, 1fr),
          align: (right + horizon, left),
          column-gutter: 0.7em,
          row-gutter: 0.6em,
          text(gray, [#raw_line.number]), raw_line,
        ),
      )),
    ),
  )
}

#show: conf

#default-cover(
  cover: image("image/cover.jpg", width: 100%), // 请确保有对应的封面图片
  title: [第4章],
  subtitle: [三角函数],
  author: [zheliku],
  date: datetime.today().display(),
  version: version(1, 0, 0),
)
#default-outline()

// ==================== 配置答案显示模式 ====================
#set-answer-mode("end")

#let introduction = introduction.with(color: color-select("blue").structure)

#set raw(lang: "typst")

// ----------------------正文开始-----------------------

// 【请发送 PART 01 及后续内容，我将为您继续生成】

= 三角函数

#introduction[角与弧度制][三角函数定义]

== 角与弧度制

#definition("角")[
  角可以看成平面内的一条射线绕着端点从一个位置旋转到另一个位置（终边）所成的图形。
  #align(center)[

    #canvas({
      draw.line((0, 0), (4, 0), name: "a")
      draw.line((0, 0), (3, 2.5), name: "b")

      // Draw an angle between the two lines
      angle.angle(
        "a.start",
        "a.end",
        "b.end",
        mark: (end: ">>"),
        label: move(dx: 2em, dy: -0.8em)[#text(black, $alpha$, size: 15pt)],
        radius: 1,
      )
      draw.content((rel: (0, -0.3), to: "a"), [始边])
      draw.content((rel: (-0.3, 0.3), to: "b"), [终边], angle: 40deg)
    })
  ]
]

+ 按旋转方向不同分为：正角、负角、零角。
+ 按终边位置不同分为：象限角和轴线角。


#table(
  columns: (1fr, 4fr, 2fr),
  align: (center + horizon, center + horizon, center + horizon),
  stroke: none,
  inset: 0.5em,
  table.hline(stroke: 1.5pt),
  table.header([*名称*], [*定义*], [*图形*]),
  table.hline(stroke: 0.75pt),
  [正角],
  [一条射线绕其端点按逆时针方向旋转形成的角],
  [
    #canvas({
      draw.line((0, 0), (2, 0), name: "a")
      draw.line((0, 0), (1.8, 1), name: "b")

      // Draw an angle between the two lines
      angle.angle(
        "a.start",
        "a.end",
        "b.end",
        mark: (end: ">>"),
        radius: 0.8,
      )
      draw.content((rel: (-0.2, -0.1), to: "a.start"), [$O$])
      draw.content((rel: (0.2, 0), to: "a.end"), [$A$])
      draw.content((rel: (0.2, 0), to: "b.end"), [$B$])
    })
  ],
  [负角],
  [一条射线绕其端点按顺时针方向旋转形成的角],
  [
    #canvas({
      draw.line((0, 0), (2, 0), name: "a")
      draw.line((0, 0), (1.8, 1), name: "b")

      // Draw an angle between the two lines
      angle.angle(
        "a.start",
        "b.end",
        "a.end",
        mark: (end: ">>"),
        radius: 0.5,
      )
      draw.content((rel: (-0.2, -0.1), to: "a.start"), [$O$])
      draw.content((rel: (0.2, 0), to: "a.end"), [$A$])
      draw.content((rel: (0.2, 0), to: "b.end"), [$B$])
    })
  ],
  [零角],
  [一条射线没有做任何旋转],
  [
    #canvas({
      draw.line((0, 0), (2, 0), name: "a")
      draw.line((0, 0), (2, 0), name: "b")
      draw.circle((0, 0), radius: 0.05, fill: black)

      // Draw an angle between the two lines
      angle.angle(
        "a.start",
        "a.end",
        "b.end",
        mark: (end: ">>"),
        radius: 1,
      )
      draw.content((rel: (-0.3, -0.1), to: "a.start"), [$O$])
      draw.content((rel: (0.2, 0), to: "a.end"), [$A(B)$], anchor: "west")
    })
  ],
  table.hline(stroke: 1.5pt),
)

*终边相同的角*
角 $alpha$ 与其终边相同的所有角，可构成一个集合 $S = { beta | beta = alpha + k dot 360^compose, k in bb(Z) }$。

#definition("角度制")[
  #tab 把周角分成 360 等份，每一份叫做 1 度的角。
]

#example(
  question: [
    下列各角中与 $60^compose$ 角的终边相同的是（#h(3em)）
  ],
  choices: choices14(
    [$-300^compose$],
    [$-240^compose$],
    [$120^compose$],
    [$390^compose$],
  ),
  answer: [#tab *A*],
)

#definition("弧度制")[
  #grid(
    columns: (4fr, 1fr),
    column-gutter: 2em,
    [
      设圆的半径为 $r$，弧长为 $l$，则圆心角 $alpha$ (rad) 所对的弧长与半径的比值 $display(l/r)$ 称为该圆心角的弧度数，用符号 rad 表示，读作弧度。

      用“弧度”作为单位来度量角的单位制叫做弧度制。
    ],
    [
      #canvas({
        let r = 1.2
        draw.circle((0, 0), radius: r, name: "circle")
        draw.line((0, 0), (r, 0), name: "a")
        draw.line((0, 0), (0.5 * r, calc.sqrt(3) / 2 * r), name: "b")
        angle.angle(
          "a.start",
          "a.end",
          "b.end",
          mark: (end: ">"),
          label: move(dx: 1.5em, dy: -0.5em)[#text(size: 10pt, weight: "bold", fill: red)[1 rad]],
          radius: 0.5,
          name: "angle"
        )
        draw.content((rel: (x: 0.2, y: 0), to: "a.end"), [$A$])
        draw.content((rel: (x: 0.1, y: 0.2), to: "b.end"), [$B$])
        draw.content((rel: (-0.2, -0.1), to: "a.start"), [$O$])
        draw.content((rel: (calc.sqrt(3) / 2 * r, 0.5 * r), to: "angle"), [$1$])
      })
    ],
  )
]

#method("公式")[
  设扇形半径为 $r$，弧长为 $l$，圆心角为 $alpha$ (rad)。
  - 角度与弧度换算：$180^compose = pi "rad"$，$1^compose = pi/180 "rad"$，$1 "rad" = (180/pi)^compose approx 57.30^compose$。
  - 弧长公式：$l = |alpha| r$
  - 面积公式：$S = 1/2 l r = 1/2 |alpha| r^2$
]

#example(
  question: [
    【2022广东珠海高一月考】(多选) 下列转化结果正确的是（#h(3em)）
  ],
  choices: choices22(
    [$67^compose 30'$ 化成弧度是 $(3pi)/8 "rad"$],
    [$-(10pi)/3 "rad"$ 化成角度是 $-600^compose$],
    [$-150^compose$ 化成弧度是 $-(7pi)/6 "rad"$],
    [$pi/12 "rad"$ 化成角度是 $15^compose$],
  ),
  answer: [#tab *ABD*],
)

#example(
  question: [
    【2022广东东莞高一期末】已知扇形的面积为 16，当扇形的周长最小时，扇形的圆心角为（#h(3em)）
  ],
  choices: choices14(
    [$1$],
    [$2$],
    [$4$],
    [$8$],
  ),
  answer: [#tab *B*],
)

== 三角函数定义

#method("定义")[
  #tab 在任意角的终边上任取一点 $P(x,y)$，设 $O P = r = sqrt(x^2 + y^2)$。
  $ sin alpha = y/r, quad cos alpha = x/r, quad tan alpha = y/x $
]

#method("符号")[
  - *sin*: 一二正，三四负
  - *cos*: 一四正，二三负
  - *tan*: 一三正，二四负
]

#table(
  columns: (1.5em, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: center + horizon,
  stroke: none,
  table.header(
    [角],
    [$0^compose$],
    [$30^compose$],
    [$45^compose$],
    [$60^compose$],
    [$90^compose$],
    [$120^compose$],
    [$135^compose$],
    [$150^compose$],
    [$180^compose$],
  ),
  table.hline(),
  [弧度], [$0$], [$pi/6$], [$pi/4$], [$pi/3$], [$pi/2$], [$(2pi)/3$], [$(3pi)/4$], [$(5pi)/6$], [$pi$],
  [$sin$], [$0$], [$1/2$], [$sqrt(2)/2$], [$sqrt(3)/2$], [$1$], [$sqrt(3)/2$], [$sqrt(2)/2$], [$1/2$], [$0$],
  [$cos$], [$1$], [$sqrt(3)/2$], [$sqrt(2)/2$], [$1/2$], [$0$], [$-1/2$], [$-sqrt(2)/2$], [$-sqrt(3)/2$], [$-1$],
  [$tan$], [$0$], [$sqrt(3)/3$], [$1$], [$sqrt(3)$], [---], [$-sqrt(3)$], [$-1$], [$-sqrt(3)/3$], [$0$],
)

#example(
  question: [
    【2023 重庆南开中学月考】(多选) 已知角 $alpha$ 是第二象限角，则下列不等式一定成立的是（#h(3em)）
  ],
  choices: choices22(
    [$sin alpha/2 < 0$],
    [$tan alpha/2 > 0$],
    [$sin alpha/2 > cos alpha/2$],
    [$|sin alpha/2| > |cos alpha/2|$],
  ),
  answer: [#tab *BD*],
)

#example(
  question: [
    【2023江苏扬州高一期末】已知角 $alpha$ 的终边经过点 $(m, -5)$，$cos alpha = 12/13$，则 $tan alpha =$（#h(3em)）
  ],
  choices: choices14(
    [$plus.minus 12/5$],
    [$plus.minus 5/12$],
    [$-5/12$],
    [$-12/5$],
  ),
  answer: [#tab *C*],
)

= 三角诱导公式

#introduction[同角公式][和差公式][倍/半角公式][辅助角公式][万能公式][积化和差/和差化积][特殊形式][小结]

== 同角公式

#method("基本公式")[
  $ sin^2 alpha + cos^2 alpha = 1, quad 1 + tan^2 alpha = 1/(cos^2 alpha), quad 1 + cot^2 alpha = 1/(sin^2 alpha) $
  $ (sin alpha + cos alpha)^2 = 1 + 2 sin alpha cos alpha $
  $ (sin alpha - cos alpha)^2 = 1 - 2 sin alpha cos alpha $
]

#method("诱导公式")[
  - *口诀*：奇变偶不变，符号看象限。
  $ sin(alpha + 2k pi) = sin alpha, quad cos(alpha + 2k pi) = cos alpha, quad tan(alpha + k pi) = tan alpha $
  $ sin(-alpha) = -sin alpha, quad cos(-alpha) = cos alpha, quad tan(-alpha) = -tan alpha $
  $ sin(pi + alpha) = -sin alpha, quad cos(pi + alpha) = -cos alpha, quad tan(pi + alpha) = tan alpha $
  $ sin(pi - alpha) = sin alpha, quad cos(pi - alpha) = -cos alpha, quad tan(pi - alpha) = -tan alpha $
  $ sin(pi/2 + alpha) = cos alpha, quad cos(pi/2 + alpha) = -sin alpha $
  $ sin(pi/2 - alpha) = cos alpha, quad cos(pi/2 - alpha) = sin alpha $
]

#example(
  question: [
    【2023天津南开中学高一期末】已知 $P(1, 3)$ 为角 $alpha$ 终边上一点，则 $display((2 sin alpha - cos alpha)/(sin alpha + 2 cos alpha)) =$（#h(3em)）
  ],
  choices: choices14(
    [$-7$],
    [$1$],
    [$2$],
    [$3$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2022黑龙江哈尔滨一中期末】若 $sin((3pi)/2 - alpha) + cos(pi - alpha) = sin alpha$，则 $2 sin^2 alpha - sin alpha cos alpha$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$21/10$],
    [$3/2$],
    [$sqrt(3)/2$],
    [$2$],
  ),
  answer: [#tab *D*],
)

#think[
  1. 上述题目除了求解 $sin alpha$ 和 $cos alpha$ 代入（方法一），还有其他解法（方法二）吗？
  2. 方法二使你联想到以前学过的哪个类似方法？
]

#example(
  question: [
    【2023 湖北重点高中协作校高一期末】若 $sin alpha + cos alpha = 7/13 (0 < alpha < pi)$，则 $tan alpha =$（#h(3em)）
  ],
  choices: choices14(
    [$-12/5$],
    [$-5/12$],
    [$5/12$],
    [$12/5$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2020湖南师大附中】已知 $tan alpha = 3$，则 $display((1 + 2 sin alpha cos alpha)/(sin^2 alpha - cos^2 alpha))$ 的值是（#h(3em)）
  ],
  choices: choices14(
    [$1/2$],
    [$-1/2$],
    [$2$],
    [$5$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2023 山东济南期中】已知 $theta$ 为第三象限角，$sin theta - cos theta = -1/5$，则 $display((cos theta(1 - 2 sin^2 theta))/(sin theta + cos theta)) =$（#h(3em)）
  ],
  choices: choices14(
    [$-4/25$],
    [$-3/25$],
    [$3/25$],
    [$4/25$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2023 广东茂名高一期末】若 $sin x + cos x = 1/3, x in (-pi/2, pi/2)$，则 $sin x - cos x$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$plus.minus sqrt(17)/3$],
    [$sqrt(17)/3$],
    [$-sqrt(17)/3$],
    [$1/3$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2023 山东临沂高一期末】若 $theta in (0, pi)$，$tan theta + 1/tan theta = 4$，则 $sin theta + cos theta =$（#h(3em)）
  ],
  choices: choices14(
    [$display((2sqrt(3))/3)$],
    [$display(plus.minus (2sqrt(3))/3)$],
    [$plus.minus sqrt(6)/2$],
    [$sqrt(6)/2$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2025北京6年高考3年模拟改编】若 $sin theta, cos theta$ 是方程 $4x^2 + 2m x + m = 0$ 的两根，则 $m$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$1 + sqrt(5)$],
    [$1 - sqrt(5)$],
    [$1 plus.minus sqrt(5)$],
    [$-1 - sqrt(5)$],
  ),
  answer: [#tab *B*],
)

#show-answers()
