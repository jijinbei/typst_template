// Settings
#let TITLE_HEIGHT = 22mm
#let TITLE_SIZE = 36pt
#let HEADING_SIZE = 18pt
#let BODY_SIZE = 13pt

#let conf(title: [], cols: 2, doc) = {
  set page(paper: "a4", margin: 8mm)
   
  // title
  box(
    width: 100%,
    height: TITLE_HEIGHT,
    inset: 0pt,
    fill: black.lighten(20%),
    align(center + horizon, text(
      font: "Noto Sans JP",
      fill: white,
      size: TITLE_SIZE,
      weight: 600,
      title,
    )),
  )
   
  // body
  set text(font: "Kosugi Maru", size: BODY_SIZE)
  // heading
  show heading: it => {
    block(
      stroke: black,
      width: 100%,
      inset: 6pt,
      outset: 1pt,
      above: 15pt,
      radius: 2pt,
      text(size: HEADING_SIZE, weight: 600, it),
    )
  }
   
  set enum(numbering: (..nums) => text(font: "Noto Sans JP", weight: 800, nums
  .pos()
  .map(str)
  .join(".") + "."))
  // body
  columns(cols, doc)
}

#let caution(doc) = {
  box(fill: black.lighten(80%), width: 100%, inset: 6pt, radius: 4pt, grid(
    columns: (5%, 95%),
    gutter: 3%,
    image("icon\caution_mark.svg"),
    box(inset: 2pt, text(size: 12pt, doc)),
  ))
}

#let QandA(Q: [], A: []) = {
  grid(
    columns: (10%, 90%),
    gutter: 3%,
    align: horizon,
    block(
      width: 30pt,
      height: 30pt,
      fill: black,
      inset: 12pt,
      align(center + horizon, text(fill: white, size: 18pt, weight: 800, "Q")),
    ),
    block(inset: 6pt, outset: 1pt, above: 15pt, radius: 2pt, text(size: 13pt, Q)),
  )

  grid(
    columns: (10%, 90%),
    gutter: 3%,
    
    block(
      width: 30pt,
      height: 30pt,
      fill: black,
      align(center + horizon, text(fill: white, size: 18pt, weight: 800, "A")),
    ),
    block(inset: 6pt, outset: 1pt, above: 15pt, radius: 2pt, text(size: 13pt, A)),
  )
}