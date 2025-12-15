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
  title: [第二章],
  subtitle: [一元二次函数和不等式],
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

= 等式

#introduction[不等式的基本性质][比较大小][高次不等式][分式不等式]

== 不等式的基本性质

#align(center)[
  #table(
    columns: (auto, 2fr),
    stroke: none,
    align: horizon,
    inset: 0.5em,
    table.hline(),
    table.header([性质], [内容]),
    table.hline(stroke: 0.5pt),
    [对称性], [$a > b <==> b < a$],
    [传递性], [$a > b, b > c => a > c$],
    [可加性], [$a > b <==> a + c > b + c$],
    [可乘性], [$a > b, c > 0 => a c > b c$ \ $a > b, c < 0 => a c < b c$],
    [同向可加性], [$a > b, c > d => a + c > b + d$],
    [同向同正可乘性], [$a > b > 0, c > d > 0 => a c > b d$],
    [可乘方性], [$a > b > 0 => a^n > b^n (n in bb(N)^+, n gt.eq 2)$],
    [可开方性], [$a > b > 0 => root(n, a) > root(n, b) (n in bb(N)^+, n gt.eq 2)$],
    table.hline(stroke: 0.5pt),
  )
]

#example(
  question: [
    已知 $a > b > 0$，$c < d < 0$，则下列不等式一定成立的是 #blank()
  ],
  choices: choices14(
    [$display(a/d > b/c)$],
    [$a c < b d$],
    [$display(a - c > b - d)$],
    [$a + c > b + d$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    已知 $a > b, a b > 0$，则 $display(1/a)$ #blank() $display(1/b)$
  ],
  answer: [#tab *$<$*],
)

#example(
  question: [
    (1) 已知 $1 < a < 4, 2 < b < 8$，求 $2 a + 3 b$、$a - b$ 和 $display(a/b)$ 的取值范围。

    #h(3em) (2) 已知 $-6 < a < 8, 2 < b < 3$，求 $display(a/b)$ 的取值范围。

    #h(3em) (3) 已知 $-1 < a + b < 5, -4 < a - b < 2$，求 $2 a - 4 b$ 的取值范围。
  ],
  answer: [
    *(1) $2 a + 3 b in (8, 32)$，$a - b in (-7, 2)$，$display(a/b) in (display(1/8), 2)$*

    *(2) $display(a/b) in (-3, 4)$*

    *(3) $2 a - 4 b in (-17, 7)$*
  ],
)



== 比较大小

+ 作差法：$a - b > 0 <==> a > b$（常用）
+ 作商法：$display(a/b > 1 <==> a > b (b > 0))$（需要确定分母的符号）

#example(
  question: [
    已知 $a > b > 0$，比较 $display((2 a + b)/(a + 2 b))$ 与 1 的大小。
  ],
  answer: [
    解：
    $
      (2 a + b)/(a + 2 b) - 1 = (2 a + b - a - 2 b)/(a + 2 b) = (a - b)/(a + 2 b)
    $

    因为 $a > b > 0$，所以 $a - b > 0, a + 2 b > 0$，

    故 $display((a - b)/(a + 2 b) > 0)$，即 $display((2 a + b)/(a + 2 b) > 1)$。
  ],
)

#example(
  question: [
    已知 $a > b > 0, m > 0$，则：

    （1） $display(b/a)$ #blank() $display((b + m)/(a + m))$

    （2） $display(a/b)$ #blank() $display((a + m)/(b + m))$
  ],
  answer: [
    *(1) $<$*

    *(2) $>$*
  ],
)

#example(
  question: [
    已知 $a, b in bb(R)^+$，比较 $display((a^3 + b^3)/(a^2 + b^2))$ 与 $display((a^2 + b^2)/(a + b))$ 的大小。
  ],
  answer: [
    解：
    $
      (a^3 + b^3)/(a^2 + b^2) - (a^2 + b^2)/(a + b) &= ((a^3 + b^3)(a + b) - (a^2 + b^2)^2)/((a^2 + b^2)(a + b)) \
      &= (a^4 + a^3 b + a b^3 + b^4 - a^4 - 2 a^2 b^2 - b^4)/((a^2 + b^2)(a + b)) \
      &= (a^3 b + a b^3 - 2 a^2 b^2)/((a^2 + b^2)(a + b)) \
      &= (a b(a^2 + b^2 - 2 a b))/((a^2 + b^2)(a + b)) \
      &= (a b(a - b)^2)/((a^2 + b^2)(a + b))
    $

    因为 $a, b in bb(R)^+$，所以 $a b > 0, (a - b)^2 gt.eq 0, a^2 + b^2 > 0, a + b > 0$，

    故 $display((a b(a - b)^2)/((a^2 + b^2)(a + b)) gt.eq 0)$，

    即 $display((a^3 + b^3)/(a^2 + b^2) gt.eq (a^2 + b^2)/(a + b))$。
  ],
)

#example(
  question: [
    已知 $n$ 为正整数，则当 $n$ 取多大时，$f(n) = -n^3 + 8 n^2 + 4 n + 3$ 取得最大值？
  ],
  answer: [
    *$n = 6$ 时取得最大值*

    解析：考虑相邻两项的差：
    $
      f(n + 1) - f(n) & = -(n + 1)^3 + 8(n + 1)^2 + 4(n + 1) + 3 - (-n^3 + 8 n^2 + 4 n + 3) \
                      & = -(n^3 + 3 n^2 + 3 n + 1) + 8(n^2 + 2 n + 1) + 4 n + 4 + 3- \
                      & quad (-n^3 + 8 n^2 + 4 n + 3) \
                      & = -n^3 - 3 n^2 - 3 n - 1 + 8 n^2 + 16 n + 8 + 4 n + 7 + n^3 - 8 n^2 - 4 n \
                      & quad - 3 \
                      & = -3 n^2 + 13 n + 11
    $

    令
    $
      f(n + 1) - f(n) = -3 n^2 + 13 n + 11 lt.eq 0
    $

    解这个不等式：
    $
      n = (13 plus.minus sqrt(169 + 132))/6 = (13 plus.minus sqrt(301))/6
    $

    因为 $sqrt(301) approx 17.35$，所以 $n approx display((13 plus.minus 17.35)/6)$

    解得 $n in display([(-4.35)/6, (30.35)/6]) approx [-0.73, 5.06]$

    因为 $n$ 为正整数，所以 $n in {1, 2, 3, 4, 5}$ 时 $f(n + 1) > f(n)$，

    当 $n gt.eq 6$ 时 $f(n + 1) < f(n)$。

    因此 $n = 6$ 时取得最大值：
    $
      f(6) = -216 + 288 + 24 + 3 = 99
    $
  ],
)

#example(
  question: [
    已知 $n$ 为正整数，则当 $n$ 取多大时，$f(n) = (n + 1) dot (display(9/10))^n$ 取得最大值？
  ],
  answer: [
    *$n = 8$ 或 $9$ 时取得最大值*

    解析：考虑相邻两项的比值：
    $
      (f(n + 1))/(f(n)) = ((n + 2) dot (9/10)^(n + 1))/((n + 1) dot (9/10)^n) = (n + 2)/(n + 1) dot 9/10 = (9(n + 2))/(10(n + 1))
    $

    令 $display((f(n + 1))/(f(n))) gt.eq 1$：
    $
      (9(n + 2))/(10(n + 1)) gt.eq 1
    $
    $
      9(n + 2) gt.eq 10(n + 1)
    $
    $
      9 n + 18 gt.eq 10 n + 10
    $
    $
      n lt.eq 8
    $

    因此，当 $n lt.eq 8$ 时，$f(n + 1) gt.eq f(n)$，函数递增；且 当 $n = 8$ 时，$f(n + 1) = f(n)$。

    当 $n gt 9$ 时，$f(n + 1) < f(n)$，函数递减。

    所以 $n = 8$ 或 $9$ 时取得最大值。
  ],
)

== 高次不等式

对于形如
$
  f(x) = (x - a)(x - b)(x - c) dots.c > 0
$
的不等式：

+ 数形结合法：作出 $f(x)$ 的图像（穿根法）
+ 根据图像确定不等式的解集

#example(
  question: [
    解不等式：
    $
      (x + 1)(2 - x)(x - 3) > 0
    $
  ],
  answer: [
    解：原不等式等价于
    $
      (x + 1)(x - 2)(x - 3) < 0
    $

    令 $f(x) = (x + 1)(x - 2)(x - 3)$，

    根的排列为：$-1 < 2 < 3$

    使用穿根法，从右向左穿根，得解集为：
    $
      x in (-1, 2) union (3, +infinity)
    $
  ],
)

#note[
  对于多项式 $f(x)$，若 $f(n)=0$，则 $x-n$ 是 $f(x)$ 的因式，即 $f(n) = (x - n) dot g(x)$
]

#example(
  question: [
    解不等式：

    （1） $x^3 - 7 x + 6 < 0$

    （2） $x^3 - x^2 - 17 x - 15 > 0$
  ],
  answer: [
    *（1） $x in (-infinity, -3) union (1, 2)$*

    *（2） $x in (-3, -1) union (5, +infinity)$*
  ],
)



== 分式不等式

对于 $display(f(x)/g(x) > 0)$ 型：
$
  f(x)/g(x) > 0 <==> f(x) dot g(x) > 0
$

对于 $display(f(x)/g(x) gt.eq 0)$ 型：
$
  f(x)/g(x) gt.eq 0 <==> cases(
    f(x) dot g(x) gt.eq 0,
    g(x) eq.not 0
  )
$

#example(
  question: [
    解不等式：
    $
      (x + 2)/(2 x - 1) gt.eq 0
    $
  ],
  answer: [
    *$x in (-infinity, -2] union (display(1/2), +infinity)$*

    解：原不等式等价于
    $
      cases(
        (x + 2)(2 x - 1) gt.eq 0,
        2 x - 1 eq.not 0
      )
    $

    解得：$x in (-infinity, -2] union (display(1/2), +infinity)$
  ],
)

#example(
  question: [
    解不等式：

    （1） $display((x^2 + x - 2)/(4 - x) < 0)$

    （2） $display(2 + 4/(x - 1) > 0)$

    （3） $display(1/x gt.eq x)$
  ],
  answer: [
    *（1） $x in (-2, 1) union (4, +infinity)$*

    *（2） $x in (-infinity, -1) union (1, +infinity)$*

    *（3） $x in (-infinity, -1] union (0, 1]$*
  ],
)

#pagebreak()

= 一元二次函数

#introduction[初中回顾][参数与图像的关系]

== 初中回顾

一元二次函数的一般形式：
$
  y = a x^2 + b x + c quad (a eq.not 0)
$

+ 对称轴：$ x = -display(b/(2 a)) $
+ 顶点坐标：$ (display(-b/(2 a)), display((4 a c - b^2)/(4 a))) $
+ 判别式：
  - $Delta > 0$：两个不相等的实数根
  - $Delta = 0$：两个相等的实数根
  - $Delta < 0$：无实数根
+ 与 $x$ 轴的交点个数：
  - $Delta > 0$：2 个交点
  - $Delta = 0$：1 个交点
  - $Delta < 0$：0 个交点
+ 单调性：
  - $a > 0$ 时:
  在 $(-infinity, display(-b/(2 a)))$ 上单调递减，在 $(display(-b/(2 a)), +infinity)$ 上单调递增
  - $a < 0$ 时:
  在 $(-infinity, display(-b/(2 a)))$ 上单调递增，在 $(display(-b/(2 a)), +infinity)$ 上单调递减

#example(
  question: [
    【2023海南新高考模拟】函数 $f(x) = a x^2 + b x + c$ 的部分函数值如下表所示：

    #align(center)[
      #table(
        columns: (auto, auto, auto, auto, auto, auto),
        stroke: 0.5pt,
        align: horizon,
        inset: 0.5em,
        [$x$], [$-3$], [$-2$], [$-1$], [$0$], [$1$],
        [$f(x)$], [$6$], [$0$], [$-4$], [$-6$], [$-6$],
      )
    ]

    则函数 $f(x)$ 的零点个数为 #blank()。
  ],
  answer: [
    *2*

    解析：从表格可以看出：
    + $f(-2) = 0$，所以 $x = -2$ 是一个零点
    + $f(-3) = 6 > 0, f(-1) = -4 < 0$，由零点存在定理，在 $(-3, -1)$ 内还有一个零点
    + $f(0) = -6 < 0, f(1) = -6 < 0$，无法判断 $(0, 1)$ 内是否有零点

    但由于二次函数最多有 2 个零点，且已经找到 2 个，故零点个数为 2。
  ],
)

#example(
  question: [
    【2023浙江省高一联考】已知函数 $f(x) = x^2 - 2 a x + 3$，若 $f(x)$ 在 $[1, 2]$ 上单调递增，则实数 $a$ 的取值范围为 #blank()。
  ],
  answer: [
    *$a lt.eq 1$*

    解析：二次函数 $f(x) = x^2 - 2 a x + 3$ 的对称轴为 $x = a$。

    要使 $f(x)$ 在 $[1, 2]$ 上单调递增，需要对称轴在区间左侧或左端点，即 $a lt.eq 1$
  ],
)

#example(
  question: [
    【2022 天津滨海新区阶段考试】若不等式 $(a - 2) x^2 + 4(a - 2) x + 3 > 0$ 的解集为 *R*，则实数 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 1.8em,
    [$(2, display(11/4))$],
    [$[2, display(11/4))$],
    [$(- infinity, 2) union (display(11/4), + infinity)$],
    [$(- infinity, 2] union (display(11/4), + infinity)$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2020 四川泸县上学期】已知关于 $x$ 的不等式 $a x^2 + b x + c > 0$ 的解集为 $(2, 3)$，则关于 $x$ 的不等式 $c x^2 + b x + a < 0$ 的解集为 #blank()。
  ],
  answer: [#tab *$(- infinity, display(1/3)) union (display(1/2), + infinity)$*],
)

#example(
  question: [
    【2022 山东枣庄滕州期中】（多选）已知关于 $x$ 的不等式 $(x + 2)(x - 4) + a < 0$（$a < 0$）的解集为 $(x_1, x_2)$，则（#h(3em)）
  ],
  choices: choices22(
    [$x_1 + x_2 = 2$],
    [$x_1 x_2 < -8$],
    [$-2 < x_1 < x_2 < 4$],
    [$x_2 - x_1 > 6$],
  ),
  answer: [#tab *A、B、D*],
)

#example(
  question: [
    【2017 湖北襄阳襄城区校级模拟】设 $a, b$ 是关于 $x$ 的一元二次方程 $x^2 - 2 m x + m + 6 = 0$ 的两个实根，则 $(a - 1)^2 + (b - 1)^2$ 的最小值为（#h(3em)）
  ],
  choices: choices22(
    [$-display(49/4)$],
    [$18$],
    [$8$],
    [$-6$],
  ),
  answer: [#tab *C*],
)

== 参数与图像的关系

+ $a$ 决定开口方向：
  - $a > 0$：开口向上
  - $a < 0$：开口向下
+ $|a|$ 决定开口大小：$|a|$ 越大，开口越小
+ $c$ 决定与 $y$ 轴的交点：$(0, c)$

#example(
  question: [
    已知二次函数 $f(x) = a x^2 + b x + c$ 有两个零点 $x_1$、$x_2$，且满足 $x_1 < -2, x_2 > 0, 0 < |c| < 1$，则（#h(3em)）
  ],
  choices: choices22(
    [$a$ 与 $c$ 一定同号],
    [若 $a > 0$，则 $2 a > b$],
    [$2 c(2 a - b) + c^2 < 0$],
    [若 $a = 1$，则 $0 < x_2 < display(1/2)$],
  ),
  answer: [#tab *D*],
)

#think[
  已知二次函数 $y = a x^2 + b x + c$ 的图像，判断以下结论：

  + 对称轴在哪里？
  + $a、b、c$ 如何影响图像的形状、位置？
]

#example(
  question: [
    已知二次函数 $f(x) = a x^2 + b x + c (a > 0)$ 有两个零点 $x_1$、$x_2$，且满足 $-2 lt.eq x_1 lt.eq -1, 3 lt.eq x_2 lt.eq 5$，则下列说法不正确的是（#h(3em)）
  ],
  choices: choices41(
    [$-4 a lt.eq b lt.eq -a$],
    [若 $a = 1$，则 $c$ 的取值范围是 $[-10, -3]$],
    [$a + c gt.eq b$],
    [记 $f(x)$ 的最小值为 $m$，则 $m$ 的最大值为 $-4 a$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2022 浙江五校联考】已知关于 $x$ 的不等式 $a x^2 - 2 x + 3 a < 0$ 在 $(0, 2]$ 上有解，则实数 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 1.8em,
    [$(- infinity, display(sqrt(3)/3))$],
    [$(- infinity, display(4/7))$],
    [$(display(sqrt(3)/3), + infinity)$],
    [$(display(4/7), + infinity)$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2020 黑龙江齐齐哈尔第八中学月考】已知关于 $x$ 的不等式 $a x^2 - (a + 1) x < -a + 13 x$ 在区间 $[2, 3]$ 上恒成立，则实数 $a$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$(-infinity, 6)$*],
)

#pagebreak()

= 基本不等式

#introduction[均值不等式][算术/几何平均值][基本不等式链]

== 均值不等式

$
  m^2 + n^2 & gt.eq 2 m n quad (m, n in bb(R)) \
      a + b & gt.eq 2 sqrt(a b) quad (a, b > 0) \
  (a + b)/2 & gt.eq sqrt(a b) quad (a, b > 0)
$

#text(fill: red)[始终注意等号成立的条件：当且仅当 $a = b$ 时等号成立。]

#example(
  question: [
    已知 $x > 0$，则 $x + display(16/x)$ 的最小值为 #blank()。
  ],
  answer: [#tab *8*],
)

#example(
  question: [
    函数 $f(x) = display((x^2 + 8)/(x - 1)) (x > 1)$ 的最小值是 #blank()。
  ],
  answer: [#tab *8*],
)

#example(
  question: [
    求下列函数的最大值。

    （1） $y = x(4 - x)$

    （2） $y = x(5 - 2 x)$

    （3） $y = 3 x(6 - 2 x)$
  ],
  answer: [
    *(1) 4*

    *(2) $display(25/8)$*

    *(3) $display(27/2)$*
  ],
)

#extend[
  （1） $f(x) = a x + display(b/x) (a, b > 0)$ 的图像（对勾函数）。

  （2）探究下列表达式之间的关系：

  #h(3em)  1） $a + display(1/a)$ 、 $a - display(1/a)$
  #h(3em)  2） $a^2 + display(1/a^2)$
  #h(3em)  3） $a^2 - display(1/a^2)$
]

== 算术平均值和几何平均值

+ *算术平均值*：
  $ (a_1 + a_2 + a_3 + ... + a_n)/n $

+ *几何平均值*：
  $ root(n, a_1 a_2 ... a_n) $

+ *高阶均值不等式*：
  #align(center)[
    算术平均值 $gt.eq$ 几何平均值（$a_i gt.eq 0, i = 1, 2, 3 ...$）
  ]

#example(
  question: [
    已知 $x > 0$，则 $x^2 + display(16/x)$ 的最小值为 #blank()。
  ],
  answer: [#tab *12*],
)

#example(
  question: [
    求 $3 x^2 (6 - 2 x)$ 的最大值？
  ],
  answer: [#tab *24*],
)

#example(
  question: [
    【2021 天津卷】若 $a, b > 0$，则 $display(1/a + a/b^2 + b)$ 的最小值为 #blank()。
  ],
  answer: [#tab *$2 sqrt(2)$*],
)

== 基本不等式链

$
  2/display(1/a + 1/b) lt.eq sqrt(a b) lt.eq (a + b)/2 lt.eq sqrt((a^2 + b^2)/2) quad (a > 0, b > 0)
$

#align(center)[
  （调和平均值 $lt.eq$ 几何平均值 $lt.eq$ 算术平均值 $lt.eq$ 平方平均值）
]

#pagebreak()

= 基本不等式的基本运用

#align(center)[
  #text(fill: red, weight: "bold")[核心方法:换元法]
]

== 基本不等式之间的关系

+ $a + b$
+ $a b$
+ $a^2 + b^2$

#align(center)[
  #text(fill: red, weight: "bold")[时刻注意新变量的取值范围]
]

#example(
  question: [
    【2020 四川绵阳线上测试】已知 $a > 0, b > 0, 2 a + b = a b$，则当且仅当 $a =$ #blank() 时，$a b$ 取得最小值 #blank()。
  ],
  answer: [#tab *2* #tab *8*],
)

#example(
  question: [
    【2020 河南郑州质量预测】已知 $a > 0, b > 0, 2 a + b = 4$，则 $display(3/(a b))$ 的最小值为 #blank()。
  ],
  answer: [#tab *$display(3/2)$*],
)

#example(
  question: [
    【2020 山东烟台期中】已知 $x > 0, y > 0, x + 3 y + x y = 9$，则 $x + 3 y$ 的最小值为 #blank()。
  ],
  answer: [#tab *6*],
)

#example(
  question: [
    已知正实数 $x, y$ 满足 $x^2 + 4 y^2 + x + 2 y = 1$，则 $x y$ 的最大值为 #blank()。
  ],
  answer: [#tab *$display((2 - sqrt(3))/4)$*],
)

#example(
  question: [
    已知正实数 $a, b$ 满足 $(2 a + b)^2 = 1 + 6 a b$，则 $display((a b)/(2 a + b + 1))$ 的最大值为 #blank()。
  ],
  answer: [#tab *$display(1/6)$*],
)

#example(
  question: [
    已知正实数 $a, b$ 满足 $9 a^2 + b^2 = 1$，则 $display((a b)/(3 a + b))$ 的最大值为 #blank()。
  ],
  answer: [#tab *$display(sqrt(2)/12)$*],
)

#extend[
  #tab （1）$a^3 + b^3$ 与 $a^3 - b^3$
]

== $display(1/a + 1/b)$ 的应用与变形

#[
  #set enum(spacing: 2em)
  + $a + b = 1 ==> display(1/a + 1/b)$
  + $a + b = 4 (a > 1, b > 2) ==> display(1/(a - 1) + 1/(b - 2))$
  + $a + b = 1 (a > b > 0) ==> display(1/(a - b) + 1/b)$
  + $a + b = 1 ==> display((a + 1)^2/a + (b + 2)^2/b)$
  + $a + b = 1 ==> display(a^2/(a + 1) + b^2/(b + 2))$
  + $a + b = 1 ==> display(1/a + a/b)$
]

#example(
  question: [
    【2020 福建漳平第一中学月考】若 $m > 0, n > 0, m + n = 1$，且 $display(t/m + 1/n) (t > 0)$ 的最小值为 9，则 $t =$ #blank()。
  ],
  answer: [#tab *4*],
)

#example(
  question: [
    【2020 陕西咸阳期末】已知 $display(1/x + 2/y = 1) (x, y > 0)$，则 $2 x + y$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$10$],
    [$9$],
    [$8$],
    [$7$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    设 $a, b in bb(R), a^2 + b^2 = k$，且 $display(1/(a^2 + 1) + 4/(b^2 + 1))$ 的最小值为 1，则 $k$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$1$],
    [$4$],
    [$7$],
    [$9$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    设 $x > 1$，则 $x + display(4/(x - 1))$ 的最小值为 #blank()。
  ],
  answer: [#tab *5*],
)

#example(
  question: [
    设 $a gt.eq 0$，则 $a + display(1/(2 a + 5))$ 的最小值为 #blank()。
  ],
  answer: [#tab *$display(1/5)$*],
)

#example(
  question: [
    【2022 安徽部分重点高中高一联考】若 $x > 2$，则 $y = display((x^2 - 2 x + 4)/(x - 2))$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$4$],
    [$5$],
    [$6$],
    [$8$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    已知 $a > b > 0, a + b = 1$，则 $display(4/(a - b) + 1/(2 b))$ 的最小值为 #blank()。
  ],
  answer: [#tab *9*],
)

#example(
  question: [
    【2022 辽宁铁岭六校联考】若实数 $x + 3 y = 3 (x > 1, y > display(1/3))$，则 $display(x/(x - 1) + (3 y)/(3 y - 1))$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$6$],
    [$4$],
    [$3$],
    [$2$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    已知正实数 $x, y$ 满足 $2 x + y = 2$，则 $display((4 x^2)/(y + 1) + y^2/(2 x + 2))$ 的最小值为 #blank()。
  ],
  answer: [#tab *$display(4/5)$*],
)

#example(
  question: [
    【2020 吉林梅河口五中期中】若 $m, n > 0, m + 2 n = 1$，则 $display(1/m + (m + 1)/n)$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$4$],
    [$5$],
    [$7$],
    [$6$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2022 黑龙江大庆实验中学高一期末】已知 $0 < x < display(1/2)$，则 $display(1/x + (1 + 2 x)/(1 - 2 x))$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$5$],
    [$6$],
    [$7$],
    [$8$],
  ),
  answer: [#tab *C*],
)

== 简化思想与设值回代

#method("简化")[
  + 条件简化
  + 结论简化
]

#example(
  question: [
    【2022 天津部分区期末】已知 $a, b > 0, a + 2 b = 1$，则 $display(1/b + b/(2 a + b))$ 的最小值为 #blank()。
  ],
  answer: [#tab *$display(3/2 + sqrt(2))$*],
)

#example(
  question: [
    若正数 $a, b$ 满足 $2 a + display(1/b = 1)$，则 $display(2/a + b)$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$4 sqrt(2)$],
    [$8 sqrt(2)$],
    [$8$],
    [$9$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2022 湖北黄石期末】设 $x, y > 0$，且满足 $(x - display(1/y))^2 = display((16 y)/x)$，则当 $x + display(1/y)$ 取最小值时，$x^2 + display(1/y^2) =$ #blank()。
  ],
  answer: [#tab *12*],
)

#example(
  question: [
    【2022 云南曲靖一中二模（改编）】已知正数 $a, b$ 满足 $display(2/(3 a + b) + 1/(a + 2 b) = 4)$，则 $7 a + 4 b$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$display(9/4)$],
    [$5$],
    [$display((5 + 2 sqrt(2))/4)$],
    [$9$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2018 湖南长沙一中月考】设正实数 $a, b, c$ 满足 $a + 2 b + c = 1$，则 $display(1/(a + b) + (9(a + b))/(b + c))$ 的最小值为 #blank()。
  ],
  answer: [#tab *7*],
)

#example(
  question: [
    【2020 山东曲阜一中检测】已知实数 $a, b$ 满足 $a b > 0$，则 $display(a/(a + b) - a/(a + 2 b))$ 的最大值为（#h(3em)）
  ],
  choices: choices22(
    [$2 - sqrt(2)$],
    [$2 + sqrt(2)$],
    [$3 - 2 sqrt(2)$],
    [$3 + 2 sqrt(2)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    已知实数 $x, y$ 满足 $x^2 + display(y^2/16 = 1)$，则 $x sqrt(2 + y^2)$ 的最大值为 #blank()。
  ],
  answer: [#tab *$display(9/4)$*],
)

#method("设值回代")[
  #tab 针对需要求解的数学式，设其值为某个参数 $t$，将 $t$ 带入题目所给的约束条件，从而确定 $t$ 的范围。
]

#example(
  question: [
    【2020 山东烟台期中，同例 4-1-3】已知 $x > 0, y > 0, x + 3 y + x y = 9$，则 $x + 3 y$ 的最小值为 #blank()。
  ],
  answer: [#tab *6*],
)

#example(
  question: [
    非负实数 $x, y$ 满足 $x^2 + 4 y^2 + 4 x y + 4 x^2 y^2 = 32$

    （1）$x + 2 y$ 的最小值为多少？

    （2）求 $sqrt(7)(x + 2 y) + 2 x y$ 的最大值。
  ],
  answer: [
    *（1）4*

    *（2）16*
  ],
)

#example(
  question: [
    【2020 浙江萧山二中等校联考】已知 $a, b$ 是正实数，且 $a + 2 b - 3 a b = 0$，则 $a b$ 的最小值为 #blank()，$a + b$ 的最小值为 #blank()。
  ],
  answer: [#tab *$display(8/9)$* #tab *$1 + display((2 sqrt(2))/3)$*],
)

#example(
  question: [
    已知正实数 $x y + 2 x + 3 y = 42$，则 $x y + 5 x + 4 y$ 的最小值为 #blank()。
  ],
  answer: [#tab *55*],
)

#example(
  question: [
    已知实数 $x, y$ 满足 $x y - 2 = x + y$，且 $x > 1$，则 $y(x + 11)$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$21$],
    [$24$],
    [$25$],
    [$27$],
  ),
  answer: [#tab *D*],
)

#extend[
  + $a b + p dot a + n dot b + r = 0$ 的处理方式
]

== 齐次

回顾均值不等式：
$
      a + b & gt.eq 2 sqrt(a b) quad (a, b > 0) \
  (a + b)/2 & gt.eq sqrt(a b) quad (a, b > 0)
$
回顾 $a + b$ 与 $display(1/a + 1/b)$ 的不等关系

#method("齐次配平")[
  #tab 若题目中出现多个不同次数的项，可以尝试通过配平使得各项次数相同，从而使用均值不等式进行求解。
]

#example(
  question: [
    【2017 河南适应性测试】已知正数 $x, y$ 满足 $x + 4 y = 4$，则 $display((x + 28 y + 4)/(x y))$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$display(85/2)$],
    [$24$],
    [$20$],
    [$18$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2017 天津卷·文】若 $a b > 0$，则 $display((a^4 + 4 b^4 + 1)/(a b))$ 的最小值为 #blank()。
  ],
  answer: [#tab *4*],
)

#example(
  question: [
    【2020 天津卷】已知 $a, b > 0, a b = 1$，则 $display(1/(2 a) + 1/(2 b) + 8/(a + b))$ 的最小值为 #blank()。
  ],
  answer: [#tab *4*],
)

#example(
  question: [
    【2022 西南名校第一次诊断】已知 $x, y$ 为正实数，且 $x + y = 2$，则 $display(1/x + 1/(x y))$ 的最小值为 #blank()。
  ],
  answer: [#tab *$1 + display(sqrt(3)/2)$*],
)

#example(
  question: [
    已知 $x > y > 0, x + y = 3$，则 $display(1/(x - y) + (x y + y^2 + 2)/y)$ 的最小值为 #blank()。
  ],
  answer: [#tab *6*],
)

#example(
  question: [
    已知 $a, b, c > 0$，求证：$display(2((a + b)/2 - sqrt(a b)) lt.eq 3((a + b + c)/3 - root(3, a b c)))$
  ],
  answer: [#tab *略*],
)

#example(
  question: [
    已知 $a, b, c > 0, a + b + c = 1$，求证：$display((1/a - 1)(1/b - 1)(1/c - 1) gt.eq 8)$
  ],
  answer: [#tab *略*],
)

#method("构造 0 次式消元")[
  #tab 观察如果分式上下分母次数相同，则可以尝试该方法
]

#example(
  question: [
    已知 $x, y > 0$，则 $display((6 x y)/(x^2 + 9 y^2) + (2 x y)/(x^2 + y^2))$ 的最大值为 #blank()。
  ],
  answer: [#tab *$sqrt(3)$*],
)

#example(
  question: [
    已知正实数 $a, b$ 满足 $display(1/((2 a + b)b) + 2/((2 b + a)a) = 1)$，则 $a b$ 的最大值为 #blank()。
  ],
  answer: [#tab *$2 - display((2 sqrt(2))/3)$*],
)

#example(
  question: [
    【2018 江苏南京三模】若正数 $a, b, c$ 成等差数列（即 $a - b = b - c$），则 $display(c/(2 a + b) + b/(a + 2 c))$ 的最小值为 #blank()。
  ],
  answer: [#tab *$display((2 sqrt(5))/9)$*],
)

== 形变处理

对于陌生的形式，尝试设值，变换得到我们熟悉的形式。

#example(
  question: [
    【2020 湖南师范大学附属中学月考】设 $a > b > 0, a b = 2$，则 $a^2 + display(1/(a(a - b)))$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$1$],
    [$2$],
    [$3$],
    [$4$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2022 辽宁名校第四次联考】若 $a, b, c$ 均为正数，且 $c(a + b + c) + a b = 8$，则 $a + b + 2 c$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$2 sqrt(2)$],
    [$4$],
    [$4 sqrt(2)$],
    [$8 sqrt(2)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2022 浙江宁波二模】正实数 $a, b, c$ 互不相等，且满足 $a^2 + b^2 + c^2 = 2 a b + b c$，则下列结论正确的是（#h(3em)）
  ],
  choices: choices22(
    [$2 a > b > c$],
    [$2 a > c > b$],
    [$2 c > a > b$],
    [$2 c > b > a$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    若存在正实数 $y$，使得 $display((x y)/(y - x) = 1/(5 x + 4 y))$，则实数 $x$ 的最大值为 #blank()。
  ],
  answer: [#tab *$display(1/5)$*],
)

#example(
  question: [
    已知正实数 $a, b, c, d$ 满足 $a + b = 1, c + d = 1$，则 $display(1/(a b c) + 1/d)$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$10$],
    [$9$],
    [$4 sqrt(2)$],
    [$3 sqrt(3)$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    已知实数 $a, b, c$ 满足 $a^2 + b^2 + c^2 = 1$，则 $a b + c$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$-2$],
    [$-display(3/2)$],
    [$-1$],
    [$-display(1/2)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    若正数 $a, b, c$ 满足 $a b = a + 2 b, a b c = a + 2 b + c$，则 $c$ 的最大值为 #blank()。
  ],
  answer: [#tab *$display(8/7)$*],
)

#example(
  question: [
    已知 $x + y = display(1/x + 4/y + 8) (x, y > 0)$，则 $x + y$ 的最小值为（#h(3em)）
  ],
  choices: choices14(
    [$5 sqrt(3)$],
    [$9$],
    [$4 + 2 sqrt(26)$],
    [$10$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    已知正实数 $a, b$ 满足 $a + b = 1$，则 $display((2 a)/(a^2 + b) + b/(a + b^2))$ 的最大值为（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 1.5em,
    [$2$],
    [$1 + sqrt(2)$],
    [$1 + display((2 sqrt(3))/3)$],
    [$1 + display((3 sqrt(2))/3)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    已知正实数 $a, b, c$ 满足 $display(1/a + 1/b = 1/c), display(a/c + b/(c + b) > t)$，则 $t$ 的最大值为 #blank()。
  ],
  answer: [#tab *2*],
)

#example(
  question: [
    【2023 江西五市九校协作体第一次联考】已知 $a, b, c$ 是正实数，且 $b + c = sqrt(6)$，则 $display((a c^2 + 2 a)/(b c) + 8/(a + 1))$ 的最小值为 #blank()。
  ],
  answer: [#tab *6*],
)

== 总结回顾

+ 基本不等式及其简单应用

+ 核心处理手段：换元法

  善于设置新的变量来简化问题，得到自己熟悉的情况

  注意事项——新变量的取值范围

+ 基本思想：简化

  - 条件简化

  - 结论简化

  从简单情况入手。条件简单利用条件

+ 重要思想：齐次

+ 特殊处理方式：

  - 设值回代

  - 构造 0 次式

+ 注意事项：形变处理

#pagebreak()

= 基本不等式其他处理方式（\*）

#[
  #set par(spacing: 2.5em)

  #example(
    question: [
      若 $a, b, c$ 均为正实数，则 $display((a^2 + b^2 + c^2)/(a b + 2 b c))$ 的最小值为 #blank()。
    ],
    answer: [#tab *$display((2 sqrt(5))/5)$*],
  )

  #example(
    question: [
      已知 $x, y, z$ 均为正实数，且满足 $x^2 + y^2 + z^2 = 1$，则 $3 x y + y z$ 的最大值为 #blank()。
    ],
    answer: [#tab *$display(sqrt(10)/2)$*],
  )

  #example(
    question: [
      已知 $x, y, z$ 均为正实数，$2 x + 2 y + z = 1$，求证：$3 x y + y z + z x lt.eq display(1/5)$。
    ],
    answer: [#tab *略*],
  )

  #example(
    question: [
      若正数 $a, b, c$ 满足 $a^2 + b^2 + c^2 - a b - b c = 1$，则 $c$ 的最大值为 #blank()。
    ],
    answer: [#tab *$display(sqrt(6)/2)$*],
  )

  #example(
    question: [
      已知 $x + y + display(1/x + 1/(2 y) = 19/4) (x, y > 0)$，则 $display(3/x - 7/(16 y))$ 的最小值为 #blank()。
    ],
    answer: [#tab *$display(-1/4)$*],
  )

  #example(
    question: [
      已知 $a, b > 0$，记 $h = max { display(2/sqrt(a)), display((a^2 + b^2)/sqrt(a b)), display(2/sqrt(b)) }$，则 $h$ 的最小值为 #blank()。
    ],
    answer: [#tab *2*],
  )
]

#pagebreak()

= 不等式拓展（\*）

== 柯西不等式

$
  (a_1^2 + a_2^2 + ... + a_n^2)(b_1^2 + b_2^2 + ... + b_n^2) & gt.eq (a_1 b_1 + a_2 b_2 + ... + a_n b_n)^2 \
  i f f quad a_1/b_1 = a_2/b_2 = ... = a_n/b_n quad "取等号"
$

*常见形式*：
#[
  #set enum(spacing: 2em)
  + $n (a_1^2 + a_2^2 + ... + a_n^2) &gt.eq (a_1 + a_2 + ... + a_n)^2$
  + $(display(a_1^2/b_1 + a_2^2/b_2 + ... + a_n^2/b_n)) &gt.eq display((a_1 + a_2 + ... + a_n)^2/(b_1 + b_2 + ... + b_n))$
]

#v(0.5em)

#example(
  question: [
    已知 $display(x^2/16 + y^2/5 + z^2/4 = 1)$，求 $x + y + z$ 的取值范围。
  ],
  answer: [#tab *$[-5, 5]$*],
)

#example(
  question: [
    已知 $a, b, c$ 均为正实数，且 $a + b + c = 1$，求证：

    （1） $a^2 + b^2 + c^2 gt.eq display(1/3)$

    （2） $a b + b c + c a lt.eq display(1/3)$

    （3） $sqrt(3 a + 2) + sqrt(3 b + 2) + sqrt(3 c + 2) lt.eq 3 sqrt(3)$

    （4） $display(a^2/b + b^2/c + c^2/a gt.eq 1)$
  ],
  answer: [#tab *略*],
)

#example(
  question: [
    已知 $a, b, c$ 为三角形三边长，求证：$display((sqrt(a) + sqrt(b) + sqrt(c))^2/(a + b + c) > 2)$
  ],
  answer: [#tab *略*],
)

#example(
  question: [
    已知 $a, b, c$ 均为正实数，且 $a b c = 1$，求证：$sqrt(a) + sqrt(b) + sqrt(c) lt.eq display(1/a + 1/b + 1/c) lt.eq a^2 + b^2 + c^2$
  ],
  answer: [#tab *略*],
)

== 排序不等式

若
$
  a_1 lt.eq a_2 lt.eq ... lt.eq a_n, b_1 lt.eq b_2 lt.eq ... lt.eq b_n
$
则对于
$ (a_1, a_2, ..., a_n) $
的任何其他轮换
$ (x_1, x_2, ..., x_n) $
都有：
$
  a_1 b_n + a_2 b_{n - 1} + ... + a_n b_1 lt.eq x_1 b_1 + x_2 b_2 + ... + x_n b_n lt.eq a_1 b_1 + a_2 b_2 + ... + a_n b_n
$
即：*反序和 $lt.eq$ 乱序和 $lt.eq$ 正序和*。


// ==================== 在文档末尾显示所有答案 ====================
#show-answers()
