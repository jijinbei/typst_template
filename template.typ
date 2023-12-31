#import "@preview/showybox:2.0.1": showybox

#let project(
  title: "",
  authors: (),
  date: false,
  titlepage: false,
  body
  ) = {

  let body_font = (
    "Latin Modern Roman",
    "Harano Aji Mincho"
  )

  let math_font = ("Latin Modern Math")

  // Set the document's basic properties.
  set document(author: authors, title: title)
  
  set page(
    margin: (
      left: 25mm,
      right: 25mm,
      top: 30mm,
      bottom: 30mm
    ),
    numbering: "1",
    number-align: center,
  )
  
  set text(
    font: body_font,
    lang: "ja",
    region: "JP"
  )

  set figure(supplement: it => {
  if it.func() == table {
    "表"
  } else if it.func() == image {
    "図"
  } else {
    "?" // どうしよ
  }}
  )

  // Spacing between Japanese and English text
  show regex(
    "[\\P{latin}&&[[:^ascii:]]][\\p{latin}[[:ascii:]]]|[\\p{latin}[[:ascii:]]][\\P{latin}&&[[:^ascii:]]]"
  ) : it => {
    let a = it.text.match(regex("(.)(.)"))
    a.captures.at(0)+h(0.25em)+a.captures.at(1)
  }

  show math.equation: set text(
    weight: 400,
    font: math_font,
    )
  set math.equation(
    numbering: "(1)",
    supplement: "式",
  )

  let set_author(ver) = {
    if ver == 1 {
      pad(
        top: 1em,
        bottom: 0em,
        left: 4em,
        right: 4em,
        grid(
          columns: (1fr,) * calc.min(2, authors.len()),
          gutter: 1%,
          ..authors.map(author => 
          align(
            center, 
            text(size: 1.3em, author)
          )),
        ),
      )
    } else if ver == 2 {
      v(0.05fr)
      pad(
        top: 1em,
        bottom: 0em,
        left: 4em,
        right: 4em,
        grid(
          columns: (1fr,) * calc.min(1, authors.len()),
          gutter: 1%,
          ..authors.map(author => 
          align(
            center, 
            text(size: 1.5em, author)
          )),
        ),
      )
      v(0.05fr)
    }
  }

  let set_date(date, ver) = {
    if date == true {
      if ver == 1 {
        align(
          center, 
          text(
            size: 1.2em, 
            datetime.today().display("[year]年[month]月[day]日")
          )
        )
      } else if ver == 2 {
        align(
          center, 
          text(
            size: 1.4em, 
            datetime.today().display("[year]年[month]月[day]日")
          )
        )
      }
    } 
  }

  // Start of document
  if titlepage == true {
    // Title
    v(0.4fr)
    align(center)[
      #block(
        text(size: 2.5em, weight: 600, title)
      )
    ]

    // Author
    set_author(2)

    // Date
    set_date(date, 2)

    v(0.6fr)
    
    pagebreak()

    // Table of contents.
    outline(depth: 3, indent: true)
    pagebreak()
  
  } else { // if set_titlepage == false
    // Title
    align(center)[
      #block(
        text(size: 2.0em, weight: 600, title)
      )
    ]

    set_author(1)
    set_date(date, 1)
  }

  set par(
    // first-line-indent: 1em,
    justify: true,
    leading: 0.95em,
  )
  // Set paragraph spacing.
  // body
  show par: set block(
    above: 1.25em,
    below: 1em,
    spacing: 1em
  )
  

  // Set heading styles.
  set heading(numbering: "1.1 ")
  show heading.where(level: 1): set text(
    weight: 630,
  )
  show heading.where(level: 1): set block(
    above: 2em,
  )

  show heading.where(level: 2): set text(
    weight: 600,
  )
  show heading.where(level: 2): set block(
    above: 1.25em,
  )

  show heading.where(level: 3): set text(
    weight: 570,
  )

  body
}

// box
#let cbox(title,txt) = showybox(
  title-style: (
    weight: 800,
    color: red.darken(15%),
    sep-thickness: 0pt,
    align: center
  ),
  frame: (
    title-color: red.lighten(80%),
    border-color: red.darken(30%),
    thickness: (left: 1pt),
    radius: 2pt
  ),
  title: title,
)[
  #txt
]

#let LaTeX = text(
  font: "Latin Modern Roman", 
  [
    L#h(-0.35em)#text(size: 0.725em, baseline: -0.25em)[A]#h(-0.125em)T#h(-0.175em)#text(baseline: 0.225em)[E]#h(-0.125em)X
  ]
)