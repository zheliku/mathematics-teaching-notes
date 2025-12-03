#import "@preview/cetz:0.4.2": canvas, draw

#let venn2(
  padding: (0.5, 0.5),
  xy-scale: (1, 1),
  a-fill: blue.lighten(80%),
  b-fill: blue.lighten(80%),
  ab-fill: none,
  rect-fill: none,
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

  scale(x: xy-scale.at(0), y: xy-scale.at(1))

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
    content((lb.at(0) + rect-text-offset.at(0), rt.at(1) + rect-text-offset.at(1)), anchor: "center", rect-text)
  }

  // 绘制集合A（左侧椭圆）
  circle(
    a-pos,
    radius: a-radius,
    stroke: circle-style,
    fill: a-fill,
    name: "set-a",
  )

  // 绘制集合B（右侧椭圆）
  circle(
    b-pos,
    radius: b-radius,
    stroke: circle-style,
    fill: b-fill,
    name: "set-b",
  )

  let text-a-pos = a-pos
  let text-b-pos = b-pos
  let text-ab-pos = center-pos

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

  scale(x: 1 / xy-scale.at(0), y: 1 / xy-scale.at(1))
}

#let interval-line(
  start: 0,
  end: 1,
  unit-scale: 1,
  unit-side-scale: 0.5,
  height: 0.6cm,
  show-interval-labels: true,
  axis-stroke: (thickness: 1pt, paint: black),
  tick-stroke: (thickness: 0.5pt, paint: black),
  axis-label-style: (size: 10pt, fill: black),
  axis-labels: none,
  lines: (
    (
      start: (index: 0, open: false, inf: false),
      end: (index: 1, open: false, inf: false),
      stroke: (thickness: 1pt, paint: red),
    ),
    (
      start: (index: 2, open: true, inf: false),
      end: (index: 3, open: false, inf: false),
      stroke: (thickness: 1pt, paint: blue),
    ),
  ),
) = {
  import draw: *

  let total-steps = end - start

  // 绘制主线
  line(
    (start * unit-scale - unit-side-scale, 0),
    (end * unit-scale + unit-side-scale, 0),
    stroke: axis-stroke,
    mark: (end: "stealth"),
  )

  // 绘制刻度和标签
  for i in range(start, end + 1) {
    let t = if axis-labels != none and i - start < axis-labels.len() {
      axis-labels.at(i - start)
    } else {
      str(i)
    }

    if t == "" {
      continue
    }

    let x = i * unit-scale
    // 刻度线
    line(
      (x, -0.1cm),
      (x, 0.1cm),
      stroke: tick-stroke,
    )

    // 标签
    content(
      (x, -0.2),
      anchor: "north",
      text(size: axis-label-style.size, fill: axis-label-style.fill)[#t],
    )
  }

  for l in lines {
    let line-start-index = l.start.index
    let line-end-index = l.end.index

    let start-x = line-start-index * unit-scale
    let end-x = line-end-index * unit-scale

    // 调整起点位置
    if l.start.inf {
      start-x = start * unit-scale - unit-side-scale // 超出左侧
    } else {
      line((start-x, 0), (start-x, height), stroke: l.stroke)
      if not l.start.open {
        circle((start-x, 0), radius: 0.08, stroke: l.stroke, fill: l.stroke.paint) // 空心点
      } else {
        circle((start-x, 0), radius: 0.08, stroke: l.stroke, fill: white) // 实心点
      }
    }

    // 调整终点位置
    if l.end.inf {
      end-x = end * unit-scale + unit-side-scale // 超出右侧
    } else {
      line((end-x, 0), (end-x, height), stroke: l.stroke)
      if not l.end.open {
        circle((end-x, 0), radius: 0.08, stroke: l.stroke, fill: l.stroke.paint) // 空心点
      } else {
        circle((end-x, 0), radius: 0.08, stroke: l.stroke, fill: white) // 实心点
      }
    }

    // 绘制区间 (-∞, 3] (上方)
    line((start-x, height), (end-x, height), stroke: l.stroke)

    if show-interval-labels {
      let text-pos = ((start-x + end-x) / 2, height + 0.25cm)
      let left-text = if l.start.open { "(" } else { "[" } + if l.start.inf [$-infinity$] else [#str(l.start.index)]
      let right-text = if l.end.inf [$+infinity$] else [#str(l.end.index)] + if l.end.open { ")" } else { "]" }
      let all-text = left-text + ", " + right-text

      content(text-pos, text(size: 11pt, fill: l.stroke.paint, all-text))
    }

    height += height
  }
}



#canvas({
  venn2()
  interval-line()
})
