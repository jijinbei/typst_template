#import "@preview/showybox:2.0.1": showybox

#let project(
  title: "",
  authors: (),
  date: false,
  titlepage: false,
  body
  ) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    numbering: "1",
    number-align: center,
  )
  set text(
    font: (
      "Latin Modern Roman",
      "Harano Aji Mincho",
    )
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
  show regex("[\\P{latin}&&[[:^ascii:]]][\\p{latin}[[:ascii:]]]|[\\p{latin}[[:ascii:]]][\\P{latin}&&[[:^ascii:]]]") : it => {
    let a = it.text.match(regex("(.)(.)"))
    a.captures.at(0)+h(0.25em)+a.captures.at(1)
  }

  show math.equation: set text(weight: 400)
  set math.equation(
    numbering: "(1)",
    supplement: "式",
  )

  let set_author = pad(
    top: 1em,
    bottom: 0em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => 
      align(
        center, 
        text(size: 1.2em, author)
      )),
    ),
  )

  let set_date = align(
    center, 
    text(
      size: 1.1em, 
      datetime.today().display("[year]年[month]月[day]日")
  ))

  // Set paragraph spacing.
  show par: set block(above: 1.25em, below: 1.25em)

  set heading(numbering: "1.1 ",)
  set par(leading: 0.9em)

  // Start of document
  if titlepage == true {
    // Title
    v(0.3fr)
    align(center)[
      #block(text(size: 2.25em, weight: 600, title))
    ]

    // Author
    set_author

    // Date
    if date == true {
      set_date
    }

    v(0.7fr)
    
    pagebreak()

    // Table of contents.
    outline(depth: 3, indent: true)
    pagebreak()
  
  } else { // if set_titlepage == false
    // Title
    align(center)[
      #v(3.0em)
      #block(text(size: 2em, weight: 600, title))
    ]

    // Author
    set_author

    // Date
    if date == true {
      set_date
    }

    v(2em)
  }


  // body
  show par: set block(
    spacing: 1em
    )
  set par(
    // first-line-indent: 1em,
    justify: true,
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