#import "template/lib.typ": *
#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cuti:0.3.0": show-cn-fakebold
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
  canvas({
    // import draw: *
    // 绘制矩形 A (全集)
    draw.rect((0, 0), (4, 2), name: "A")
    draw.content((3.7, 1.7), [A])

    // 绘制椭圆 B
    draw.circle((1.3, 1), radius: (1, 0.6), name: "B")
    draw.content((1.2, 1), [B])

    // 绘制椭圆 C
    draw.circle((2.7, 1), radius: (1, 0.6), name: "C")
    draw.content((2.8, 1), [C])

    // 标注相交区域 D
    draw.content((2, 1), [D])
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
    已知集合 $A＝{1,2,{1,2,3},{1,2},3,4},B＝{1,2},C＝{1,2,4}$。则下列说法正确的是（      ）
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
    // 绘制数轴
    draw.line((-2, 0), (6, 0), mark: (end: "stealth"))

    // 绘制刻度和标签
    for i in (-1, 0, 1, 2, 3, 4, 5) {
      draw.line((i, -0.1), (i, 0.1))
      draw.content((i, -0.4), text(size: 10pt, str(i)))
    }

    // 绘制区间 (-1, 5]
    draw.line((-1, 0.5), (5, 0.5), stroke: (thickness: 2pt, paint: blue))
    draw.line((-1, 0), (-1, 0.5), stroke: (thickness: 2pt, paint: blue))
    draw.line((5, 0), (5, 0.5), stroke: (thickness: 2pt, paint: blue))
    draw.circle((-1, 0), radius: 0.1, fill: white, stroke: blue) // 空心点
    draw.circle((5, 0), radius: 0.1, fill: blue) // 实心点

    draw.content((2, -1), text(size: 11pt, $(-1, 5]$))
  }),

  // 右图：区间[3,+∞)
  canvas({
    // 绘制数轴
    draw.line((-1, 0), (7, 0), mark: (end: "stealth"))

    // 绘制刻度和标签
    for i in (0, 1, 2, 3, 4, 5, 6) {
      draw.line((i, -0.1), (i, 0.1))
      draw.content((i, -0.4), text(size: 10pt, str(i)))
    }

    // 绘制区间 [3, +∞)
    draw.line((3, 0.5), (6.8, 0.5), stroke: (thickness: 2pt, paint: blue))
    draw.line((3, 0), (3, 0.5), stroke: (thickness: 2pt, paint: blue))
    draw.circle((3, 0), radius: 0.1, fill: blue) // 实心点

    draw.content((3, -1), text(size: 11pt, $[3, +infinity)$))
  }),
)

左图表示集合 ${x|−1<x≤5}$，右图表示集合 ${x|x≥3}$。

使用数轴表示集合间的关系：


#grid(
  columns: (1fr,),
  align: center,
  canvas({
    // 绘制数轴
    draw.line((-1, 0), (7, 0), mark: (end: "stealth"))

    // 绘制刻度和标签
    for i in (0, 1, 2, 3, 4, 5, 6) {
      draw.line((i, -0.1), (i, 0.1))
      draw.content((i, -0.4), text(size: 10pt, str(i)))
    }

    // 绘制区间 (-∞, 3] (上方)
    draw.line((0.2, 1), (3, 1), stroke: (thickness: 2pt, paint: red))
    draw.line((3, 0), (3, 1), stroke: (thickness: 2pt, paint: red))
    draw.circle((3, 0), radius: 0.1, fill: red) // 实心点
    draw.content((2, 1.4), text(size: 11pt, fill: red, $(-infinity, 3]$))

    // 绘制区间 (-∞, 5] (下方)
    draw.line((0.2, 0.5), (5, 0.5), stroke: (thickness: 2pt, paint: blue))
    draw.line((5, 0), (5, 0.5), stroke: (thickness: 2pt, paint: blue))
    draw.circle((5, 0), radius: 0.1, fill: blue) // 实心点
    draw.content((4.5, 1), text(size: 11pt, fill: blue, $(-infinity, 5]$))
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
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0, 0.3), (2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((0, 0), (0, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((2, 0), (2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.circle((0, 0), radius: 0.08, fill: white, stroke: blue)
      draw.circle((2, 0), radius: 0.08, fill: white, stroke: blue)
      draw.content((0, -0.3), text(size: 10pt, $a$))
      draw.content((2, -0.3), text(size: 10pt, $b$))
    }),
    [${x|a lt.eq x lt.eq b}$], [闭区间], [${[a,b]}$],
    canvas({
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0, 0.3), (2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((0, 0), (0, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((2, 0), (2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.circle((0, 0), radius: 0.08, fill: blue)
      draw.circle((2, 0), radius: 0.08, fill: blue)
      draw.content((0, -0.3), text(size: 10pt, $a$))
      draw.content((2, -0.3), text(size: 10pt, $b$))
    }),
    [${x|a<x lt.eq b}$], [左开右闭区间], [$(a,b]$],
    canvas({
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0, 0.3), (2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((0, 0), (0, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((2, 0), (2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.circle((0, 0), radius: 0.08, fill: white, stroke: blue)
      draw.circle((2, 0), radius: 0.08, fill: blue)
      draw.content((0, -0.3), text(size: 10pt, $a$))
      draw.content((2, -0.3), text(size: 10pt, $b$))
    }),
    [${x|a lt.eq x<b}$], [左闭右开区间], [${[a,b)}$],
    canvas({
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0, 0.3), (2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((0, 0), (0, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((2, 0), (2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.circle((0, 0), radius: 0.08, fill: blue)
      draw.circle((2, 0), radius: 0.08, fill: white, stroke: blue)
      draw.content((0, -0.3), text(size: 10pt, $a$))
      draw.content((2, -0.3), text(size: 10pt, $b$))
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
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0, 0.3), (2.2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.content((1.1, -0.3), text(size: 10pt, $bb(R)$))
    }),
    [${x|x gt.eq a}$], [$[a,+∞)$],
    canvas({
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0.5, 0.3), (2.2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((0.5, 0), (0.5, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.circle((0.5, 0), radius: 0.08, fill: blue)
      draw.content((0.5, -0.3), text(size: 10pt, $a$))
    }),
    [${x|x>a}$], [$(a,+∞)$],
    canvas({
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0.5, 0.3), (2.2, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((0.5, 0), (0.5, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.circle((0.5, 0), radius: 0.08, fill: white, stroke: blue)
      draw.content((0.5, -0.3), text(size: 10pt, $a$))
    }),
    [${x|x lt.eq b}$], [$(−∞,b]$],
    canvas({
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0.2, 0.3), (1.5, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((1.5, 0), (1.5, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.circle((1.5, 0), radius: 0.08, fill: blue)
      draw.content((1.5, -0.3), text(size: 10pt, $b$))
    }),
    [${x|x<b}$], [$(−∞,b)$],
    canvas({
      draw.line((-0.5, 0), (2.5, 0), mark: (end: "stealth"))
      draw.line((0.2, 0.3), (1.5, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.line((1.5, 0), (1.5, 0.3), stroke: (thickness: 2pt, paint: blue))
      draw.circle((1.5, 0), radius: 0.08, fill: white, stroke: blue)
      draw.content((1.5, -0.3), text(size: 10pt, $b$))
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
      // 绘制矩形 (全集)
      draw.rect((0, 0), (3, 2), stroke: gray)

      // 绘制两个相交的圆
      draw.circle((1, 1), radius: (0.8, 0.6), name: "A", fill: rgb(173, 216, 230, 100))
      draw.compound-path(
        {
          draw.circle((1, 1), radius: (0.8, 0.6), name: "A")
          draw.circle((2, 1), radius: (0.8, 0.6), name: "B")
        },
        fill-rule: "even-odd",
        // fill-rule: "non-zero",
        fill: white,
        stroke: blue,
      )

      // 标注集合名称
      draw.content((0.7, 1), text(size: 10pt, $A$))
      draw.content((2.3, 1), text(size: 10pt, $B$))

      // 标注交集区域
      draw.content((1.5, 1), text(size: 9pt, fill: red, $A inter B$))
    }),

    [并集],
    [由所有属于集合 $A$ 或属于集合 $B$ 的元素组成的集合],
    [$A union B$],
    canvas({
      // 绘制矩形 (全集)
      draw.rect((0, 0), (3, 2), stroke: gray)

      // 绘制两个相交的圆
      draw.circle((1, 1), radius: (0.8, 0.6), stroke: blue, fill: rgb(173, 216, 230, 100), name: "A")
      draw.circle((2, 1), radius: (0.8, 0.6), stroke: blue, fill: rgb(173, 216, 230, 100), name: "B")

      // 标注集合名称
      draw.content((0.7, 1), text(size: 10pt, $A$))
      draw.content((2.3, 1), text(size: 10pt, $B$))

      // 标注并集区域
      draw.content((1.5, 0.2), text(size: 10pt, fill: red, $A union B$))
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
    【2018课标全国Ⅰ】已知集合 $A = {x | x^2 - x - 2 > 0}$。则 $complement_bb(R) A = $（#h(3em)）
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
  columns: (1fr, 1fr),
  column-gutter: 2em,
  align: center,
  row-gutter: 1em,
  
  // 第一个公式的图示
  canvas({
    // 绘制矩形 U (全集)
    draw.rect((0, 0), (3, 2), stroke: gray, name: "U")
    
    // 绘制两个相交的圆 (A ∩ B 的补集，即 A ∩ B 外的区域填充)
    draw.compound-path(
      {
        draw.rect((0, 0), (3, 2))
        draw.circle((1, 1), radius: (0.7, 0.5))
        draw.circle((2, 1), radius: (0.7, 0.5))
        draw.compound-path(
          {
            draw.circle((1, 1), radius: (0.7, 0.5))
            draw.circle((2, 1), radius: (0.7, 0.5))
          },
          fill-rule: "non-zero",
        )
      },
      fill-rule: "even-odd",
      fill: rgb(173, 216, 230, 100),
    )
    
    draw.circle((1, 1), radius: (0.7, 0.5), stroke: blue)
    draw.circle((2, 1), radius: (0.7, 0.5), stroke: blue)
    
    // 标注
    draw.content((2.7, 1.7), text(size: 10pt, $U$))
    draw.content((0.7, 1), text(size: 10pt, $A$))
    draw.content((2.3, 1), text(size: 10pt, $B$))
  }),
  
  canvas({
    // 绘制矩形 U (全集)
    draw.rect((0, 0), (3, 2), stroke: gray)
    
    // 绘制 ∁_U A (A 的补集)
    draw.compound-path(
      {
        draw.rect((0, 0), (3, 2))
        draw.circle((1, 1), radius: (0.7, 0.5))
      },
      fill-rule: "even-odd",
      fill: rgb(173, 216, 230, 100),
    )
    
    // 绘制 ∁_U B (B 的补集) - 叠加填充
    draw.compound-path(
      {
        draw.rect((0, 0), (3, 2))
        draw.circle((2, 1), radius: (0.7, 0.5))
      },
      fill-rule: "even-odd",
      fill: rgb(255, 182, 193, 100),
    )
    
    draw.circle((1, 1), radius: (0.7, 0.5), stroke: blue)
    draw.circle((2, 1), radius: (0.7, 0.5), stroke: blue)
    
    // 标注
    draw.content((2.7, 1.7), text(size: 10pt, $U$))
    draw.content((0.7, 1), text(size: 10pt, $A$))
    draw.content((2.3, 1), text(size: 10pt, $B$))
  }),
  
  text(size: 10pt, $complement_U (A inter B)$),
  text(size: 10pt, $complement_U A union complement_U B$),
  
  // 第二个公式的图示
  canvas({
    // 绘制矩形 U (全集)
    draw.rect((0, 0), (3, 2), stroke: gray, name: "U")
    
    // 绘制 A ∪ B 的补集
    draw.compound-path(
      {
        draw.rect((0, 0), (3, 2))
        draw.circle((1, 1), radius: (0.7, 0.5))
        draw.circle((2, 1), radius: (0.7, 0.5))
      },
      fill-rule: "even-odd",
      fill: rgb(173, 216, 230, 100),
    )
    
    draw.circle((1, 1), radius: (0.7, 0.5), stroke: blue)
    draw.circle((2, 1), radius: (0.7, 0.5), stroke: blue)
    
    // 标注
    draw.content((2.7, 1.7), text(size: 10pt, $U$))
    draw.content((0.7, 1), text(size: 10pt, $A$))
    draw.content((2.3, 1), text(size: 10pt, $B$))
  }),
  
  canvas({
    // 绘制矩形 U (全集)
    draw.rect((0, 0), (3, 2), stroke: gray)
    
    // 绘制 ∁_U A ∩ ∁_U B (两个补集的交集)
    draw.compound-path(
      {
        draw.compound-path(
          {
            draw.rect((0, 0), (3, 2))
            draw.circle((1, 1), radius: (0.7, 0.5))
          },
          fill-rule: "even-odd",
        )
        draw.compound-path(
          {
            draw.rect((0, 0), (3, 2))
            draw.circle((2, 1), radius: (0.7, 0.5))
          },
          fill-rule: "even-odd",
        )
      },
      fill-rule: "non-zero",
      fill: rgb(173, 216, 230, 100),
    )
    
    draw.circle((1, 1), radius: (0.7, 0.5), stroke: blue)
    draw.circle((2, 1), radius: (0.7, 0.5), stroke: blue)
    
    // 标注
    draw.content((2.7, 1.7), text(size: 10pt, $U$))
    draw.content((0.7, 1), text(size: 10pt, $A$))
    draw.content((2.3, 1), text(size: 10pt, $B$))
  }),
  
  text(size: 10pt, $complement_U (A union B)$),
  text(size: 10pt, $complement_U A inter complement_U B$),
)


// ==================== 在文档末尾显示所有答案 ====================
#show-answers()
