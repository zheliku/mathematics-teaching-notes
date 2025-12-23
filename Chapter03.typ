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
  cover: image("image/cover.jpg", width: 100%), // 请确保有对应的封面图片，或替换为 none
  title: [第三章],
  subtitle: [函数],
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

= 函数的概念

#introduction[映射][定义][三大要素][定义域][值域][表达式]

== 映射

#definition("映射")[
  两个非空集合 $A$ 与 $B$ 间存在着对应关系，而且对于 $A$ 中的#underline[*每一个元素*] $a$， $B$ 中总有#underline[*唯一的一个元素*] $b$ 与它对应，则将这种对应称为从 $A$ 到 $B$ 的映射，记作：
  $ f: A -> B $
]

其中：
+ $b$ 称为 $a$ 在映射 $f$ 下的像，记作 $b = f(a)$。
+ $a$ 称为 $b$ 关于映射 $f$ 的原像，记作 $a = f^(-1)(b)$。
+ 集合 $A$ 中所有元素的像的集合称为映射的值域，记作 $f(A)$。

#note[
  + 像必须唯一，原像可以不唯一。
  + $B$ 中不是所有元素都需要有来自 $A$ 的对应。
]

*分类*：
+ 单射
+ 满射
+ 双射 (一一映射)

#think[
  看看下面哪些是映射？如果是，是什么集合到什么集合的映射？又是哪一类映射？反过来还成立吗？

  + 学生与班级的对应关系
  + 学生与学号的对应关系
  + 商场里物品与价格的对应关系
]

== 定义

#definition("函数")[
  在某个变化过程中有两个变量 $x, y$，如果对于 $x$ 在某个实数集合 $D$ 内的每一个确定的值，按照某个对应法则 $f$，$y$ 都有唯一确定的实数值与它对应，那么 $y$ 就是 $x$ 的函数，记作：
  $ y = f(x), x in D $
]

其中：
+ $x$ 叫做自变量 (原像)
+ $y$ 叫做因变量 (像)
+ $x$ 的取值范围 $D$ 叫做函数的定义域 (集合 $A$)
+ $y$ 值的集合叫做函数的值域 (集合 $B$)

#example(
  question: [
    定义集合 $A = {-1, 0, 1}$，集合 $B = { dots.c }$，$f$ 为 $A -> B$ 的映射，则下列说法不正确的是（#h(3em)）
  ],
  choices: choices41(
    [若 $f$ 为一一映射，则集合 $B$ 的真子集个数为 3],
    [若 $f: x -> -x$，则集合 $A = B$],
    [若集合 $B = {0, 1}$，则可能为 $f: x -> x^2$],
    [若 $f$ 为满射，则可将 $f$ 看成是定义在集合 $A$ 上的函数，且值域为 $B$],
  ),
  answer: [#tab *A*],
)

== 三大要素

#align(center)[$text("定义域") arrow.long^text("对应法则") text("值域")$]

#example(
  question: [
    下面各组函数中是同一函数的是（#h(3em)）
  ],
  choices: choices22(
    [$y = sqrt(-2 x^3)$ 与 $y = sqrt(-2 x)$],
    [$y = (sqrt(x))^2$ 与 $y = |x|$],
    [$y = sqrt(x - 1) dot sqrt(x + 1)$ 与 $y = sqrt(x^2 - 1)$],
    [$f(x) = x^2 - 2 x - 1$ 与 $g(t) = t^2 - 2 t - 1$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    如图，可以表示函数 $f(x)$ 的图象的是（#h(3em)）
    // 此处原题为图像选择题，此处保留选项结构
    // TODO: 补充图像
  ],
  choices: choices22(
    canvas({
      import draw: *
      xy-axis()
      circle((0, 0), radius: (1, 1.2))
    }),
    canvas({
      import draw: *
      xy-axis()
      line((-0.5, -1.5), (0.5, -0.5), (0.5, 1), (1.5, 2))
    }),
    canvas({
      import draw: *
      xy-axis()
      bezier-through((-1.5, 1), (0, 0), (-1.5, -1))
    }),
    canvas({
      import draw: *
      xy-axis()
      catmull((-1.5, -0.2), (-0.5, 1), (1, -1), (1.5, -0.5))
    }),
  ),
  answer: [#tab *D*],
)

== 定义域选取方式

+ 给定定义域，则使用该定义域。
+ 未给定定义域，则尽可能取最大值：
  - 分母不为零
  - 偶数次根内非负
  - 其他（如对数真数大于0等）

#example(
  question: [
    【2023·朝阳二模, 11】函数 $f(x) = display(sqrt((x - 1)/(x^2 + 1)))$ 的定义域为 #blank()。
  ],
  answer: [#tab *$[1, +infinity)$*],
)

#example(
  question: [
    已知函数 $f(2 x - 1)$ 的定义域为 $(0, 1)$，则函数 $f(1 - 3 x)$ 的定义域为 #blank()。
  ],
  answer: [#tab *$(0, display(2/3))$*],
)

== 值域求解

#example(
  question: [
    【2024全国高三练习】求下列函数的值域。
    #pad(left: 2em)[
      #grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 2em,
        [(1) $y = sqrt(-x^2 - 6 x - 5)$],

        [(2) $y = 4 - sqrt(3 + 2 x - x^2)$],

        [(3) $y = display(5/(2 x^2 - 4 x + 3))$],
      )
    ]
  ],
  answer: [
    *(1) $[0, 2]$*

    *(2) $[2, 4]$*

    *(3) $(0, 5]$*
  ],
)

#example(
  question: [
    【2024全国高三练习】求下列函数的值域。
    #pad(left: 2em)[
      #grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 2em,
        [(1) $y = display((x + 2)/(3 x - 4))$],

        [(2) $y = display((3 + x)/(4 - x))$],

        [(3) $y = display((3 x + 1)/(x - 2))$],
      )
    ]
  ],
  answer: [
    *(1) $(-infinity, display(1/3)) union (display(1/3), +infinity)$*

    *(2) $(-infinity, -1) union (-1, +infinity)$*

    *(3) $(-infinity, 3) union (3, +infinity)$*
  ],
)

#example(
  question: [
    【2024全国高三练习】求下列函数的值域。

    #pad(left: 2em)[
      #grid(
        columns: (1fr, 1fr),
        row-gutter: 1em,
        [(1) $y = sqrt(1 - 2 x) - x$],

        [(2) $y = x + sqrt(1 - 2 x)$],

        [(3) $y = x + sqrt(1 - x^2)$],

        [(4) $y = sqrt(x - 3) + sqrt(5 - x)$],
      )
    ]
  ],
  answer: [
    *(1) $[display(-1/2), +infinity)$*

    *(2) $(-infinity, -1]$*

    *(3) $[-1, sqrt(2)]$*

    *(4) $[sqrt(2), 2]$*
  ],
)

#example(
  question: [
    【2024全国高三练习】求下列函数的值域。

    #pad(left: 2em)[
      #grid(
        columns: (1fr, 1fr),
        row-gutter: 2em,
        [(1) $y = display((2 x^2 - x + 1)/(2 x - 1) (x > 1/2))$],

        [(2) $y = display((x^2 + 4 x + 3)/(x^2 + x - 6))$],

        [(3) $y = display((x^2 + 1)/(x^2 - x - 1))$],
      )
    ]
  ],
  answer: [
    *(1) $display([sqrt(2) + 1/2, +infinity))$*

    *(2) $display({y | y eq.not 1, y eq.not 2/5})$*

    *(3) $display((-infinity, -(2 sqrt(5))/5] union [(2 sqrt(5))/5, +infinity))$*
  ],
)

== 表达式求解

#example(
  question: [
    【2024全国高三练习】求解下列函数的表达式

    #pad(left: 2em)[
      #grid(
        columns: (1fr, 1fr),
        row-gutter: 2em,
        [(1) $display(f(x^2 - 2) = x^4 + 3 x^2 - 4)$],

        [(2) $display(f(1 + 1/x) = 1/x^2 - 1)$],
      )
    ]
  ],
  answer: [
    *(1) $f(x) = x^2 + 7 x + 6 (x gt.eq -2)$*

    *(2) $f(x) = x^2 - 2 x (x eq.not 1)$*
  ],
)

#example(
  question: [
    【2024全国高三练习】求解下列函数的表达式

    #pad(left: 2em)[
      #grid(
        columns: (1fr, 1fr),
        row-gutter: 2em,
        [(1) $f(x - 1) + 2 f(1 - x) = 2 x - 3$],

        [(2) $display(f(x) + 2 f(1/x) = x + 1)$],

        [(3) $display(f(x) = 2 x dot f(1/x) - 3 x)$],
      )
    ]
  ],
  answer: [
    *(1) $display(f(x) = -2 x - 1/3)$*

    *(2) $display(f(x) = 2/(3 x) - x/3 + 1/3)$*

    *(3) $display(f(x) = x + 2)$*
  ],
)

#example(
  question: [
    【2024全国高三练习】求解下列函数的表达式

    (1) $display(f(x) + f(1 - 1/x) = x + 1)$
  ],
  answer: [
    *(1) $display(f(x) = (x^3 - x^2 - 1)/(2 x(x - 1)))$*
  ],
)

#pagebreak()

= 函数的性质

#introduction[单调性][奇偶性][周期性][类周期]

== 单调性

+ $forall x_1, x_2 in D, x_1 < x_2, f(x_1) < f(x_2)$，则 $f(x)$ 单调递增，记为 $f(x) arrow.t$
+ $forall x_1, x_2 in D, x_1 < x_2, f(x_1) > f(x_2)$，则 $f(x)$ 单调递减，记为 $f(x) arrow.b$

*等价表示*：
+ $f(x) arrow.t <==> x_1 - x_2$ 与 $f(x_1) - f(x_2)$ 同号

+ $f(x) arrow.b <==> x_1 - x_2$ 与 $f(x_1) - f(x_2)$ 异号

+ $f(x) arrow.t <==> display((f(x_1) - f(x_2))/(x_1 - x_2)) > 0$

#think[
  1. $display(f(x) = 1/x)$ 在 $(-infinity, 0)$ 和 $(0, +infinity)$ 上均单调递减，能说 $f(x)$ 在 $(-infinity, 0) union (0, +infinity)$ 上单调递减吗？

  2. 增函数与增函数相加，结果还是增函数吗？
    - 增 + 增 = #blank()
    - 增 - 减 = #blank()
    - 增 $times$ 增 = #blank()
    - 增 / 减 = #blank()
]

#example(
  question: [
    判断下列函数的单调性，并给出证明：

    (1) $f(x) = sqrt(x)$

    (2) $f(x) = x^2$

    (3) $display(f(x) = x + a/x (a in bb(R)))$
  ],
  answer: [
    *略*
  ],
)

#example(
  question: [
    (多选) 如果函数 $f(x)$ 在 $[a, b]$ 上单调递增，$forall x_1, x_2 in [a, b]$，下列结论中正确的是（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 1.5em,

    [$display((f(x_1) - f(x_2))/(x_1 - x_2) > 0)$],

    [$display((x_1 - x_2)[f(x_1) - f(x_2)] > 0)$],

    [$display(f(a) lt.eq f(x_1) lt.eq f(x_2) lt.eq f(b))$],

    [$display(f(x_1) > f(x_2))$],
  ),
  answer: [#tab *AB*],
)

#example(
  question: [
    【2022陕西安康六校高一期末联考】已知函数 $f(x)$ 在定义域 $(-1, 1)$ 上单调递减，且 $f(1 - a) < f(2 a - 1)$，则实数 $a$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$display((0, 2/3))$*],
)

#example(
  question: [
    【2025北京6年高考3年模拟】已知 $f(x) = display(cases(x^2 + 4 x\, & x gt.eq 0, 4 x - x^2 \, & x < 0))$，若 $f(2 - a^2) > f(a)$，则实数 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    [$(-infinity, -1) union (2, +infinity)$],
    [$(-1, 2)$],
    [$(-2, 1)$],
    [$(-infinity, -2) union (1, +infinity)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2022 安徽江淮十校高一联考】已知函数
    $f(x) = display(cases(display(1/2 x^2 - m x \, & x gt.eq 2), display(-m/x \, & 1 lt.eq x < 2)))$
    对于 $forall x_1, x_2 in [1, +infinity)$，都有 $(x_1 - x_2)[f(x_1) - f(x_2)] gt.eq 0$，则实数 $m$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$display((0, 4/3])$*],
)

== 奇偶性

#align(center)[
  #table(
    columns: (auto, 1fr, 1fr),
    // stroke: 0.5pt,
    align: horizon + center,
    inset: 0.5em,
    table.header([], [*奇函数*], [*偶函数*]),
    [图像], [关于原点对称], [关于 $y$ 轴对称],
    [定义域], [关于原点对称], [关于原点对称],
    [特点], [$f(x) + f(-x) = 0$ \ $f(0) = 0$ (如果 $x=0$ 有意义)], [$f(x) - f(-x) = 0$],
  )
]

#think[
  1. 下列函数是奇函数还是偶函数？还是都不是？
    #pad(left: 2em)[
      #grid(
        columns: (1fr, 1fr, 1fr),
        row-gutter: 2em,
        [(1) $display(f(x) = (2^x - 1)/(2^x + 1))$],

        [(2) $display(f(x) = 3^x/(3^x + 1))$],

        [(3) $display(f(x) = (2 - x)/(2 + x))$],
      )
    ]

  2. 奇偶函数相运算得到的函数有什么性质？
    - 奇 $plus.minus$ 奇 = #blank() ; 奇 $times$ 奇 = #blank() ; 奇 / 奇 = #blank()
    - 偶 $plus.minus$ 偶 = #blank() ; 偶 $times$ 偶 = #blank() ; 偶 / 偶 = #blank()
    - 奇 $plus.minus$ 偶 = #blank() ; 奇 $times$ 偶 = #blank() ; 奇 / 偶 = #blank()

  3. 如何将一个定义域对称的函数写成一个奇函数与一个偶函数之和？
]

#example(
  question: [
    【2020河南实验中学月考】设函数 $f(x)$、$g(x)$ 的定义域都为 $bb(R)$， $f(x)$ 为奇函数，$g(x)$ 为偶函数，则下列结论正确的是（#h(3em)）
  ],
  choices: choices22(
    [$f(x) dot g(x)$ 是偶函数],
    [$|f(x)| dot g(x)$ 是奇函数],
    [$f(x) dot |g(x)|$ 是奇函数],
    [$|f(x) dot g(x)|$ 是奇函数],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2025北京6年高考3年模拟练习改编】已知函数 $f(x), g(x)$ 分别是定义在 $R$ 上的偶函数、奇函数，且满足 $f(x) - g(x) = x^3 + 3 x^2 + 3 x$，则 $f(-2) + g(2) =$ #blank()。
  ],
  answer: [#tab *-2*],
)

#example(
  question: [
    【宁夏银川一中、昆明一中2024届高三联合二模】已知函数 $f(x) = a x^5 + b sin x + c$，若 $f(-1) + f(1) = 2$，则 $c$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$-1$],
    [$0$],
    [$1$],
    [$display(2/3)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2020贵州贵阳一中月考】设函数 $display(f(x) = 3 + x + sqrt(1 - x^2) dot (2^x - 1)/(2^x + 1))$ 的最大值为 $M$，最小值为 $N$，则 $M + N$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$3$],
    [$2$],
    [$6$],
    [$4$],
  ),
  answer: [#tab *C*],
)

== 周期性

若函数满足 $f(x + a) = f(x)$，则函数的周期 $T = a$。（经过 $a$ 个单位一个周期）

#align(center)[
  #table(
    columns: (auto, 2.5fr, 1fr),
    stroke: 0.5pt,
    align: horizon + center,
    inset: 1.2em,
    table.header([序号], [条件], [周期]),
    [1], [$f(x + a) = f(x - a), quad quad f(x + a) + f(x) = k$], [$T = 2a$],
    [2],
    grid(
      columns: (1fr, 1fr),
      row-gutter: 2em,
      [$display(f(x + a) = (1 - f(x))/(1 + f(x))),$],

      [$display(f(x + a) = plus.minus 1/f(x))$],

      [$display(f(x + a) = 1/(1 - f(x))),$],

      [$display(f(x) = 1 - 1/(f(x + a)))$],
    ),

    [$T = 3a$ \ （部分情况）],

    [3], [$display(f(x + a) = -(1 - f(x))/(1 + f(x))), quad quad display(f(x + a) = -(1 + f(x))/(1 - f(x)))$], [$T = 4a$],
    [4], [$f(x + a) = f(x + b)$], [$T = |a - b|$],
  )
]

#note[
  + 有印象即可，写题时尝试代值观察得出 $T$。
  + 核心处理思想：作图。
  + 常伴有接近当年年份的值出现，如 2025, 2024...
]

#example(
  question: [
    定义在 $R$ 上的函数 $f(x)$ 满足下列各条件，不能得出函数 $f(x)$ 具有周期性的是（#h(3em)）
  ],
  choices: choices22(
    [$f(x)f(x + 2) = 2022$],
    [$f(x) = f(4 - x)$],
    [$f(x + 1) = f(x) + f(x + 2)$],
    [$f(x)$ 为奇函数且 $f(x) = f(2 - x)$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    已知函数 $f(x) = cases(display(f(x - 2) \, & x > 1), display(|x| - 1 \, & -1 lt.eq x lt.eq 1))$，关于 $x$ 的方程 $f(x) = log_a(x + 1)$ 恰有 5 个解，则实数 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display([1/7, 1/5))$],
    [$display((1/7, 1/5))$],
    [$display((1/6, 1/4))$],
    [$display([1/6, 1/4))$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2023 上海同济大学第一附属中学月考】若函数 $y = f(x), x in R$，满足 $f(x + 2) = f(x)$，且 $x in (-1, 1]$ 时，$f(x) = |x|$，则函数 $f(x)$ 的图象与函数 $y = log_4 |x|$ 的图象的交点的个数为（#h(3em)）
  ],
  choices: choices14(
    [$3$],
    [$4$],
    [$6$],
    [$8$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    定义在 $R$ 上的偶函数 $f(x)$ 满足 $display(f(x + 2) = -1/f(x))$，且当 $x in [0, 2]$ 时，$f(x) = 2 x$，则 $display(f(-9/2))$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$0$],
    [$1$],
    [$2$],
    [$3$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2025北京6年高考3年模拟】已知函数 $f(x)$ 满足 $f(x) dot f(x + 2) = 13$。

    (1) 求证：$f(x)$ 是周期函数。

    (2) 若 $f(1) = 2$，求 $f(99)$ 的值。

    (3) 若 $x in [0, 2]$ 时，$f(x) = x$，试求 $x in [4, 8]$ 时，函数 $f(x)$ 的解析式。
  ],
  answer: [
    *(1) $T = 4$*

    *(2) $display(13/2)$*

    *(3) $f(x) = cases(display(x - 4 \, & 4 lt.eq x lt.eq 6), display(13/(x - 6) \, & 6 < x lt.eq 8))$*
  ],
)

== 类周期函数

形如下列的函数称为类周期函数：
$ f(x + a) = lambda f(x) $
主要处理手段：数形结合。

#example(
  question: [
    【2022云南保山第一次质检】已知函数 $f(x)$ 满足 $f(x + 2) = 2 f(x)$，当 $x in [0, 2)$ 时，$f(x) = x$，那么 $f(21)$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$2^10$],
    [$2^11$],
    [$2^20$],
    [$2^21$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2025北京6年高考3年模拟练习】定义域为 $R$ 的函数 $f(x)$ 满足 $f(x + 1) = 2 f(x)$，且当 $x in [0, 1]$ 时，$f(x) = x^2 - x$，当 $x in [-2, -1]$ 时，$f(x)$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$-1/16$],
    [$-1/8$],
    [$-1/4$],
    [$0$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2022 云南保山第一次质检】已知函数 $f(x) = display(cases(1 - |1 - x| \, & 0 lt.eq x lt.eq 2, 2 f(x - 2) \, & 2 < x lt.eq 8))$，若方程 $f(x) - k x = 0$ 恰好有 4 个实数根，则实数 $k$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display((2/3, 8/7))$],
    [$display((2/3, 1))$],
    [$display((4/5, 8/7))$],
    [$display((4/5, 1))$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2022 河北沧州一中月考】定义在 $[0, +infinity)$ 上的函数 $f(x)$ 满足 $display(f(x + 2) = 1/2 f(x))$，当 $x in [0, 2)$ 时，$f(x) = x^2 - 2 x + 1$。若直线 $y = a$ 与 $f(x)$ 的图像恰有 8 个交点 $(x_1, y_1), (x_2, y_2), ..., (x_8, y_8)$，则 $x_1 + x_2 + ... + x_8$ = #blank(), $a$ 的取值范围是 #blank()。
  ],
  answer: [#tab *32* #tab *$(1/16, 1/8)$*],
)

#pagebreak()
// ----------------------接上一部分-----------------------

= 基本初等函数

#introduction[幂函数][二次函数][指数与对数][反函数][特殊函数]

== 幂函数

形如 $y = x^a$ 的函数。

*常见幂函数特征*：
+ $y = x, y = x^3, y = x^(-1)$ (奇函数)
+ $y = x^2, y = x^(-2)$ (偶函数)
+ $y = x^(1/2)$ (非奇非偶)
+ 所有幂函数图像都经过 $(1, 1)$ 点。
+ 在 $(0, +infinity)$ 上：
  - $a > 0$ 时，单调递增；
  - $a < 0$ 时，单调递减。

#example(
  question: [
    【2024宁夏固原高三隆德县中学校联考期中】已知函数 $f(x) = (m^2 - 2 m - 2) dot x^(m - 2)$ 是幂函数，且在 $(0, +infinity)$ 上递减，则实数 $m$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$-1$],
    [$-1$ 或 $3$],
    [$3$],
    [$2$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2024全国高三专题练习】已知幂函数 $y = x^(p/q)$ ($p, q in bb(Z)$ 且 $p, q$ 互质) 的图象关于 $y$ 轴对称，且在 $(0, +infinity)$ 上单调递减，则（#h(3em)）
  ],
  choices: choices22(
    [$p, q$ 均为奇数，且 $p/q > 0$],
    [$q$ 为偶数，$p$ 为奇数，且 $p/q > 0$],
    [$q$ 为奇数，$p$ 为偶数，且 $p/q < 0$],
    [$q$ 为奇数，$p$ 为偶数，且 $p/q < 0$],
  ),
  answer: [#tab *D*],
)

== 二次函数

对于二次函数：$f(x) = a x^2 + b x + c$

+ *对称轴*：$x = -b/(2 a)$
+ *零点公式*：$x = (-b plus.minus sqrt(b^2 - 4 a c))/(2 a)$
+ *判别式*：$Delta = b^2 - 4 a c$
+ *韦达定理*：$x_1 + x_2 = -b/a, quad x_1 x_2 = c/a$

#example(
  question: [
    【2024全国高三专题练习】设 $a$ 为实数，若方程 $x^2 - 2 a x + a = 0$ 在区间 $(-1, 1)$ 上有两个不相等的实数解，则 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    [$(-infinity, 0) union (1, +infinity)$],
    [$(-1, 0)$],
    [$(-1/3, 0)$],
    [$(-1/3, 0) union (1, +infinity)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2024全国高三专题练习】方程 $x^2 + (m - 2) x + 5 - m = 0$ 的一根在区间 $(2, 3)$ 内，另一根在区间 $(3, 4)$ 内，则 $m$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    [$(-5, -4)$],
    [$(-13/3, -2)$],
    [$(-13/3, -4)$],
    [$(-5, -2)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2024 全国高三专题练习】关于 $x$ 的方程 $a x^2 + (a + 2) x + 9 a = 0$ 有两个不相等的实数根 $x_1, x_2$，且 $x_1 < 1 < x_2$，那么 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    [$-2/7 < a < 2/5$],
    [$a > 2/5$],
    [$a < -2/7$],
    [$-2/11 < a < 0$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2024上海高三专题练习】已知 $f(x) = a x^2 + 2 b x + 4 c quad (a, b, c in bb(R))$。

    (1) 若 $f(0) = -1, a + 2 b = 0$，解关于 $x$ 的不等式 $f(x) < (a + 1) x - 3$。

    (2) 若 $a + c = 0, f(x)$ 在 $[-2, 2]$ 上的最大值为 $2/3$，最小值为 $-1/2$，求证：$|b/a| lt.eq 2$。
  ],
  answer: [
    *(1)*
    若 $a = 0$，解集为 $(2, +infinity)$；
    若 $a < 0$，解集为 $(2, +infinity) union (-infinity, 1/a)$；
    若 $0 < a < 1/2$，解集为 $(2, 1/a)$；
    若 $a = 1/2$，解集为 $emptyset$；
    若 $a > 1/2$，解集为 $(1/a, 2)$。

    *(2)* 略
  ],
)

== 指数函数与对数函数

#align(center)[
  #table(
    columns: (1fr, 1fr),
    stroke: 0.5pt,
    inset: 0.8em,
    table.header([*指数运算*], [*对数运算*]),
    [$a^x dot a^y = a^(x + y)$ \ $a^x / a^y = a^(x - y)$ \ $(a^x)^y = a^(x y)$ \ $(a b)^x = a^x b^x$],
    [$log_a m + log_a n = log_a (m n)$ \ $log_a m - log_a n = log_a (m/n)$ \ $n log_a m = log_a m^n$ \ $log_a b = (log_c b)/(log_c a)$ (换底公式)],
  )
]

*指数函数* $y = a^x (a > 0, a eq.not 1)$
+ 定义域 $R$，值域 $(0, +infinity)$
+ 图像过点 $(0, 1)$
+ $a > 1$ 单调递增；$0 < a < 1$ 单调递减

*对数函数* $y = log_a x (a > 0, a eq.not 1)$
+ 定义域 $(0, +infinity)$，值域 $R$
+ 图像过点 $(1, 0)$
+ $a > 1$ 单调递增；$0 < a < 1$ 单调递减
+ $y = a^x$ 与 $y = log_a x$ 互为反函数，图像关于 $y = x$ 对称

#example(
  question: [
    【2024全国高三专题练习】已知 $x_1$ 是方程 $x dot 3^x = 2$ 的根，$x_2$ 是方程 $x dot log_3 x = 2$ 的根，则 $x_1 x_2$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$2$],
    [$3$],
    [$6$],
    [$10$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2024 全国高三专题练习】若 $x_1$ 满足 $e^x = 3 - x$，$x_2$ 满足 $x + log_2 x = 3$，令 $a + b = x_1 + x_2$，其中 $a, b > 0$，则 $(7 b^2 + 1)/(a b)$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$1$],
    [$7/3$],
    [$67/9$],
    [$2$],
  ),
  answer: [#tab *D*],
)

== 反函数

原函数 $y = f(x)$ 的反函数为 $x = f^(-1)(y)$，通常记为 $y = f^(-1)(x)$。
+ *条件*：原函数为一一映射。
+ *特点*：定义域和值域互换；图像关于 $y = x$ 对称。

== 特殊函数

*指对中的奇/偶函数*：
+ $f(x) = (a^x - 1)/(a^x + 1) (a > 0)$ (奇函数)
+ $f(x) = ln(sqrt(x^2 + 1) + x)$ (奇函数)
+ $f(x) = ln((a - x)/(a + x)) (a > 0)$ (奇函数)
+ $f(x) = ln(e^(2 a x) + 1) - a x (a > 0)$ (偶函数)

#pagebreak()

= 函数的对称、平移和缩放

#introduction[对称性][平移][缩放][探究]

== 对称性

*点对称*：
+ 函数 $f(x)$ 关于点 $(a, b)$ 对称 $i f f f(a - x) + f(a + x) = 2 b$
+ 或 $f(m - x) + f(n + x) = 2 b$ (其中 $m + n = 2 a$)

*轴对称*：
+ 函数 $f(x)$ 关于直线 $x = a$ 对称 $i f f f(a - x) = f(a + x)$
+ 或 $f(m - x) = f(n + x)$ (其中 $m + n = 2 a$)

#note[
  *二次对称产周期*：
  1. 若 $f(x)$ 有两条对称轴 $x = a, x = b (a < b)$，则 $T = 2(b - a)$。
  2. 若 $f(x)$ 有两个对称中心 $(a, c), (b, c) (a < b)$，则 $T = 2(b - a)$。
  3. 若 $f(x)$ 有一条对称轴 $x = a$ 和一个对称中心 $(b, c) (a < b)$，则 $T = 4(b - a)$。
]

#example(
  question: [
    已知二次函数 $f(x) = x^2 + b x + c$ 满足 $f(3 - x) = f(x)$，若其在 $(a, 2 a - 1)$ 上单调递减，则 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    [$(-infinity, 5/4)$],
    [$(1, 5/4)$],
    [$(-3/2, +infinity)$],
    [$(-infinity, 2]$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2021江苏无锡大桥中学高一期中】若函数 $f(x) = x/(x + 1)$，则 $f(1) + f(2) + ... + f(50) + f(1/2) + f(1/3) + ... + f(1/50) =$ #blank()。
  ],
  answer: [#tab *49.5*],
)

#example(
  question: [
    【2023-2024安徽省部分学校高一上期末】已知函数 $f(x) = 2/(1 + 3^x)$，则 $f(-2024) + ... + f(-1) + f(0) + f(1) + ... + f(2024)$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$4047$],
    [$4048$],
    [$4049$],
    [$4050$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【广东省广州市三校2023-2024高一上期末联考】已知奇函数 $f(x)$ 的图象关于直线 $x = 1$ 对称，当 $x in [0, 1]$ 时，$f(x) = 2^x + b$，则 $f(2023/2)$ 的值为（#h(3em)）
  ],
  choices: choices22(
    [$-1 - sqrt(2)$],
    [$1 - sqrt(2)$],
    [$sqrt(2) + 1$],
    [$sqrt(2) - 1$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【广东省佛山市2023-2024高一上期末】(多选) 已知函数 $f(x)$ 满足：对任意的 $x in R$，都存在 $f(-x) = -f(x)$，$f(1/2 - x) = f(3/2 + x)$，且 $f(1) = 2$，则（#h(3em)）
  ],
  choices: choices22(
    [$y = f(x)$ 关于 $(1, 0)$ 对称],
    [$f(4 - x) = -f(x)$],
    [$f(x)$ 的值域为 $[-2, 2]$],
    [$sum_(k=0)^(19) f(k) = 0$],
  ),
  answer: [#tab *BD*],
)

== 平移与缩放

*平移变换*：
+ *左加右减*：$f(x + a)$ 相当于 $f(x)$ 向左平移 $a$ ($a > 0$)。
+ *上加下减*：$f(x) + a$ 相当于 $f(x)$ 向上平移 $a$ ($a > 0$)。

*缩放变换*：
+ *扩除缩乘 (x轴)*：
  - $f(a x)$ ($a > 1$)：横坐标缩小为原来的 $1/a$ 倍。
  - $f(x/a)$ ($a > 1$)：横坐标扩大为原来的 $a$ 倍。
+ *扩乘缩除 (y轴)*：
  - $a f(x)$ ($a > 1$)：纵坐标扩大为原来的 $a$ 倍。

#example(
  question: [
    【2023丰台二模, 7】为了得到函数 $y = log_2 (2 x - 2)$ 的图象，只需把函数 $y = log_2 x$ 的图象上的所有点（#h(3em)）
  ],
  choices: choices14(
    [向左平移 2 个单位长度，再向上平移 2 个单位长度],
    [向右平移 2 个单位长度，再向下平移 2 个单位长度],
    [向左平移 1 个单位长度，再向上平移 1 个单位长度],
    [向右平移 1 个单位长度，再向上平移 1 个单位长度],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2019海淀二模】把函数 $y = 2^x$ 的图象向右平移 1 个单位长度，所得图象对应的函数解析式为 $y = (2^x)/3$，则 $a$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$1/2$],
    [$log_2 3$],
    [$log_3 2$],
    [$sqrt(3)$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2020山东曲阜一中月考】函数 $f(x)$ 在 $(0, +infinity)$ 上单调递增，且 $f(x + 2)$ 的图像关于直线 $x = -2$ 对称。若 $f(-2) = 1$，则 $f(x - 2) lt.eq 1$ 的 $x$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$[0, 4]$*],
)

#example(
  question: [
    【重庆市第八中学校2023-2024高一上期末】设函数 $f(x)$ 的定义域为 $R$，$f(x + 1)$ 为奇函数，$f(x + 2)$ 为偶函数，当 $x in [1, 2]$ 时，$f(x) = a x^2 + b$。若 $f(3) + f(4) = 6$，则 $f(13/3)$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$-4/3$],
    [$32/9$],
    [$1/4$],
    [$4/3$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【湖南长沙市长郡中学2023-2024高一上期末】(多选) 定义在 $R$ 上的函数 $f(x)$ 满足 $f(4 - x) = -f(x)$，$f(2 x + 1)$ 为偶函数，$f(1) = 2$。函数 $g(x) (x in R)$ 满足 $g(x) = g(2 - x)$，若 $y = f(x)$ 与 $y = g(x)$ 恰有 2023 个交点，从左至右依次为 $(x_1, y_1), (x_2, y_2), ..., (x_2023, y_2023)$，则下列说法正确的是（#h(3em)）
  ],
  choices: choices22(
    [$f(x)$ 为奇函数],
    [$2$ 为 $y = f(x)$ 的一个周期],
    [$y_1012 = 2$],
    [$x_1 + x_2 + ... + x_2023 = 2023$],
  ),
  answer: [#tab *ACD*],
)

== 平移缩放探究

*扩展反比例函数*：
+ 基础形式：$f(x) = 1/x$
+ 扩展形式：$f(x) = (a x + b)/(c x + d)$ (对称中心)

*扩展对勾函数*：
+ 基础形式：$f(x) = a x + b/x$
+ 扩展形式：$f(x) = (a x^2 + b x + c)/(d x + e)$

// ----------------------接上一部分-----------------------

= 抽象函数

只告诉了函数的关系式，而没有告诉具体的表达式。

*处理方式*：
+ 寻找已学过的函数模型进行匹配，探究其函数特征。
+ 寻找特殊值带入（赋值法）。

*常见模型*：
+ *一次函数*：$f(x + y) = f(x) + f(y) + b$
+ *幂函数*：$f(x y) = f(x) f(y)$
+ *指数函数*：$f(x + y) = f(x) f(y)$
+ *对数函数*：$f(x y) = f(x) + f(y)$
+ *周期函数*：$f(x + a) + f(x) = k$

#example(
  question: [
    已知函数 $f(x)$ 满足 $forall x, y in R, f(x y) = f(x) f(y)$，且 $f(-1) = 1, f(27) = 9$，当 $x in [0, 1)$ 时，$f(x) in [0, 1)$。

    (1) 判断 $f(x)$ 的奇偶性。

    (2) 判断 $f(x)$ 在 $[0, +infinity)$ 上的单调性。

    (3) 若 $a gt.eq 0, f(a + 1) lt.eq root(3, 9)$，求 $a$ 的取值范围。
  ],
  answer: [
    *(1) 偶函数*

    *(2) 单调递增*

    *(3) $[0, 2]$*
  ],
)

#example(
  question: [
    已知非常数函数 $f(x)$ 满足 $forall x, y in R, f(x + y) = f(x) f(y)$。求证：$f(x) > 0$。
  ],
  answer: [
    *略*
    (提示：令 $x=y=x/2$，得 $f(x) = f^2(x/2) gt.eq 0$，再证 $f(x) \ne 0$)
  ],
)

#example(
  question: [
    定义在 $(0, +infinity)$ 的单调递增函数 $f(x)$ 满足 $forall x, y in (0, +infinity), f(x y) = f(x) + f(y), f(3) = 1$。

    (1) 求 $f(1)$。

    (2) 若 $f(x) + f(x - 8) lt.eq 2$，求 $x$ 的取值范围。
  ],
  answer: [
    *(1) 0*

    *(2) $(8, 9]$*
  ],
)

#example(
  question: [
    已知函数 $f(x)$ 满足 $forall x, y in R, f(x + y) = f(x) + f(y)$，$f(-1) = -2$，$x > 0$ 时，$f(x) > 0$。求 $f(x)$ 在 $[-2, 1]$ 上的值域？
  ],
  answer: [#tab *$[-4, 2]$*],
)

#example(
  question: [
    【2022全国新高考II】已知 $f(x)$ 的定义域为 $R$，且 $f(x + y) + f(x - y) = f(x) f(y), f(1) = 1$，则 $sum_(k=1)^(22) f(k) =$ （#h(3em)）
  ],
  choices: choices14(
    [$-3$],
    [$-2$],
    [$0$],
    [$1$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【安徽省蚌埠市2024学年高三上学期期末】已知定义在 $R$ 上的函数 $f(x), g(x)$ 满足：
    1. $f(0) = 1$；
    2. $forall x, y in bb(R), f(x - y) = f(x) f(y) - g(x) g(y)$。

    (1) 求 $f^2(x) - g^2(x)$ 的值。

    (2) 判断并证明函数 $f(x)$ 的奇偶性。

    (3) 若 $g(x)$ 为奇函数，且 $forall x > 0, g(x) > 0$，证明：$f(x)$ 在 $(0, +infinity)$ 上单调递增。
  ],
  answer: [
    *(1) 1*

    *(2) 偶函数*

    *(3) 略*
  ],
)

#think[
  1. 满足 $f(x + y) + f(x - y) = 2 f(x) f(y) (forall x, y in R)$ 的 $f(x)$ 是偶函数吗？
]

// ==================== 在文档末尾显示所有答案 ====================
#show-answers()
