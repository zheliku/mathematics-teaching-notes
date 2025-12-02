#import "@preview/cetz:0.4.2": canvas, draw

#let venn2(
  padding: (0.5, 0.5),
  a-fill: blue.lighten(80%),
  b-fill: blue.lighten(80%),
  ab-fill: none,
  rect-fill: blue.lighten(95%),
  a-pos: (-0.5, 0),
  b-pos: (0.5, 0),
  a-radius: 1,
  b-radius: 1,
  a-text: text(size: 12pt, [A]),
  b-text: text(size: 12pt, [B]),
  ab-text: none,
  rect-text: text(size: 12pt, [U]),
  rect-text-offset: (0.5, -0.4),
  circle-style: (thickness: 0.5pt, paint: black),
  rect-style: (thickness: 0.5pt, paint: black),
) = {
  import draw: *

  let center-pos = ((a-pos.at(0) + b-pos.at(0)) / 2, (a-pos.at(1) + b-pos.at(1)) / 2)

  let (lb, rt) = (
    (
      calc.min(a-pos.at(0) - a-radius, b-pos.at(0) - b-radius) - padding.at(0),
      calc.min(a-pos.at(1) - a-radius, b-pos.at(1) - b-radius) - padding.at(1),
    ),
    (
      calc.max(a-pos.at(0) + a-radius, b-pos.at(0) + b-radius) + padding.at(0),
      calc.max(a-pos.at(1) + a-radius, b-pos.at(1) + b-radius) + padding.at(1),
    ),
  )
  rect(lb, rt, fill: rect-fill, stroke: rect-style)
  if rect-text != none {
    content((lb.at(0) + rect-text-offset.at(0), rt.at(1) + rect-text-offset.at(1)),
      anchor: "center",
      rect-text,
    )
  }

  // 绘制集合A（左侧椭圆）
  let set-a = circle(
    a-pos,
    radius: a-radius,
    stroke: circle-style,
    fill: a-fill,
    name: "set-a",
  )

  // 绘制集合B（右侧椭圆）
  let set-b = circle(
    b-pos,
    radius: b-radius,
    stroke: circle-style,
    fill: b-fill,
    name: "set-b",
  )

  let text-a-pos = a-pos
  let text-b-pos = b-pos
  let text-ab-pos = center-pos

  set-a
  set-b

  // 计算两圆相交点
  let d = calc.sqrt(calc.pow(b-pos.at(0) - a-pos.at(0), 2) + calc.pow(b-pos.at(1) - a-pos.at(1), 2))

  // 如果两圆相交，计算交点坐标
  let a = (calc.pow(a-radius, 2) - calc.pow(b-radius, 2) + calc.pow(d, 2)) / (2 * d)
  let h = calc.sqrt(calc.pow(a-radius, 2) - calc.pow(a, 2))

  let px = a-pos.at(0) + a * (b-pos.at(0) - a-pos.at(0)) / d
  let py = a-pos.at(1) + a * (b-pos.at(1) - a-pos.at(1)) / d

  let intersect1 = (px + h * (b-pos.at(1) - a-pos.at(1)) / d, py - h * (b-pos.at(0) - a-pos.at(0)) / d)
  let intersect2 = (px - h * (b-pos.at(1) - a-pos.at(1)) / d, py + h * (b-pos.at(0) - a-pos.at(0)) / d)

  // 计算两圆与圆心连线的交点坐标
  let line-intersect-a = (
    a-pos.at(0) + a-radius * (b-pos.at(0) - a-pos.at(0)) / d,
    a-pos.at(1) + a-radius * (b-pos.at(1) - a-pos.at(1)) / d,
  )
  let line-intersect-b = (
    b-pos.at(0) - b-radius * (b-pos.at(0) - a-pos.at(0)) / d,
    b-pos.at(1) - b-radius * (b-pos.at(1) - a-pos.at(1)) / d,
  )

  if d < a-radius + b-radius and d > calc.abs(a-radius - b-radius) {
    // 绘制交集区域
    arc-through(
      intersect1,
      line-intersect-a,
      intersect2,
      fill: ab-fill,
      stroke: circle-style,
    )

    arc-through(
      intersect2,
      line-intersect-b,
      intersect1,
      fill: ab-fill,
      stroke: circle-style,
    )

    // 更新文本位置
    text-a-pos = (
      // 有交集时，A的文本放在远离B的方向
      a-pos.at(0) - (b-pos.at(0) - a-pos.at(0)) / d * a-radius * 0.5,
      a-pos.at(1) - (b-pos.at(1) - a-pos.at(1)) / d * a-radius * 0.5,
    )
    text-b-pos = (
      // 有交集时，B的文本放在远离A的方向
      b-pos.at(0) + (b-pos.at(0) - a-pos.at(0)) / d * b-radius * 0.5,
      b-pos.at(1) + (b-pos.at(1) - a-pos.at(1)) / d * b-radius * 0.5,
    )

    if ab-text != none {
      content(center-pos, anchor: "center", ab-text)
    }
  }

  // 添加文字标签
  content(text-a-pos, anchor: "center", a-text)
  content(text-b-pos, anchor: "center", b-text)
  // })
}

#canvas({
  venn2()
})