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
  cover: image("image/cover.jpg", width: 100%), // 请确保有对应的封面图片，或替换为 none
  title: [第3章],
  subtitle: [函数的应用],
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

= 函数性质

#introduction[单调性+其他][奇偶性][周期性+对称性][综合应用]

== 单调性+其他

#method("")[
  #tab 借助函数 $f(x)$ 的单调性，通过 $f(x)$ 的大小判断 $x$ 的大小。
]

#example(
  question: [
    已知函数 $f(x)$ 在 $bb(R)$ 上单调递增，且 $f(a) lt.eq f(2-a)$，则 $a$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$(-infinity, 1]$*],
)

#example(
  question: [
    已知函数 $f(x) = x^3 - e^(-x)$，$f(a) lt.eq f(2-a)$，则 $a$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$(-infinity, 1]$*],
)

#example(
  question: [
    【2017全国卷I】已知函数 $f(x)$ 在 $bb(R)$ 上单调递减，且为奇函数，若 $f(1) = -1$，则满足 $-1 lt.eq f(x-2) lt.eq 1$ 的 $x$ 的取值范围是（#h(3em)）
  ],
  choices: choices14(
    [$[-2, 2]$],
    [$[-1, 1]$],
    [$[0, 4]$],
    [$[1, 3]$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2024 北京市西城区第五十六中学届高三数学一模】已知函数 $f(x) = log_2 (display(1/abs(x)) + 1) + sqrt(display(1/x^2) + 3)$，则不等式 $f(lg x) > 3$ 的解集为（#h(3em)）
    #v(0.5em)
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display((1/10, 10))$],
    [$display((-infinity, 1/10) union (10, +infinity))$],
    [$(1, 10)$],
    [$display((1/10, 1) union (1, 10))$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    定义在 $(-1, 1)$ 上的奇函数 $f(x)$ 在 $[0, 1)$ 为增函数，则 $f(x) + f(2x-1) < 0$ 的解集为 #blank()。
  ],
  answer: [#tab *$display((0, 1/3))$*],
)

#example(
  question: [
    【2020 山东烟台诊断】已知函数 $f(x) = display((e^x - e^(-x))/(e^x + e^(-x)))$，实数 $m, n$ 满足 $f(2m-n) + f(2-n) > 0$，则下列不等关系成立的是（#h(3em)）
  ],
  choices: choices22(
    [$m+n > 1$],
    [$m+n < 1$],
    [$m-n > -1$],
    [$m-n < -1$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    已知定义在 $bb(R)$ 上的函数 $f(x) = 2024^x - log_2024 (sqrt(x^2+1) - x) - 2024^(-x) + 2$，则不等式 $f(3x+1) + f(x) gt.eq 4$ 的解集为 #blank()。
  ],
  answer: [#tab *$display([-1/4, +infinity))$*],
)

#example(
  question: [
    【2025北京6年高考3年模拟改编】已知函数 $f(x) = ln display((1+x)/(1-x)) + x + 1$，且 $f(a) + f(a+1) > 2$，则实数的取值范围是（#h(3em)）
  ],
  choices: choices14(
    [$display((-1, -1/2))$],
    [$display((-1/2, 0))$],
    [$display((0, 1/2))$],
    [$display((1/2, 1))$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2023 江苏淮安高一期中】函数 $f(x)$ 为定义在 $bb(R)$ 上的偶函数，$g(x) = f(x) - x^2 + 2$ 在区间 $(-infinity, 0]$ 上单调递减，则不等式 $f(x) - f(x-2) > 4x - 4$ 的解集为 #blank()。
  ],
  answer: [#tab *$(1, +infinity)$*],
)

#example(
  question: [
    【2024四川成都校考三模】已知函数 $f(x) = e^(x-2) + e^(2-x) + 2x^2 - 8x + 7$，则不等式 $f(2x+3) > f(x+2)$ 的解集为（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display((-1, -1/3))$],
    [$display((-infinity, -1) union (-1/3, +infinity))$],
    [$display((-1/3, 1))$],
    [$display((-infinity, -1/3) union (1, +infinity))$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2024 黑龙江哈尔滨哈九中校考模拟预测】已知函数 $f(x) = sin(2x-2) + e^(1-x) - e^(x-1) + 2$，若 $f(a^2+1) + f(2a-2) > 4$，则实数范围是（#h(3em)）
  ],
  choices: choices22(
    [$(-infinity, -3)$],
    [$(-infinity, -3) union (1, +infinity)$],
    [$(-3, 1)$],
    [$(1, +infinity)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    已知函数 $f(x) = display(cases(x^3 - 2x^2 - 5 \, & x < 0, 4^(x+2022) \, & x gt.eq 0))$，则不等式 $display(f(x + 7/2) < 8 f(x^2))$ 的解集为 #blank()。
  ],
  answer: [#tab *$(-infinity, -1) union (2, +infinity)$*],
)

#think[
  1. 上述题目有什么相似之处？请说出你的观点。
]

== 奇偶性

#example(
  question: [
    【2024 福建省福州格致中学高三下学期期中考】已知 $f(x) = a ln(x + sqrt(1+x^2)) + b sin x + 2$，若 $f(-3) = 7$，则 $f(3)$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$-7$],
    [$-5$],
    [$-3$],
    [无法确定],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2024 重庆巴蜀中学高三适应性月考】已知函数 $f(x) = display(pi/4) + cos x dot ln(x + sqrt(1+x^2))$ 在区间 $[-5, 5]$ 上的最大值是 $M$，最小值是 $N$，则 $f(M+N)$ 的值等于（#h(3em)）
  ],
  choices: choices14(
    [$0$],
    [$10$],
    [$display(pi/4)$],
    [$display(pi/2)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2024全国高三专题练习】已知函数 $f(x) = |x| + e^x + e^(-x) + a$ 有唯一零点，则实数 $a$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$1$],
    [$-1$],
    [$2$],
    [$-2$],
  ),
  answer: [#tab *D*],
)

#think[
  1. 上述题目可以获得什么结论？
    - 奇函数：#blank(width: 20em)
    - 偶函数：#blank(width: 20em)
]

== 周期性+对称性

#example(
  question: [
    【2022福建厦门二检】(多选) 定义在 $bb(R)$ 上的奇函数 $f(x)$ 满足 $f(x+2) = -f(x)$，且当 $x in (0, 1]$ 时，$f(x) = 1-x$，则（#h(3em)）
  ],
  choices: choices22(
    [$f(x)$ 是周期函数],
    [$f(x)$ 在 $(-1, 1)$ 上单调递减],
    [$f(x)$ 图像关于直线 $x=3$ 对称],
    [$f(x)$ 的图像关于点 $(2, 0)$ 对称],
  ),
  answer: [#tab *ACD*],
)

#example(
  question: [
    【2023-2024江苏省南京市南京师大附中高一上期末】(多选) 已知 $f(x)$ 为定义在 $bb(R)$ 上的偶函数，当 $x gt.eq 0$ 时，有 $f(x+1) = -f(x)$，且当 $x in [0, 1)$ 时，$f(x) = log_2 (x+1)$。下列命题正确的是（#h(3em)）
  ],
  choices: choices22(
    [$f(2023) + f(-2024) = 0$],
    [$f(x)$ 是周期为 2 的周期函数],
    [直线 $y=x$ 与 $f(x)$ 有且仅有 2 个交点],
    [$f(x)$ 的值域为 $(-1, 1)$],
  ),
  answer: [#tab *AD*],
)

#example(
  question: [
    【2024山东滨州统考二模】函数 $y=f(x)$ 在区间 $(-infinity, +infinity)$ 上的图象是一条连续不断的曲线，且满足 $f(3+x) - f(3-x) + 6x = 0$，函数 $f(1-2x)$ 的图象关于点 $(0, 1)$ 对称，则（#h(3em)）
  ],
  choices: choices22(
    [$f(x)$ 的图象关于点 $(1, 1)$ 对称],
    [$8$ 是 $f(x)$ 的一个周期],
    [$f(x)$ 一定存在零点],
    [$f(101) = -299$],
  ),
  answer: [#tab *ACD*],
)

#think[
  1. 上述题目体现了对称性和周期性的什么关系？
]

== 综合应用

#example(
  question: [
    【2025北京5年高考3年模拟】设 $f(x) = 2|x-1| + log_3 (x-1)^2$，不等式 $f(a x) lt.eq f(x+3)$ 在 $x in (1, 2]$ 上恒成立，则实数的取值范围是（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display((-infinity, 5/2))$],
    [$(100, 2]$],
    [$display([-1, 5/2])$],
    [$display([-3/2, 1/2) union [1, 5/2])$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2024广东省湛江市第一中学高一上期末多选压轴】(多选) 已知函数 $f(x) = ln(sqrt(x^2+1) + x) + x + 1$，则下列说法正确的是（#h(3em)）
  ],
  choices: choices41(
    row-gutter: 1.2em,
    [$f(lg 3) + f(lg display(1/3)) = 2$],
    [函数 $f(x)$ 的图象关于点 $(0, 1)$ 对称],
    [函数 $f(x)$ 在定义域上单调递减],
    [若实数 $a, b$ 满足 $f(a) + f(b) > 2$，则 $a+b > 0$],
  ),
  answer: [#tab *ABD*],
)

#example(
  question: [
    【2024重庆市西南大学附属中学校高一上期末多选次压轴】(多选) 已知函数 $f(x) = log_2 (sqrt(x^2+1) - x) + 3$，则下列说法正确的是（#h(3em)）
  ],
  choices: choices41(
    row-gutter: 1.2em,
    [函数 $f(x)$ 的图象关于点 $(0, 3)$ 对称],
    [$f(ln 2) + f(ln display(1/2)) = 6$],
    [函数 $f(x)$ 在定义域上单调递增],
    [若实数 $a, b$ 满足 $f(a) + f(b) > 6$，则 $a+b < 0$],
  ),
  answer: [#tab *ABD*],
)

#example(
  question: [
    【2025北京6年高考3年模拟】已知函数 $f(x)$ 是定义在 $bb(R)$ 上的偶函数，且在 $(-infinity, 0]$ 上单调递增，若 $f(2) = 0$，则不等式 $(x^2-4)f(x) < 0$ 的解集为（#h(3em)）
  ],
  choices: choices22(
    [$(-infinity, -2) union (2, +infinity)$],
    [$bb(R)$],
    [$(-infinity, -2) union (-2, 2) union (2, +infinity)$],
    [$emptyset$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2024北京交大附中月考, 14】已知函数 $f(x) = display((2^x + m)/(2^x + 1))$

    (1) 当 $m=0$ 时，$f(x)$ 的值域为 #blank()；

    (2) 若对于任意 $a, b, c in bb(R)$，$f(a), f(b), f(c)$ 的值总可作为某一个三角形的三边长，则实数 $m$ 的取值范围是 #blank()。
  ],
  answer: [
    *(1) $(0, 1)$*

    *(2) $display([1/2, 2])$*
  ],
)

#think[
  1. 上述所有题目涉及到的函数性质有哪些？
  2. 关于函数性质的考查，说出你的理解。
]

#pagebreak()

= 处理手段

#introduction[分离参数][数形结合][连等设值][嵌套处理][构造函数][函数同构]

== 分离参数

对于含有参数的不等式
$ f(x) dot a < g(x) $
将参数分离，得到不等式
$ a < display(g(x)/f(x)) $
从而研究
$ h(x) = display(g(x)/f(x)) $
的最值。

#example(
  question: [
    【2024全国高三专题练习】若关于 $x$ 的不等式 $a x^2 - 2 x + a lt.eq 0$ 在区间 $[0, 4]$ 上有解，则实数 $a$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$(-infinity, 1]$*],
)

#example(
  question: [
    【2025北京6年高考3年模拟】设函数 $f(x) = m x^2 - m x - 1$，若对于 $x in [1, 3]$，$f(x) < -m + 4$ 恒成立，则实数 $m$ 的取值范围为（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$(-infinity, 0]$],
    [$display((0, 5/7))$],
    [$display((-infinity, 0) union (0, 5/7))$],
    [$display((-infinity, 5/7))$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2024全国高三专题练习】若不等式 $2 x - 1 > m(x^2 - 1)$ 对任意 $m in [-1, 1]$ 恒成立，实数 $x$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$(sqrt(3) - 1, 2)$*],
)

#think[
  1. 分离参数能解决所有含参问题吗？
  2. 你认为分离参数的适用条件是什么？
]

== 数形结合

#method("")[
  #tab 借助函数图像，判断方程、图像交点等问题。
]

#example(
  question: [
    【2024 北京平谷零模, 15】已知函数 $f(x) = display(cases(|x| \, & x lt.eq m, x^2 - 2 m x + 4 m \, & x > m))$，设 $g(x) = f(x) - b$。给出下列四个结论：

    ① 当 $m = 4$ 时，$f(x)$ 不存在最小值；

    ② 当 $0 < m lt.eq 3$ 时，$f(x)$ 在 $(0, +infinity)$ 上为增函数；

    ③ 当 $m < 0$ 时，存在实数 $b$，使得 $g(x)$ 有三个零点；

    ④ 当 $m > 3$ 时，存在实数 $b$，使得 $g(x)$ 有三个零点。

    其中正确结论的序号是 #blank()。
  ],
  answer: [#tab *②④*],
)

#example(
  question: [
    【2024 北京西城期末, 15】设 $a in bb(R)$，函数 $f(x) = display(cases(-x^3 \, & x > a, -x^2 + a^2 \, & x lt.eq a))$。给出下列四个结论：

    ① $f(x)$ 在区间 $(0, +infinity)$ 上单调递减；

    ② 当 $a gt.eq 0$ 时，$f(x)$ 存在最大值；

    ③ 当 $a < 0$ 时，直线 $y = a x$ 与曲线 $y = f(x)$ 恰有 3 个交点；

    ④ 存在正数 $a$ 及点 $M(x_1, f(x_1)) (x_1 > a)$ 和 $N(x_2, f(x_2)) (x_2 lt.eq a)$，使 $|M N| lt.eq display(1/100)$。

    其中正确结论的序号是 #blank()。
  ],
  answer: [#tab *①②④*],
)

#example(
  question: [
    【2021北京卷, 15】已知函数 $f(x) = |lg x| - k x - 2$，给出下列四个结论：

    ① 当 $k = 0$ 时，$f(x)$ 恰有 2 个零点；

    ② 存在负数 $k$，使得 $f(x)$ 恰有 1 个零点；

    ③ 存在负数 $k$，使得 $f(x)$ 恰有 3 个零点；

    ④ 存在正数 $k$，使得 $f(x)$ 恰有 3 个零点。

    其中正确结论的序号是 #blank()。
  ],
  answer: [#tab *①②④*],
)

#example(
  question: [
    【2025北京5年高考3年模拟】已知函数 $f(x) = display(cases(x^3 \, & x gt.eq 0, -x \, & x < 0))$，若函数 $g(x) = f(x) - |k x^2 - 2 x| (k in bb(R))$ 恰有 4 个零点，则 $k$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display((-infinity, -1/2) union (2 sqrt(2), +infinity))$],
    [$display((-infinity, -1/2) union (0, 2 sqrt(2)))$],
    [$display((-infinity, 0) union (0, 2 sqrt(2)))$],
    [$display((-infinity, 0) union (2 sqrt(2), +infinity))$],
  ),
  answer: [#tab *D*],
)

== 连等设值

对于
$ f(x_1) = f(x_2) = f(x_3) $
的问题，令
$ f(x_1) = f(x_2) = f(x_3) = t $
从而使用 $t$ 表示 $x_1, x_2, x_3$ 的关系。

#example(
  question: [
    【2017全国卷I】设 $x, y, z$ 均为正数，且 $2^x = 3^y = 5^z$，则（#h(3em)）
  ],
  choices: choices14(
    [$2x < 3y < 5z$],
    [$5z < 2x < 3y$],
    [$3y < 5z < 2x$],
    [$3y < 2x < 5z$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2023 重庆第八中学期中】(多选) 已知正数 $x, y, z$ 满足 $3^x = 4^y = 12^z$，则（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display(1/x + 1/y = 1/z)$],
    [$6z < 3x < 4y$],
    [$x y < 4 z^2$],
    [$x + y > 4z$],
  ),
  answer: [#tab *ABD*],
)

#example(
  question: [
    【2024 北京朝阳一模, 13】已知函数 $f(x) = display(cases(|x-1| \, & x lt.eq 2, 5-x \, & x > 2))$，若实数 $a, b, c (a < b < c)$ 满足 $f(a) = f(b) = f(c)$，则 $a + b$ 的值为 #blank()，$a + b + c$ 的取值范围是 #blank()。
  ],
  answer: [#tab *2* #tab $[6, 7)$],
)

#example(
  question: [
    设函数 $f(x) = display(cases(|2^x - 1| \, & x lt.eq 2, -x + 5 \, & x > 2))$，若互不相等的实数 $a, b, c$ 满足 $f(a) = f(b) = f(c)$，则 $2^a + 2^b + 2^c$ 的取值范围是（#h(3em)）
  ],
  choices: choices14(
    [$(16, 32)$],
    [$(18, 34)$],
    [$(17, 35)$],
    [$(6, 7)$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2024北京6年高考3年模拟】已知函数 $f(x) = display(cases(x + display(4/x) \, & 0 < x < 4, -x^2 + 10 x - 20 \, & x gt.eq 4))$，若存在实数 $a, b, c$ 满足 $f(a) = f(b) = f(c)$，则 $(a b + 1)^c$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$(16, 64)$*],
)

#example(
  question: [
    【2024北京6年高考3年模拟】已知函数 $f(x) = display(cases(|log_4 x| \, & 0 < x lt.eq 4, -display(1/2) x + 3 \, & x > 4))$，若存在实数 $a, b, c, d in (0, +infinity)$ 且 $a < b < c < d$，满足 $f(a) = f(b) = f(c) = f(d)$，则 $a b c d$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$(96, 100)$*],
)

#example(
  question: [
    【2024全国高三专题练习】已知函数 $f(x) = display(cases((x + 1)^2 \, & x lt.eq 0, |log_2 x| \, & x > 0))$，若方程 $f(x) = a$ 有四个不同的解 $x_1, x_2, x_3, x_4$，且 $x_1 < x_2 < x_3 < x_4$，则 $x_3 (x_1 + x_2) + display(1/(x_3^2 x_4))$ 的取值范围是（#h(3em)）
  ],
  choices: choices14(
    [$(-1, 1]$],
    [$[-1, 1]$],
    [$[-1, 1)$],
    [$(-1, 1)$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2024 浙江省温州市高一上期末A卷】函数 $f(x) = x^4 - 24 x + 16, g(x) = 6 x^3 + a x^2$，方程 $f(x) = g(x)$ 恰有三个根 $x_1, x_2, x_3$，其中 $x_1 < x_2 < x_3$，则 $(x_1 + display(1/x_1)) (x_2 + x_3)$ 的值为 #blank()。
  ],
  answer: [#tab *-25*],
)

#think[
  1. 连等设值的好处是什么？
]

== 嵌套处理

针对
$ h(x) = f(g(x)) $
的情况，分为两步处理：
$ h(x) = f(t) \ t = g(x) $

#example(
  question: [
    【2024全国高三专题练习】已知不等式 $4^x - a dot 2^x + 2 > 0$，对于 $a in (-infinity, 3]$ 恒成立，则实数 $x$ 的取值范围是 #blank()。
  ],
  answer: [#tab *$(-infinity, 0) union (1, +infinity)$*],
)

#example(
  question: [
    已知函数 $f(x) = display(cases(k x + 1 \, & x lt.eq 0, log_2 x \, & x > 0))$，下列是关于函数 $y = f(f(x)) + 1$ 的零点个数的判断，其中正确的是（#h(3em)）
  ],
  choices: choices22(
    [当 $k > 0$ 时，有 3 个零点],
    [当 $k < 0$ 时，有 2 个零点],
    [当 $k > 0$ 时，有 4 个零点],
    [当 $k < 0$ 时，有 1 个零点],
  ),
  answer: [#tab *CD*],
)

#example(
  question: [
    【2016浙江卷】已知函数 $f(x) = x^2 + b x$，则“$b < 0$”是“$f(f(x))$ 的最小值与 $f(x)$ 的最小值相等”的（#h(3em)）
  ],
  choices: choices22(
    [充分不必要条件],
    [必要不充分条件],
    [充分必要条件],
    [既不充分也不必要条件],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2023北京朝阳二模, 10】已知函数 $f(x)$ 是 $bb(R)$ 上的奇函数，当 $x < 0$ 时，$f(x) = 4 - 2^(-x)$。若关于 $x$ 的方程 $f(f(x)) = m$ 有且仅有两个不相等的实数解，则实数 $m$ 的取值范围是（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$(-infinity, -3] union [3, +infinity)$],
    [$[-3, 0) union (0, 3]$],
    [$(-4, -3] union [3, 4)$],
    [$(-infinity, -4) union (4, +infinity)$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2025北京6年高考3年模拟】已知函数 $f(x) = display(cases(x^2 - 2 x + 4 \, & x lt.eq 0, ln x \, & x > 0))$，若函数 $g(x) = f^2(x) + 3 f(x) + m (m in bb(R))$ 有三个零点，则 $m$ 的取值范围为（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display(m lt.eq 9/4)$],
    [$m lt.eq -28$],
    [$display(-28 lt.eq m < 9/4)$],
    [$m > 28$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2024 四川资阳高三统考期末】定义在 $bb(R)$ 上函数 $f(x) = display(cases(-x^2 \, & x in (0, 1), e^(x-1) - 2 \, & x in [1, +infinity)))$，且函数 $y = f(x-1)$ 关于点 $(1, 0)$ 对称。若关于 $x$ 的方程 $f^2(x) - 2 m f(x) = 1 (m in bb(R))$ 有 $n$ 个不同的实数解，则 $n$ 的所有可能的值为（#h(3em)）
  ],
  choices: choices14(
    [$2$],
    [$4$],
    [$2$ 或 $4$],
    [$2$ 或 $4$ 或 $6$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2024 全国高三专题练习】已知函数 $f(x) = |2^abs(x) - 2| - 1$，则关于 $x$ 的方程 $f^2(x) + m f(x) + n = 0$ 有 7 个不同实数解，则实数 $m, n$ 满足（#h(3em)）
  ],
  choices: choices22(
    [$m > 0, n > 0$],
    [$0 < m < 1, n = 0$],
    [$m < 0$ 且 $n > 0$],
    [$-1 < m < 0$ 且 $n = 0$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2024 全国高三专题练习】已知函数 $f(x) = display(cases(x^2 + display(1/2) x \, & x lt.eq 0, -|2x - 1| + 1 \, & x > 0))$，若关于 $x$ 的方程 $f^2(x) - (k + 1) x f(x) + k x^2 = 0$ 有且只有三个不同的实数解，则正实数 $k$ 的取值范围为（#h(3em)）
  ],
  choices: choices22(
    row-gutter: 2em,
    [$display((0, 1/2))$],
    [$display([1/2, 1) union (1, 2))$],
    [$display((0, 1) union (1, 2))$],
    [$display((2, +infinity))$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2024 全国高三专题练习】已知函数 $f(x) = x^2 e^(2x) + (a - 1) x e^x + 1 - a$ 有三个不同的零点 $x_1, x_2, x_3$，其中 $x_1 < x_2 < x_3$，则 $(1 - x_1 e^(x_1))(1 - x_2 e^(x_2))(1 - x_3 e^(x_3))^2$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$1$],
    [$(a - 1)^2$],
    [$-1$],
    [$1 - a$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2024全国高三专题练习】已知函数 $f(x) = (a x + ln x)(x - ln x) - x^2$ 有三个不同的零点，其中 $x_1 < x_2 < x_3$，则 $(1 - display((ln x_1)/x_1))^2 (1 - display((ln x_2)/x_2)) (1 - display((ln x_3)/x_3))$ 的值为（#h(3em)）
  ],
  choices: choices14(
    [$a - 1$],
    [$1 - a$],
    [$-1$],
    [$1$],
  ),
  answer: [#tab *D*],
)

== 构造函数

#method("")[
  #tab 将条件中的某个式子看成整体，构造新的函数进行研究。
]

#example(
  question: [
    【2024江苏省盐城市第一中学高一上期末】已知 $f(x)$ 为 $bb(R)$ 上的奇函数，$f(2) = 2$，若对于 $forall x_1, x_2 in (0, +infinity)$，当 $x_1 > x_2$ 时，都有 $(x_1 - x_2) [display(f(x_1)/x_2) - display(f(x_2)/x_1)] < 0$，则不等式 $(x + 1) f(x + 1) > 4$ 的解集为（#h(3em)）
  ],
  choices: choices22(
    [$(-3, 1)$],
    [$(-3, -1) union (-1, 1)$],
    [$(-infinity, -1) union (-1, 1)$],
    [$(-infinity, -1) union (3, +infinity)$],
  ),
  answer: [#tab *B*],
)

#example(
  question: [
    【2024广东省广州市高一上九区联考填空压轴】设 $f(x)$ 是定义在 $bb(R)$ 上的奇函数，对任意的 $x_1, x_2 in (0, +infinity), x_1 eq.not x_2$ 满足 $display((x_2 f(x_1) - x_1 f(x_2))/(x_1 - x_2) > 0)$，若 $f(2) = 4$，则不等式 $f(x) - 2 x lt.eq 0$ 的解集为 #blank()。
  ],
  answer: [#tab *$[0, 2] union (-infinity, -2]$*],
)

#example(
  question: [
    【2024江苏省盐城市五校联盟高一上期中】已知函数 $f(x) = x^2 - x$，若对于任意的 $x_1, x_2 in [1, +infinity)$，且 $x_1 < x_2$，都有 $x_2 f(x_1) - x_1 f(x_2) > a x_1 x_2 (x_2^2 - x_1^2)$ 成立，则 $a$ 的取值范围是（#h(3em)）
  ],
  choices: choices14(
    [$display((0, +infinity))$],
    [$display([-1/2, 0])$],
    [$display([-1/2, +infinity))$],
    [$display((-infinity, -1/2))$],
  ),
  answer: [#tab *D*],
)

== 函数同构

#method("")[
  #tab 寻找出条件中具有结构相同的式子，研究其结构特点与对应的参数。
]

#example(
  question: [
    【2023 北京人大附中高一月考】已知 $x > 0, y > 0$，且 $(sqrt(x))^3 + 2022 sqrt(x) = a$，$(sqrt(y) - 2)^3 + 2022(sqrt(y) - 2) = -a$，则 $x + y$ 的最小值是（#h(3em)）
  ],
  choices: choices14(
    [$1$],
    [$sqrt(2)$],
    [$2$],
    [$4$],
  ),
  answer: [#tab *C*],
)

#example(
  question: [
    【2024黑龙江哈尔滨哈尔滨三中校考模拟预测】已知实数 $x, y$ 满足 $ln sqrt(2y+1) + y = 2, e^x + x = 5$，则 $x + 2 y$ 的值为 #blank()。
  ],
  answer: [#tab *4*],
)

#example(
  question: [
    【2024广东省佛山市高一上期末填空压轴】已知 $2^x = 11 - 3 x, log_2 (6y - 1) = 4 - 2 y$，则 $x + 2 y$ 的值为 #blank()。
  ],
  answer: [#tab *4*],
)

#example(
  question: [
    【2024湖南省长沙市长郡中学高一上期末压轴】若实数 $x_1, x_2$ 满足 $e^x_1 + x_1 - 2 = 0, x_2 ln x_2 + 2 x_2 - 1 = 0$，则 $x_2 (2 - x_1)$ 的值为 #blank()。
  ],
  answer: [#tab *1*],
)

#example(
  question: [
    【2024江苏省南京市南京师大附中高一上期末填空压轴】设 $a$ 为实数，若实数 $x_0$ 是关于 $x$ 的方程 $e^x + (1 - a) x = ln a + ln x$ 的解，则 $display((e^(x_0 - 1))/(a x_0)) =$ #blank()。
  ],
  answer: [#tab *$display(1/e)$*],
)

#example(
  question: [
    【2020全国课标Ⅰ卷, 理】若 $2^a + log_2 a = 4^b + 2 log_4 b$，则（#h(3em)）
  ],
  choices: choices14(
    [$a > 2b$],
    [$a < 2b$],
    [$a > b^2$],
    [$a < b^2$],
  ),
  answer: [#tab *B*],
)

#pagebreak()

= 特殊问题

#introduction[比较大小][抽象函数]

== 比较大小

*基本方式：*
+ 作差。
+ 作商。
+ 单调性。


=== 区间比较问题

#method("")[
  #tab 判断数的大致区间，依据区间位置比较大小。
]

#example(
  question: [
    【2023 山东临沂平邑一中高一期末】已知 $a = log_2 0.3, b = 2^0.2, c = 0.2^0.3$，则（#h(3em)）
  ],
  choices: choices14(
    [$a < b < c$],
    [$b < c < a$],
    [$c < a < b$],
    [$a < c < b$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2024广东省华南师范大学附属中学高一上期末次压轴】已知 $a = ln 2, b = sin display((6 pi)/7), c = 3^(1/2)$，则 $a, b, c$ 的大小关系是（#h(3em)）
  ],
  choices: choices14(
    [$a > b > c$],
    [$a > c > b$],
    [$c > b > a$],
    [$c > a > b$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2024 北京西城二模, 5】设 $a = lg display(2/3), b = sqrt(lg 3 dot lg 2), c = display(1/2) lg 6$，则（#h(3em)）
  ],
  choices: choices14(
    [$a < b < c$],
    [$b < a < c$],
    [$a < c < b$],
    [$b < c < a$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2024 广东省深圳市南山区高一上期末质量监测】已知 $a = sin 1 + cos 1, b = log_(cos 1) sin 1, c = 2^(cos 1)$，则（#h(3em)）
  ],
  choices: choices14(
    [$c > a > b$],
    [$a > b > c$],
    [$c > b > a$],
    [$a > c > b$],
  ),
  answer: [#tab *A*],
)

=== 单调性比较问题

#method("")[
  #tab 相同结构的两个数，构造函数依据单调性比较大小。
]

#example(
  question: [
    【2024广东省佛山市高一上期末单选压轴】已知 $2^a = 5,3^b = 10,4^c = 17$，则 $a, b, c$ 的大小关系为（#h(3em)）
  ],
  choices: choices14(
    [$a < b < c$],
    [$b < c < a$],
    [$c < a < b$],
    [$c < b < a$],
  ),
  answer: [#tab *D*],
)

#example(
  question: [
    【2024 重庆市南开中学校高一上期末单选压轴】已知 $5-a = ln a, b = log_4 3 + log_9 17, 7^b + 24^b = 25^c$，则以下关于 $a, b, c$ 的大小关系正确的是（#h(3em)）
  ],
  choices: choices14(
    [$b > c > a$],
    [$a > c > b$],
    [$b > a > c$],
    [$a > b > c$],
  ),
  answer: [#tab *D*],
)

=== 数形结合问题

#method("")[
  #tab 做出图像，依据交点位置比较大小。
]

#example(
  question: [
    【2023 天津部分区期中】已知 $a, b, c$ 均为正数，且 $2^a = log_(1/2) a, display((1/2))^b = log_(1/2) b, display((1/2))^c = log_2 c$，则（#h(3em)）
  ],
  choices: choices14(
    [$a < b < c$],
    [$c < b < a$],
    [$c < a < b$],
    [$b < a < c$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2024湖南省长沙市湖南师大附中高一上期末单选压轴】设方程 $log_2 x - display((1/2))^x = 0$，$log_(1/2) x - display((1/2))^x = 0$ 的根分别为 $x_1, x_2$，则（#h(3em)）
  ],
  choices: choices14(
    [$x_1 x_2 = 1$],
    [$0 < x_1 x_2 < 1$],
    [$1 < x_1 x_2 < 2$],
    [$x_1 x_2 gt.eq 2$],
  ),
  answer: [#tab *B*],
)

== 抽象函数

#method("")[
  #tab 寻找已学过的函数模型进行匹配，探究其函数特征。或寻找特殊值带入。
]

#example(
  question: [
    【2024广东深圳高三深圳外国语学校校考阶段练习】写出一个满足 $f(x+y) = f(x) + f(y) + 2 x y$ 的函数解析式：#blank()。
  ],
  answer: [#tab *$f(x) = x^2$*],
)

#example(
  question: [
    【2023 重庆一诊】已知定义域为 $(0, +infinity)$ 的减函数 $f(x)$ 满足 $f(x y) = f(x) + f(y)$，且 $f(2) = -1$，则不等式 $f(x+2) + f(x+4) > -3$ 的解集为 #blank()。
  ],
  answer: [#tab *$(-2, 0)$*],
)

#example(
  question: [
    【2024四川省遂宁市学年高三上学期期末】定义在 $bb(R)$ 上的函数 $f(x)$，对任意 $x_1, x_2 in bb(R)$，满足下列条件：

    ① $f(x_1 + x_2) = f(x_1) + f(x_2) - 2$

    ② $f(2) = 4$

    (1) 是否存在一次函数 $f(x)$ 满足条件②，若存在，求出 $f(x)$ 的解析式；若不存在，说明理由。

    (2) 证明：$g(x) = f(x) - 2$ 为奇函数。
  ],
  answer: [
    *(1) $f(x) = x + 2$*

    *(2) 略*
  ],
)

#example(
  question: [
    【2024北京丰台一模, 14】已知函数 $f(x)$ 具有下列性质：

    ① 当 $x_1, x_2 in [0, +infinity)$ 时，都有 $f(x_1 + x_2) = f(x_1) + f(x_2) + 1$；

    ② 在区间 $(0, +infinity)$ 上 $f(x)$ 单调递增；

    ③ $f(x)$ 是偶函数。

    则 $f(0) =$ #blank()；函数 $f(x)$ 可能的一个解析式为 $f(x) =$ #blank()。
  ],
  answer: [#tab *$-1$* #tab *$|x|-1$*],
)

#example(
  question: [
    定义在 $bb(R)$ 上的函数 $f(x)$ 满足对任意 $x, y in bb(R)$，有 $f(x-y) = f(x) - f(y)$，$f(3) = 1013$。

    (1) 求 $f(0), f(6)$ 的值。

    (2) 判断 $f(x)$ 的奇偶性，并证明你的结论。

    (3) 当 $x > 0$ 时，$f(x) > 0$，解不等式 $f(2x-4) > 2026$。
  ],
  answer: [
    *(1) $f(0) = 0, f(6) = 2026$*

    *(2) 奇函数*

    *(3) $(5, +infinity)$*
  ],
)

#example(
  question: [
    【2023福建福州高一期中】(多选) 定义在 $(-1, 1)$ 上的函数 $f(x)$ 满足 $f(x) - f(y) = f(display((x-y)/(1- x y)))$ 且当 $x in (-1, 0)$ 时，$f(x) < 0$，则下列说法正确的有（#h(3em)）
  ],
  choices: choices22(
    [$f(0) = 0$],
    [$f(x)$ 为奇函数],
    [$f(x)$ 为减函数],
    [$f(x)$ 可能为 $f(x) = ln display((1+x)/(1-x))$],
  ),
  answer: [#tab *ABD*],
)

#example(
  question: [
    【2024湖南省岳阳市高一上期末】(多选) 已知函数 $f(x)(x in bb(R))$ 满足当 $x > 0$ 时，$f(x) > 1$，且对任意实数 $x_1, x_2$ 满足 $f(x_1 + x_2) = f(x_1) f(x_2)$，当 $x_1 eq.not x_2$ 时，$f(x_1) eq.not f(x_2)$，则下列说法正确的是（#h(3em)）
  ],
  choices: choices41(
    [函数 $f(x)$ 在 $bb(R)$ 上单调递增],
    [$f(0) = 0$ 或 $1$],
    [函数 $f(x)$ 为非奇非偶函数],
    [对任意实数 $x_1, x_2$ 满足 $display(1/2 [f(x_1) + f(x_2)] gt.eq f((x_1+x_2)/2))$],
  ),
  answer: [#tab *ACD*],
)

#example(
  question: [
    【2024福建师范大学附属中学高一上期末】(多选) 已知函数 $f(x)$ 的定义域为 $(0, +infinity)$，满足对任意 $x, y in (0, +infinity)$，都有 $f(x y) = f(x) dot f(y) - f(x) - f(y) + 2$，且 $x > 1$ 时，$f(x) > 2$。则下列说法正确的是（#h(3em)）
  ],
  choices: choices41(
    [$f(1) = 2$],
    [当 $x in (0, 1)$ 时，$f(x) < 2$],
    [$f(x)$ 在 $(0, 1)$ 是减函数],
    [存在实数 $k$ 使得函数 $y = |f(x) + k|$ 在 $(0, 1)$ 是减函数],
  ),
  answer: [#tab *ABD*],
)

#pagebreak()

= 思维训练

// #introduction[思维训练]

#example(
  question: [
    【2024河南省届高三下学期仿真模拟考试数学试题】已知函数 $f(x)$ 为定义在 $bb(R)$ 上的单调函数，$f(f(x) - 2^x - 2x) = 10$，则 $f(x)$ 在 $[-2, 2]$ 上的值域为 #blank()。
  ],
  answer: [#tab *$display([-7/4, 10])$*],
)

#example(
  question: [
    【2023-2024 湖南省长沙市长郡中学高一上期末】已知定义在 $(0, +infinity)$ 上的 $f(x)$ 是单调函数，且对任意 $x in (0, +infinity)$ 恒有 $f(f(x) + log_(1/3) x) = 4$，则函数 $f(x)$ 的零点为（#h(3em)）
  ],
  choices: choices14(
    [$display(1/27)$],
    [$display(1/9)$],
    [$9$],
    [$27$],
  ),
  answer: [#tab *A*],
)

#example(
  question: [
    【2024 全国高三专题练习】不等式 $(x^2 - 1)^1011 + x^2022 + 2x^2 - 1 lt.eq 0$ 的解集为 #blank()。
  ],
  answer: [#tab *$display([-sqrt(2)/2, sqrt(2)/2])$*],
)

// ==================== 在文档末尾显示所有答案 ====================
#show-answers()