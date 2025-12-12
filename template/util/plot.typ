#import "@preview/cetz:0.4.2": canvas, draw

/// Venn 图绘制函数（双圆）
/// 
/// 参数说明：
/// - padding: 外边框的内边距
/// - xy-scale: 图形的缩放比例 (x, y)
/// - a-fill: 集合 A 的填充颜色
/// - b-fill: 集合 B 的填充颜色
/// - ab-fill: 交集区域的填充颜色
/// - rect-fill: 外边框的填充颜色
/// - a-pos: 集合 A 的圆心位置
/// - b-pos: 集合 B 的圆心位置
/// - a-radius: 集合 A 的半径
/// - b-radius: 集合 B 的半径
/// - a-text: 集合 A 的文本标签
/// - b-text: 集合 B 的文本标签
/// - ab-text: 交集区域的文本标签
/// - rect-text: 全集的文本标签
/// - rect-text-offset: 全集文本的偏移量
/// - circle-style: 圆的线条样式
/// - rect-style: 边框的线条样式
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

  // 应用缩放比例
  scale(x: xy-scale.at(0), y: xy-scale.at(1))

  // 计算两圆中心点（用于交集文本定位）
  let center-pos = (
    (a-pos.at(0) + b-pos.at(0)) / 2, 
    (a-pos.at(1) + b-pos.at(1)) / 2
  )

  // 计算外边框的左下角和右上角坐标
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
  
  // 绘制外边框（全集 U）
  rect(lb, rt, fill: rect-fill, stroke: rect-style)
  
  // 绘制全集文本标签
  if rect-text != none {
    content(
      (lb.at(0) + rect-text-offset.at(0), rt.at(1) + rect-text-offset.at(1)), 
      anchor: "center", 
      rect-text
    )
  }

  // 绘制集合 A（左侧圆）
  circle(
    a-pos,
    radius: a-radius,
    stroke: circle-style,
    fill: a-fill,
    name: "set-a",
  )

  // 绘制集合 B（右侧圆）
  circle(
    b-pos,
    radius: b-radius,
    stroke: circle-style,
    fill: b-fill,
    name: "set-b",
  )

  // 初始化文本位置（默认在圆心）
  let text-a-pos = a-pos
  let text-b-pos = b-pos

  // 计算两圆心之间的距离
  let d = calc.sqrt(
    calc.pow(b-pos.at(0) - a-pos.at(0), 2) + 
    calc.pow(b-pos.at(1) - a-pos.at(1), 2)
  )

  // 根据两圆的位置关系处理不同情况
  if d == 0 {
    // === 情况1：两圆圆心完全重合 ===
    // 文本位置保持在圆心，只显示交集文本
    if ab-text != none {
      content(center-pos, anchor: "center", ab-text)
    }
    
  } else if d < a-radius + b-radius and d > calc.abs(a-radius - b-radius) {
    // === 情况2：两圆相交 ===
    
    // 计算交点相关参数
    // a: 圆心 A 到交点中点在连心线上的投影长度
    let a = (calc.pow(a-radius, 2) - calc.pow(b-radius, 2) + calc.pow(d, 2)) / (2 * d)
    // h: 交点到连心线的垂直距离
    let h = calc.sqrt(calc.pow(a-radius, 2) - calc.pow(a, 2))

    // 计算交点中点坐标
    let px = a-pos.at(0) + a * (b-pos.at(0) - a-pos.at(0)) / d
    let py = a-pos.at(1) + a * (b-pos.at(1) - a-pos.at(1)) / d

    // 计算两个交点坐标
    let intersect1 = (
      px + h * (b-pos.at(1) - a-pos.at(1)) / d, 
      py - h * (b-pos.at(0) - a-pos.at(0)) / d
    )
    let intersect2 = (
      px - h * (b-pos.at(1) - a-pos.at(1)) / d, 
      py + h * (b-pos.at(0) - a-pos.at(0)) / d
    )

    // 计算圈弧的中间点（用于绘制圆滑的圈弧）
    let line-intersect-a = (
      a-pos.at(0) + a-radius * (b-pos.at(0) - a-pos.at(0)) / d,
      a-pos.at(1) + a-radius * (b-pos.at(1) - a-pos.at(1)) / d,
    )
    let line-intersect-b = (
      b-pos.at(0) - b-radius * (b-pos.at(0) - a-pos.at(0)) / d,
      b-pos.at(1) - b-radius * (b-pos.at(1) - a-pos.at(1)) / d,
    )

    // 绘制交集区域（由两条圈弧组成）
    // 第一条圈弧：属于圆 A 的部分
    arc-through(
      intersect1,
      line-intersect-a,
      intersect2,
      fill: ab-fill,
      stroke: circle-style,
    )
    // 第二条圈弧：属于圆 B 的部分
    arc-through(
      intersect2,
      line-intersect-b,
      intersect1,
      fill: ab-fill,
      stroke: circle-style,
    )

    // 调整文本位置：放在远离对方圆的位置
    text-a-pos = (
      a-pos.at(0) - (b-pos.at(0) - a-pos.at(0)) / d * a-radius * 0.5,
      a-pos.at(1) - (b-pos.at(1) - a-pos.at(1)) / d * a-radius * 0.5,
    )
    text-b-pos = (
      b-pos.at(0) + (b-pos.at(0) - a-pos.at(0)) / d * b-radius * 0.5,
      b-pos.at(1) + (b-pos.at(1) - a-pos.at(1)) / d * b-radius * 0.5,
    )

    // 绘制交集文本标签
    if ab-text != none {
      content(center-pos, anchor: "center", ab-text)
    }
    
  } else if d >= a-radius + b-radius {
    // === 情况3：两圆分离（不相交） ===
    // 文本位置保持在各自圆心
    text-a-pos = a-pos
    text-b-pos = b-pos
    
  } else {
    // === 情况4：一个圆完全在另一个圆内部 ===
    
    if a-radius < b-radius {
      // 圆 A 在圆 B 内部
      text-a-pos = a-pos  // A 的文本在圆心
      text-b-pos = (
        // B 的文本放在远离 A 的方向
        b-pos.at(0) + (b-pos.at(0) - a-pos.at(0)) / d * b-radius * 0.5,
        b-pos.at(1) + (b-pos.at(1) - a-pos.at(1)) / d * b-radius * 0.5,
      )
    } else {
      // 圆 B 在圆 A 内部
      text-a-pos = (
        // A 的文本放在远离 B 的方向
        a-pos.at(0) - (b-pos.at(0) - a-pos.at(0)) / d * a-radius * 0.5,
        a-pos.at(1) - (b-pos.at(1) - a-pos.at(1)) / d * a-radius * 0.5,
      )
      text-b-pos = b-pos  // B 的文本在圆心
    }
    
    // 绘制交集文本标签
    if ab-text != none {
      content(center-pos, anchor: "center", ab-text)
    }
  }

  // 绘制集合文本标签
  content(text-a-pos, anchor: "center", a-text)
  content(text-b-pos, anchor: "center", b-text)

  // 恢复缩放比例
  scale(x: 1 / xy-scale.at(0), y: 1 / xy-scale.at(1))
}

/// 区间线绘制函数
/// 
/// 用于在数轴上绘制一个或多个区间
/// 
/// 参数说明：
/// - start: 数轴起始值
/// - end: 数轴结束值
/// - unit-scale: 单位长度缩放比例
/// - unit-side-scale: 数轴两端延伸长度
/// - height: 区间线的高度
/// - show-interval-labels: 是否显示区间标签
/// - axis-stroke: 数轴线条样式
/// - tick-stroke: 刻度线条样式
/// - axis-label-style: 数轴标签样式
/// - axis-labels: 自定义数轴标签数组
/// - lines: 区间线配置数组，每个元素包含：
///   - start: 起点配置 (index: 索引, open: 是否开区间, inf: 是否无穷大)
///   - end: 终点配置
///   - stroke: 线条样式
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

  // 绘制数轴主线（带箭头）
  line(
    (start * unit-scale - unit-side-scale, 0),
    (end * unit-scale + unit-side-scale, 0),
    stroke: axis-stroke,
    mark: (end: "stealth"),
  )

  // 绘制刻度和标签
  for i in range(start, end + 1) {
    // 获取标签文本（优先使用自定义标签）
    let t = if axis-labels != none and i - start < axis-labels.len() {
      axis-labels.at(i - start)
    } else {
      str(i)
    }

    // 空标签跳过
    if t == "" {
      continue
    }

    let x = i * unit-scale
    
    // 绘制刻度线
    line(
      (x, -0.1cm),
      (x, 0.1cm),
      stroke: tick-stroke,
    )

    // 绘制标签
    content(
      (x, -0.2),
      anchor: "north",
      text(size: axis-label-style.size, fill: axis-label-style.fill)[#t],
    )
  }

  // 绘制每个区间线
  for l in lines {
    let line-start-index = l.start.index
    let line-end-index = l.end.index

    let start-x = line-start-index * unit-scale
    let end-x = line-end-index * unit-scale

    // === 处理起点 ===
    if l.start.inf {
      // 无穷大：延伸到数轴左侧
      start-x = start * unit-scale - unit-side-scale
    } else {
      // 有限值：绘制端点竖线和圆点
      line((start-x, 0), (start-x, height), stroke: l.stroke)
      if not l.start.open {
        // 闭区间：实心圆
        circle((start-x, 0), radius: 0.08, stroke: l.stroke, fill: l.stroke.paint)
      } else {
        // 开区间：空心圆
        circle((start-x, 0), radius: 0.08, stroke: l.stroke, fill: white)
      }
    }

    // === 处理终点 ===
    if l.end.inf {
      // 无穷大：延伸到数轴右侧
      end-x = end * unit-scale + unit-side-scale
    } else {
      // 有限值：绘制端点竖线和圆点
      line((end-x, 0), (end-x, height), stroke: l.stroke)
      if not l.end.open {
        // 闭区间：实心圆
        circle((end-x, 0), radius: 0.08, stroke: l.stroke, fill: l.stroke.paint)
      } else {
        // 开区间：空心圆
        circle((end-x, 0), radius: 0.08, stroke: l.stroke, fill: white)
      }
    }

    // 绘制区间水平线
    line((start-x, height), (end-x, height), stroke: l.stroke)

    // 绘制区间标签
    if show-interval-labels {
      let text-pos = ((start-x + end-x) / 2, height + 0.25cm)
      
      // 构造左边界文本
      let left-bracket = if l.start.open { "(" } else { "[" }
      let left-value = if l.start.inf { [$-infinity$] } else { [#str(l.start.index)] }
      let left-text = left-bracket + left-value
      
      // 构造右边界文本
      let right-value = if l.end.inf { [$+infinity$] } else { [#str(l.end.index)] }
      let right-bracket = if l.end.open { ")" } else { "]" }
      let right-text = right-value + right-bracket
      
      // 完整区间表示
      let all-text = left-text + ", " + right-text

      content(text-pos, text(size: 11pt, fill: l.stroke.paint, all-text))
    }

    // 下一个区间线向上偏移
    height += height
  }
}

// 示例：同时绘制 Venn 图和区间线
#canvas({
  venn2()
  interval-line()
})
