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
  answer: [
    *C*

  ],
)

#example(
  question: [
    已知 $a > b, a b > 0$，则 $display(1/a)$ #blank() $display(1/b)$
  ],
  answer: [
    *$<$*

  ],
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
    [$(2, display(11/4))$],
    [$[2, display(11/4))$],
    [$(- infinity, 2) union (display(11/4), + infinity)$],
    [$(- infinity, 2] union (display(11/4), + infinity)$],
  ),
  answer: [
    *B*

  ],
)

#example(
  question: [
    【2020 四川泸县上学期】已知关于 $x$ 的不等式 $a x^2 + b x + c > 0$ 的解集为 $(2, 3)$，则关于 $x$ 的不等式 $c x^2 + b x + a < 0$ 的解集为 #blank()。
  ],
  answer: [
    *$(- infinity, display(1/3)) union (display(1/2), + infinity)$*

  ],
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
  answer: [
    *A、B、D*

  ],
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
  answer: [
    *C*

  ],
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
  answer: [
    *D*

  ],
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
  answer: [
    *C*

  ],
)

#example(
  question: [
    【2022 浙江五校联考】已知关于 $x$ 的不等式 $a x^2 - 2 x + 3 a < 0$ 在 $(0, 2]$ 上有解，则实数 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    [$(- infinity, display(sqrt(3)/3))$],
    [$(- infinity, display(4/7))$],
    [$(display(sqrt(3)/3), + infinity)$],
    [$(display(4/7), + infinity)$],
  ),
  answer: [
    *A*

  ],
)

#example(
  question: [
    【2020 黑龙江齐齐哈尔第八中学月考】已知关于 $x$ 的不等式 $a x^2 - (a + 1) x < -a + 13 x$ 在区间 $[2, 3]$ 上恒成立，则实数 $a$ 的取值范围是 #blank()。
  ],
  answer: [
    *$(-infinity, 6)$*

  ],
)



// ==================== 在文档末尾显示所有答案 ====================
#show-answers()
