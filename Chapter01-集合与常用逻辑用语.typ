#import "template/lib.typ": *
#import "@preview/cetz:0.4.2": canvas, draw
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
  cover: image("image/cover.jpg", width: 100%),
  title: [第一章],
  subtitle: [集合与常用逻辑用语],
  author: [zheliku],
  date: datetime.today().display(),
  version: version(1, 0, 0),
  // other: (自定义: "信息"),
)
#default-outline()

// ==================== 配置答案显示模式 ====================
// 选项1：答案紧跟在例题后面
// #set-answer-mode("inline")

// 选项2：答案显示在文档末尾（默认）
#set-answer-mode("end")

#let introduction = introduction.with(color: color-select("blue").structure)


#set raw(lang: "typst")

// ----------------------正文开始-----------------------
= 集合

#introduction[集合定义][集合特性][集合的表示方法][常用数集符号]

== 概念

#definition[（集合）][我们把研究对象统称为*元素*， 一些元素组成的总体叫做*集合*。]

+ 元素用小写字母表示，集合用大写字母表示。
+ 如果元素 $a$ 属于集合 $A$，则表示为 $a in A$；
+ 如果元素 $a$ 不属于集合 $A$，则表示为 $a in.not A$。
+ 集合的元素个数可以是无限个。按照元素个数，可将集合分为2类：
  - 有限集。
  - 无限集。

== 特性
+ 确定性
  - 集合中的元素是确定的，任何人都能判断某个元素是否属于该集合。
+ 无序性
  - 集合中元素的排列顺序不影响集合本身。
+ 互异性
  - 集合中不能有重复的元素。

#example(
  question: [
    【223四川南充高一月考】已知 $a、b$ 为实数，若集合 $display(A={a, b/a, 1})$ 与集合 $B={a^2, a+b ,0}$ 相同，则下列说法正确的是(#h(3em))
  ],
  choices: choices22(
    [$a+b=1$],
    [$a、b$ 可以是任意值],
    [集合 $A$ 与集合 $B$ 元素个数一定均为 3],
    [以上说法均不正确],
  ),
  answer: [
    *C*

    解析：因为集合 $A$ 与集合 $B$ 相同，且集合 $A$ 中有 3 个不同元素，故集合 $B$ 中也有 3 个不同元素， 即 $a^2、a+b、0$ 均不相等， 从而可得 $a^2 eq.not 0$， 即 $a eq.not 0$； 又因为 $a^2 eq.not a+b$， 故 $a^2 - a - b eq.not 0$， 即 $b eq.not a^2 - a$； 又因为 $a+b eq.not 0$， 故 $b eq.not -a$。 综上所述，选项 C 正确。
  ],
)

== 表示方法

若 $1 lt.eq x lt 6$ 且 $x$ 为整数：
+ 例举法：${1,2,3,4,5}$
+ 描述法：${x|1 lt.eq x < 6,x in N}$ 或 ${x in N|1 lt.eq x < 6}$
+ 图示法
  - #link(<Venn图>)[Venn 图]
  - #link(<数轴表示法>)[数轴表示法]

#think[
  (1) $a$ 和 ${a}$ 是否一样？

  (2) 平面中的一点 $(1,4)$ 可以用 ${x=1,y=4}$ 表示吗？
]

== 常用数集符号
#align(center)[
  #table(
    columns: (1fr, 1fr),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    // row-gutter: 5em,
    table.hline(),
    table.header([数集], [符号]),
    table.hline(stroke: 0.5pt),
    [自然数集], [$bb(N)={0,1,2,3,...}$],
    [正整数集], [$bb(N)^+ (bb(N)^*)={1,2,3,...}$],
    [整数集], [$bb(Z)={..., -2,-1,0,1,2,...}$],
    [有理数集], [$bb(Q)=display({p/q|p,q in bb(Z),q eq.not 0})$],
    [实数集], [$bb(R)$],
    table.hline(stroke: 0.5pt),
  )
]

#pagebreak()

= 集合的基本关系
#introduction[Venn 图][集合间的关系][特殊集合：空集][数轴表示法][区间]
== Venn 图 <Venn图>
#grid(
  columns: (1fr, auto),
  column-gutter: 1em,
  align: (left, center),
  [
    韦恩（Venn）图表示集合之间的包含/非包含关系。以右图为例：
    - A表示全集，包含所有其他集合。
    - 集合B和集合C的共有部分为集合D。
  ],

  // venn2()

  canvas({
    import draw: *
    venn2(
      xy-scale: (1, 0.7),
      ab-text: text(size: 12pt, [C]),
      rect-text: text(size: 12pt, [D]),
    )
  }),
)

== 集合间的关系
#align(center)[
  #table(
    columns: (auto, auto, auto, auto),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    // row-gutter: 0.2em,
    table.hline(),
    table.header([符号], [读法], [关系], [说明]),
    table.hline(stroke: 0.5pt),
    [$A subset.eq B$], [$A$ 包含于 $B$], [$A$ 是 $B$ 的子集], [集合 $A$ 中的元素全部都在集合 $B$ 中],
    [$A = B$], [$A$ 等于 $B$], [集合 $A$ 与集合 $B$ 相等], [集合 $A$ 与集合 $B$ 中的元素完全相同],
    [$A subset.not.eq B$], [$A$ 不包含于 $B$], [$A$ 不是 $B$ 的子集], [集合 $A$ 中至少有一个元素不在集合 $B$ 中],
    table.hline(stroke: 0.5pt),
  )
]

#example(
  question: [
    已知集合 $A＝{1,2,{1,2,3},{1,2},3,4},B＝{1,2},C＝{1,2,4}$。则下列说法正确的是（#h(3em)）
  ],
  choices: choices22(
    [$B in A，C in A$],
    [${3,4} in A，B subset.eq A$],
    [$C subset.eq A，{1,2,3} in A$],
    [$C in A，{1,2,3,4} subset.eq A$],
  ),
  answer: [
    *C*

    解析：集合 $A$ 的元素有 $1,2,{1,2,3},{1,2},3,4$，所以 $C subset.eq A$，${1,2,3} in A$。选项 C 正确。
  ],
)

== 空集
#definition[（空集）][不包含任何元素的集合称为*空集*。记作 $emptyset$ 或 ${}$.]

+ 空集是任何集合的子集。
+ 空集是任何非空集合的真子集。
+ 空集只有一个子集，即其自己。

#think[
  $emptyset、0、{0}、{emptyset}$ 之间的关系？
]

== 有限集合的子集个数
#align(center)[
  #table(
    columns: (1fr, 5fr, 1fr, 1fr, 1fr),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    table.hline(),
    table.header([集合], [子集], [子集个数], [真子集个数], [非空真子集个数]),
    table.hline(stroke: 0.5pt),
    [${a}$], [${emptyset}$、${a}$], [2], [1], [0],
    [${a,b}$], [${emptyset}$、${a}$、${b}$、${a,b}$], [4], [3], [2],
    [${a,b,c}$], [${emptyset}$、${a}$、${b}$、${a,b}$、${c}$、${a,c}$、${b,c}$、${a,b,c}$], [8], [7], [6],
    [$...$], [$...$], [$...$], [$...$], [$...$],
    [${a_1,a_2,dots.c,a_n}$], [$...$], [$2^n$], [$2^n-1$], [$2^n-2$],
    table.hline(stroke: 0.5pt),
  )
]
#example(
  question: [
    已知集合 $M = \{1,2,3,4\}, P = \{(x,y) | x in M, y in M, x - y in M\}$。则 $P$ 的非空子集的个数为 #blank()。
  ],
  answer: [
    *63*

    解析：集合 $M$ 有 4 个元素，则集合 $P$ 为 ${(4,3), (4,2), (4,1), (3,2), (3,1), (2,1)}$。因此集合 $P$ 有 6 个元素，其非空子集的个数为 $2^6-1=63$。
  ],
)

== 数轴表示法 <数轴表示法>
对于由连续实数组成的集合，通常用数轴来表示，这也属于集合表示的图示法。在数轴上
- 若端点值是集合中的元素，则用实心点表示；
- 若端点值不是集合中的元素，则用空心点表示。

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  align: center,
  // 左图：区间(-1,5]
  canvas({
    interval-line(start: -1, end: 5, lines: (
      (
        start: (index: -1, open: true, inf: false),
        end: (index: 5, open: false, inf: false),
        stroke: (thickness: 1pt, paint: blue),
      ),
    ))
  }),

  // 右图：区间[3,+∞)
  canvas({
    interval-line(start: 3, end: 8, lines: (
      (
        start: (index: 3, open: false, inf: false),
        end: (index: 9, open: true, inf: true),
        stroke: (thickness: 1pt, paint: blue),
      ),
    ))
  }),
)

左图表示集合 ${x|−1<x≤5}$，右图表示集合 ${x|x≥3}$。

使用数轴表示集合间的关系：


#grid(
  columns: (1fr,),
  align: center,
  canvas({
    interval-line(start: 0, end: 6, lines: (
      (
        start: (index: 0, open: true, inf: true),
        end: (index: 3, open: false, inf: false),
        stroke: (thickness: 1pt, paint: red),
      ),
      (
        start: (index: 0, open: true, inf: true),
        end: (index: 5, open: false, inf: false),
        stroke: (thickness: 1pt, paint: blue),
      ),
    ))
  }),
)

== 区间
#definition[（区间）][数轴某一段上所有点对应的所有#underline[连续实数]组成的集合，称为*区间*。]

#align(center)[
  #table(
    columns: (1fr, 1fr, 1fr, 1fr),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    table.hline(),
    table.header([集合], [读法], [符号], [数轴表示]),
    table.hline(stroke: 0.5pt),
    [${x|a<x<b}$], [开区间], [$(a,b)$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: true, inf: false),
            end: (index: 1, open: true, inf: false),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ($a$, $b$),
      )
    }),
    [${x|a lt.eq x lt.eq b}$], [闭区间], [$[a,b]$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: false, inf: false),
            end: (index: 1, open: false, inf: false),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ($a$, $b$),
      )
    }),
    [${x|a<x lt.eq b}$], [左开右闭区间], [$(a,b]$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: true, inf: false),
            end: (index: 1, open: false, inf: false),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ($a$, $b$),
      )
    }),
    [${x|a lt.eq x<b}$], [左闭右开区间], [$[a,b)$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: false, inf: false),
            end: (index: 1, open: true, inf: false),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ($a$, $b$),
      )
    }),
    table.hline(stroke: 0.5pt),
  )
]

- 实数 $a$ 与 $b$ 都叫做相应区间的端点。
- 用实心点表示包括在区间内的端点，用空心点表示不包括在区间内的端点。
- 区间的左端点 $a$ 必须小于区间的右端点 $b$。
- $b-a$ 称为区间的长度。

#align(center)[
  #table(
    columns: (1fr, 1fr, 1fr),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    table.hline(),
    table.header([集合], [符号], [数轴表示]),
    table.hline(stroke: 0.5pt),
    [${x|x in bb(R)}$], [$(−∞,+∞)$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: true, inf: true),
            end: (index: 1, open: true, inf: true),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ("", ""),
      )
      draw.content((1.5, -0.3), text(size: 12pt, $bb(R)$))
    }),
    [${x|x gt.eq a}$], [$[a,+∞)$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: false, inf: false),
            end: (index: 1, open: true, inf: true),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ($a$, ""),
      )
    }),
    [${x|x>a}$], [$(a,+∞)$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: true, inf: false),
            end: (index: 1, open: true, inf: true),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ($a$, ""),
      )
    }),
    [${x|x lt.eq b}$], [$(−∞,b]$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: true, inf: true),
            end: (index: 1, open: false, inf: false),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ("", $b$),
      )
    }),
    [${x|x<b}$], [$(−∞,b)$],
    canvas({
      interval-line(
        height: 0.3cm,
        show-interval-labels: false,
        lines: (
          (
            start: (index: 0, open: true, inf: true),
            end: (index: 1, open: true, inf: false),
            stroke: (thickness: 1pt, paint: blue),
          ),
        ),
        unit-scale: 2,
        axis-labels: ("", $b$),
      )
    }),
    table.hline(stroke: 0.5pt),
  )
]

#pagebreak()

= 集合的基本运算
#introduction[交集与并集][全集与补集][德 $bullet$ 摩根定律][容斥原理]

== 交集与并集
#align(center)[
  #table(
    columns: (1fr, 2fr, 1fr, 1.2fr),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    table.hline(),
    table.header([运算], [描述], [符号], [图示]),
    table.hline(stroke: 0.5pt),
    [交集],
    [由所有属于集合 $A$ 且属于集合 $B$ 的元素组成的集合],
    [$A inter B$],
    canvas({
      venn2(
        xy-scale: (0.8, 0.6),
        a-fill: white,
        b-fill: white,
        ab-fill: blue.lighten(80%),
        rect-fill: white,
        ab-text: text(size: 8pt, [A $inter$ B], fill: red),
        rect-text: none,
      )
    }),

    [并集],
    [由所有属于集合 $A$ 或属于集合 $B$ 的元素组成的集合],
    [$A union B$],
    canvas({
      venn2(
        xy-scale: (0.8, 0.6),
        rect-fill: white,
        rect-text: none,
      )

      // 标注并集区域
      draw.content((0, -1.2), text(size: 8pt, fill: red, $A union B$))
    }),

    table.hline(stroke: 0.5pt),
  )
]

== 全集与补集
#grid(
  columns: (4fr, 1fr),
  column-gutter: 1em,
  align: (left, right),
  [
    - 全集U：研究问题中涉及的所有元素的集合。
    - 集合A的补集：全集U中不属于集合A的元素组成的集合，符号表示为：
  ],
  canvas({
    // 绘制矩形 U (全集)

    draw.rect((0, 0), (3, 1.8), stroke: gray, fill: rgb(173, 216, 230, 100), name: "U")

    // 绘制圆 A
    draw.circle((1.5, 1), radius: (0.7, 0.5), stroke: blue, fill: white, name: "A")

    // 标注全集 U
    draw.content((2.7, 1.5), text(size: 10pt, $U$))

    // 标注集合 A
    draw.content((1.5, 1), text(size: 10pt, $A$))

    // 标注补集区域
    draw.content((0.5, 0.3), text(size: 9pt, fill: red, $complement_U A$))
  }),
)
$ complement_U A = {x|x in U, x in.not A} $


#example(
  question: [
    【2017课标全国Ⅰ】已知集合 $A = {x | x < 1}, B = {x | 3^x < 1}$。则（#h(3em)）
  ],
  choices: choices22(
    [$A inter B = {x | x < 0}$],
    [$A union B = bb(R)$],
    [$A union B = {x | x > 1}$],
    [$A inter B = emptyset$],
  ),
  answer: [
    *A*

    解析：$3^x < 1 => x < 0$，所以 $B = {x | x < 0}$。因为 $A = {x | x < 1}$，所以 $A inter B = {x | x < 0}$。
  ],
)

#example(
  question: [
    【2018课标全国Ⅰ】已知集合 $A = {x | x^2 - x - 2 > 0}$。则 $complement_bb(R) A =$（#h(3em)）
  ],
  choices: choices22(
    [${x | -1 < x < 2}$],
    [${x | -1 lt.eq x lt.eq 2}$],
    [${x | x < -1} union {x | x > 2}$],
    [${x | x lt.eq -1} union {x | x gt.eq 2}$],
  ),
  answer: [
    *B*

    解析：$x^2 - x - 2 > 0 => (x-2)(x+1) > 0 => x < -1$ 或 $x > 2$，所以 $A = {x | x < -1} union {x | x > 2}$。因此 $complement_bb(R) A = {x | -1 lt.eq x lt.eq 2}$。
  ],
)

== 德 $bullet$ 摩根定律
#definition[（德 $bullet$ 摩根定律）][设 $A$ 和 $B$ 是全集 $U$ 的子集，则有：
  $
    complement_U (A inter B) = complement_U A union complement_U B
  $
  $
    complement_U (A union B) = complement_U A inter complement_U B
  $
]

#grid(
  columns: (1fr, 2fr),
  column-gutter: 2em,
  align: center,
  row-gutter: 1em,

  // 第一个公式的图示
  canvas({
    import draw: *

    venn2(
      xy-scale: (1, 0.7),
      a-fill: none,
      b-fill: none,
      ab-fill: blue.lighten(80%),
    )

    draw.content((0, -1.5), text(size: 12pt, $A inter B$))
    draw.content((0, -2.2), text(size: 18pt, $arrow.b.double$))

    translate(x: 0, y: -3.8)

    venn2(
      xy-scale: (1, 0.7),
      a-fill: blue.lighten(80%),
      b-fill: blue.lighten(80%),
      ab-fill: white,
      rect-fill: blue.lighten(80%),
    )

    draw.content((0, -1.5), text(size: 12pt, $complement_U (A inter B)$))
  }),

  canvas({
    import draw: *

    translate(x: 0, y: 0)

    venn2(
      xy-scale: (1, 0.7),
      a-fill: white,
      b-fill: blue.lighten(80%),
      ab-fill: white,
      rect-fill: blue.lighten(80%),
    )

    draw.content((0, -1.5), text(size: 12pt, $complement_U A$))

    translate(x: 4.5, y: 0)

    venn2(
      xy-scale: (1, 0.7),
      a-fill: blue.lighten(80%),
      b-fill: white,
      ab-fill: white,
      rect-fill: blue.lighten(80%),
    )

    draw.content((0, -1.5), text(size: 12pt, $complement_U B$))

    translate(x: -2.25, y: 0)

    draw.content((0, -2.2), text(size: 18pt, $arrow.b.double$))

    translate(x: 0, y: -3.8)

    venn2(
      xy-scale: (1, 0.7),
      a-fill: blue.lighten(80%),
      b-fill: blue.lighten(80%),
      ab-fill: white,
      rect-fill: blue.lighten(80%),
    )

    draw.content((0, -1.5), text(size: 12pt, $(complement_U A) union (complement_U B)$))
  }),
)

== 容斥原理
#definition[（容斥原理）][设 $A$ 和 $B$ 是全集 $U$ 的子集，$|A|$ 表示集合 $A$ 的元素个数，则有：
  $
    |A union B| = |A| + |B| - |A inter B|
  $
  $
    |A union B union C| = & |A| + |B| + |C| \
                          & - |A inter B| - |A inter C| - |B inter C| \
                          & + |A inter B inter C|
  $
]

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  align: center,
  row-gutter: 1em,

  // 第一个公式的图示
  canvas({
    venn2(
      xy-scale: (1.5, 1),
      a-fill: none,
      b-fill: none,
      rect-style: none,
      rect-text: none,
      ab-text: text(size: 12pt, [A $inter$ B]),
    )

    draw.content((0, -3.35), text(size: 12pt, [(3.4)]))
  }),

  canvas({
    import "@preview/cetz-venn:0.1.4": venn3

    draw.scale(1.35)

    draw.translate(x: 0, y: 0)

    venn3(
      name: "venn3",
      not-abc-stroke: none,
      padding: (0.0, 0.0),
    )

    draw.content("venn3.a", text(size: 12pt, [A]))
    draw.content("venn3.b", text(size: 12pt, [B]))
    draw.content("venn3.c", text(size: 12pt, [C]))
    draw.content("venn3.ab", text(size: 10pt, [A $inter$ B]))
    draw.content("venn3.ac", text(size: 10pt, [A $inter$ C]))
    draw.content("venn3.bc", text(size: 10pt, [B $inter$ C]))
    draw.content("venn3.abc", text(size: 8pt, [A $inter$ B $inter$ C]))


    draw.content((0, -2.2), text(size: 12pt, [(3.5)]))
  }),
)

#example(
  question: [
    【2023辽宁省实验中学高一月考】（多选）某校高一年级组织趣味运动会，有跳远、球类、跑步三项比赛，一共有 28 人参加比赛，其中有 16 人参加跳远比赛，有 8 人参加球类比赛，有 14 人参加跑步比赛，同时参加跳远和球类比赛的有 3 人，同时参加球类和跑步比赛的有 3 人，没有人同时参加三项比赛，则（#h(3em)）
  ],
  choices: choices22(
    [同时参加跳远和跑步比赛的有 4 人],
    [仅参加跳远比赛的有 8 人],
    [仅参加跑步比赛的有 7 人],
    [同时参加两项比赛的有 10 人],
  ),
  answer: [
    *ACD*

    解析：设同时参加跳远和跑步比赛的有 $x$ 人。根据容斥原理：
    $
      |A union B union C| = |A| + |B| + |C| - |A inter B| - |A inter C| - |B inter C| + |A inter B inter C|
    $
    代入数据：
    $
      28 = 16 + 8 + 14 - 3 - x - 3 + 0
    $
    解得 $x = 4$，即同时参加跳远和跑步比赛的有 4 人，A 正确。

    仅参加跳远比赛的人数为：$16 - 3 - 4 = 9$ 人，B 错误。

    仅参加跑步比赛的人数为：$14 - 4 - 3 = 7$ 人，C 正确。

    同时参加两项比赛的人数为：$3 + 4 + 3 = 10$ 人，D 正确。

    因此选择 C。
  ],
)

#pagebreak()

= 命题与条件
#introduction[命题的判断][充分条件与必要条件][四种命题]

== 命题的判断

#definition[（命题）][我们把可以判断真假的陈述句，叫做*命题*。其中判断为真的陈述句叫做*真命题*，判断为假的陈述句叫做*假命题*。]

+ 命题可以写成“若 $p$，则 $q$”、“如果 $p$，那么 $q$”的形式。
+ $p$ 为命题的条件，$q$ 为命题的结论。

#think[
  找出下列命题的 $p$ 和 $q$：
  1. 小明吃过饭了。
  2. 今天是星期五。
  3. 这个苹果很好吃。
]

== 充分条件与必要条件

如果“若 $p$，则 $q$"为真命题，则表示 $p$ 通过推理可以得出 $q$，记为
$ p arrow.r.double q $
此时，$p$ 是 $q$ 的充分条件。$q$ 是 $p$ 的必要条件。

可将 $p$ 的取值集合记为 $A$，$q$ 的取值集合记为 $B$，用韦恩图表示:


#align(center)[
  #canvas({
    venn2(
      xy-scale: (1.5, 1),
      a-pos: (0, 0),
      b-pos: (0, 0),
      a-radius: 0.5,
      b-radius: 1,
      a-fill: none,
      b-fill: none,
      rect-style: none,
      rect-text: none,
      b-text: none,
    )

    draw.content((1.1, 0), text(size: 12pt, [B]))
  })
]

可利用韦恩图表示为下面 3 种情况：$p$ 的外延和 $q$ 的外延成包含关系。

#align(center)[
  #table(
    columns: (1fr, 1fr, 1.5fr),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    table.hline(),
    table.header([关系], [韦恩图], [充分必要性]),
    table.hline(stroke: 0.5pt),

    [$p => q$],
    canvas({
      venn2(
        xy-scale: (0.8, 0.6),
        a-pos: (0, 0),
        b-pos: (0, 0),
        a-radius: 1.2,
        b-radius: 0.7,
        a-fill: blue.lighten(90%),
        b-fill: red.lighten(80%),
        ab-fill: red.lighten(80%),
        rect-fill: none,
        a-text: text(size: 10pt, $A$),
        b-text: none,
        rect-text: none,
        rect-style: none,
      )

      draw.content((0.75, 0), text(size: 10pt, $B$))
    }),
    [
      $p$ 是 $q$ 的充分不必要条件

      $q$ 是 $p$ 的必要不充分条件
    ],

    [$p <==> q$],
    canvas({
      venn2(
        xy-scale: (0.8, 0.6),
        a-pos: (0, 0),
        b-pos: (0, 0),
        a-radius: 1,
        b-radius: 1,
        a-fill: purple.lighten(90%),
        b-fill: purple.lighten(90%),
        ab-fill: purple.lighten(90%),
        rect-fill: none,
        a-text: text(size: 10pt, $A(B)$),
        b-text: none,
        rect-text: none,
        rect-style: none,
      )
    }),
    [
      $p$ 是 $q$ 的充要条件
    ],

    [$p arrow.r.not.double q$],
    canvas({
      venn2(
        xy-scale: (0.8, 0.6),
        a-pos: (-0.8, 0),
        b-pos: (0.8, 0),
        a-radius: 0.7,
        b-radius: 0.7,
        a-fill: red.lighten(80%),
        b-fill: blue.lighten(90%),
        rect-fill: none,
        a-text: text(size: 10pt, $A$),
        b-text: text(size: 10pt, $B$),
        rect-text: none,
      )
    }),
    [
      $p$ 既不是 $q$ 的充分条件

      也不是 $q$ 的必要条件
    ],

    [$p$ 是 $q$ 的非充分

      非必要条件],
    canvas({
      venn2(
        xy-scale: (0.8, 0.6),
        a-pos: (-0.4, 0),
        b-pos: (0.4, 0),
        a-radius: 0.8,
        b-radius: 0.8,
        a-fill: red.lighten(80%),
        b-fill: blue.lighten(90%),
        ab-fill: purple.lighten(90%),
        rect-fill: none,
        a-text: text(size: 10pt, $A$),
        b-text: text(size: 10pt, $B$),
        rect-text: none,
      )
    }),
    [
      $p$ 与 $q$ 有交集但互不包含
    ],

    table.hline(stroke: 0.5pt),
  )
]

#example(
  question: [

    (1) $x > 1$ 是 $x^2 > 1$ 的 #blank()。

    (2) $a b > 0$ 是 $a > 0、b > 0$ 的 #blank()。

    (3) $x^4 lt.eq 0$ 是 $x = 0$ 的 #blank()。
  ],
  answer: [
    *(1) 充分不必要条件*

    解析：$x > 1 => x^2 > 1$，但 $x^2 > 1$ 不能推出 $x > 1$（反例：$x = -2$），所以 "$x > 1$" 是 "$x^2 > 1$" 的充分不必要条件。

    *(2) 必要不充分条件*

    解析：$a > 0、b > 0 => a b > 0$，但 $a b > 0$ 不能推出 $a > 0、b > 0$（反例：$a = -1, b = -1$），所以 "$a b > 0$" 是 "$a > 0、b > 0$" 的必要不充分条件。

    *(3) 充要条件*

    解析：$x = 0 => x^4 = 0 lt.eq 0$，且 $x^4 lt.eq 0 => x^4 = 0 => x = 0$，所以 "$x^4 lt.eq 0$" 是 "$x = 0$" 的充要条件。
  ],
)

== 四种命题

#align(center)[
  #table(
    columns: (1fr, 1fr),
    stroke: none,
    align: (center, center),
    inset: 0.5em,
    table.hline(),
    table.header([名称], [形式]),
    table.hline(stroke: 0.5pt),
    [原命题], [若 $p$，则 $q$],
    [逆命题], [若 $q$，则 $p$],
    [否命题], [若 $not p$，则 $not q$],
    [逆否命题], [若 $not q$，则 $not p$],
    table.hline(stroke: 0.5pt),
  )
]

+ $p$ 是原命题的条件，$q$ 是原命题的结论；
+ $not p$ 表示 $p$ 的否定；
+ 任意命题都有逆命题、否命题和逆否命题。
+ 原命题与逆否命题同真同假，互为逆否命题。
+ 否命题与原命题真假性没有关系。
+ 逆命题与原命题真假性没有关系。

#grid(
  columns: (1fr,),
  align: center,
  canvas({
    import draw: *

    // 绘制四个方框
    let box-width = 3
    let box-height = 1.5
    let gap-x = 2
    let gap-y = 1.5

    let text-offset = (0.3, 0.3)
    let line-offset = (0.1, 0.1)

    // 计算各个方框的中心点
    let left-x = -gap-x / 2
    let right-x = gap-x / 2 + box-width / 2
    let top-y = gap-y / 2 + box-height / 2
    let bottom-y = -gap-y / 2 - box-height / 2

    // 原命题（左上）
    rect(
      (-box-width - gap-x / 2, gap-y / 2 + box-height),
      (-gap-x / 2, gap-y / 2),
      stroke: blue,
      fill: blue.lighten(95%),
      name: "original",
    )

    content(
      "original",
      align(center, text(size: 10pt, [原命题 \ 若 $p$，则 $q$])),
      anchor: "center",
    )

    // 逆命题（右上）
    rect(
      (gap-x / 2, gap-y / 2),
      (gap-x / 2 + box-width, gap-y / 2 + box-height),
      stroke: blue,
      fill: blue.lighten(95%),
      name: "inverse",
    )
    content(
      "inverse",
      align(center, text(size: 10pt, [逆命题 \ 若 $q$，则 $p$])),
      anchor: "center",
    )

    // 否命题（左下）
    rect(
      (-box-width - gap-x / 2, -gap-y / 2 - box-height),
      (-box-width - gap-x / 2 + box-width, -gap-y / 2),
      stroke: blue,
      fill: blue.lighten(95%),
      name: "negation",
    )
    content(
      "negation",
      align(center, text(size: 10pt, [否命题 \ 若 $not p$，则 $not q$])),
      anchor: "center",
    )

    // 逆否命题（右下）
    rect(
      (gap-x / 2, -gap-y / 2 - box-height),
      (gap-x / 2 + box-width, -gap-y / 2),
      stroke: blue,
      fill: blue.lighten(95%),
      name: "contrapositive",
    )
    content(
      "contrapositive",
      align(center, text(size: 10pt, [逆否命题 \ 若 $not q$，则 $not p$])),
      anchor: "center",
    )

    // 绘制箭头和标注
    // 原命题 <-> 逆命题（互逆）
    line(
      (-gap-x / 2 + line-offset.at(0), top-y),
      (right-x - box-width / 2 - line-offset.at(0), top-y),
      mark: (start: ">", end: ">"),
      stroke: red,
    )
    content(
      (0, top-y + text-offset.at(1)),
      text(size: 9pt, fill: red, [互逆]),
    )

    // 否命题 <-> 逆否命题（互逆）
    line(
      (-gap-x / 2 + line-offset.at(0), -top-y),
      (right-x - box-width / 2 - line-offset.at(0), -top-y),
      mark: (start: ">", end: ">"),
      stroke: red,
      name: "negation-inverse",
    )
    content(
      (0, bottom-y - text-offset.at(1)),
      text(size: 9pt, fill: red, [互逆]),
    )

    // 原命题 <-> 否命题（互否）
    line(
      (-gap-x / 2 - box-width / 2, -gap-y / 2 + line-offset.at(1)),
      (-gap-x / 2 - box-width / 2, gap-y / 2 - line-offset.at(1)),
      mark: (start: ">", end: ">"),
      stroke: green.darken(20%),
    )
    content(
      (-gap-x / 2 - box-width / 2 - text-offset.at(0), 0),
      text(size: 9pt, fill: green.darken(20%), [互否]),
      anchor: "east",
    )

    // 逆命题 <-> 逆否命题（互否）
    line(
      (gap-x / 2 + box-width / 2, -gap-y / 2 + line-offset.at(1)),
      (gap-x / 2 + box-width / 2, gap-y / 2 - line-offset.at(1)),
      mark: (start: ">", end: ">"),
      stroke: green.darken(20%),
    )
    content(
      (gap-x / 2 + box-width / 2 + text-offset.at(0), 0),
      text(size: 9pt, fill: green.darken(20%), [互否]),
      anchor: "west",
    )

    // 原命题 <-> 逆否命题（互为逆否）
    line(
      (-gap-x / 2 + line-offset.at(0), -gap-y / 2 + line-offset.at(1)),
      (gap-x / 2 - line-offset.at(0), gap-y / 2 - line-offset.at(1)),
      mark: (start: ">", end: ">"),
      stroke: purple,
    )
    content(
      (0, line-offset.at(1) * 5),
      text(size: 9pt, fill: purple, [逆否]),
    )

    // 逆命题 <-> 否命题（互为逆否）
    line(
      (gap-x / 2 - line-offset.at(0), -gap-y / 2 + line-offset.at(1)),
      (-gap-x / 2 + line-offset.at(0), gap-y / 2 - line-offset.at(1)),
      mark: (start: ">", end: ">"),
      stroke: purple,
    )
    content(
      (0, -line-offset.at(1) * 5),
      text(size: 9pt, fill: purple, [逆否]),
    )
  }),
)

#think[
  某食品的广告词为“幸福的人们都拥有”，那么不拥有的人们会不会幸福呢？

  A. 不一定幸福。

  B. 一定幸福。

  C. 一定不幸福。

  这说明了 #blank(width: 15em)。
]

#pagebreak()

= 全称量词与存在量词
#introduction[全称量词][存在量词][含有量词的命题的否定]

== 全称量词命题

+ 短语"所有"、"对一切" "任意一个"等在逻辑中称为*全称量词*。
+ 符号表示：$forall x, p(x)$
+ 含有全称量词的命题称为*全称量词命题*。

== 存在量词命题

+ 短语"存在"、"至少有一个"、"有些"等在逻辑中称为*存在量词*。
+ 符号表示：$exists x, p(x)$
+ 含有存在量词的命题称为*存在量词命题*。

#align(center)[
  #table(
    columns: (1.2fr, 1.5fr, 1.5fr),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    table.hline(),
    table.header([命题类型], [全称量词命题], [存在量词命题]),
    table.hline(stroke: 0.5pt),
    [形式], [$forall x in M, p(x)$], [$exists x in M, p(x)$],
    [否定形式], [$exists x in M, not p(x)$], [$forall x in M, not p(x)$],
    table.hline(stroke: 0.5pt),
  )
]

#example(
  question: [
    写出下列命题的否定，并判断其真假：

    （1）"$forall x in bb(R), x^2 - 2 x + 1 > 0$" 的否定是：#blank(width: 15em)。

    （2）"$exists c_0 > 0$，方程 $x^2 - x + c_0 = 0$" 的否定是：#blank(width: 15em)。
  ],
  answer: [
    （1）*$exists x in bb(R), x^2 - 2 x + 1 lt.eq 0$*

    解析：全称量词命题的否定是存在量词命题，且将结论否定。当 $x = 1$ 时，$x^2 - 2 x + 1 = 0$，所以否定命题为真。

    （2）*$forall c_0 > 0$，方程 $x^2 - x + c_0 = 0$ 无解*

    解析：存在量词命题的否定是全称量词命题，且将结论否定。原命题："存在 $c_0 > 0$，使得方程有解"，否定："对于所有 $c_0 > 0$，方程都无解"。
  ],
)

// #pagebreak()

// ==================== 在文档末尾显示所有答案 ====================
#show-answers()
