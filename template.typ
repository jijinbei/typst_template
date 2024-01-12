#import "@preview/showybox:2.0.1": showybox

#let custom_outline() = locate(loc => {
  heading(numbering: none)[目次]
  let headings = query(heading, loc)
  let toc = ()

  // remove the heading for the outline
  let _ = headings.remove(0)

  for h in headings {
    let padd = h.level * 1em - 1em
    let page = counter(page).at(h.location())
    
    let ch = if h.level == 1 {
      strong(counter("h").display("1."))
    } else {
      counter("h").display("1.")
    }
    
    let heading = if h.level == 1 {
      strong(h.body)
    } else {
      h.body
    }
    
    toc.push(
      {
        if h.level == 1 [
          #v(1.2em)
        ] else [
          #v(0.7em)
        ]
      } + 
      box[#pad(left: padd)[#link(h.location())[#{counter("h").step(level: h.level)}#ch#sym.space.third#heading]]] + 
      " " +
      box(width: 1fr)[
        #if h.level != 1 [
          #repeat(" .")
        ]
        ] + 
      [ #page.join()]
    )
  }

  stack(dir: ttb, ..toc)
})


#let project(
  title: "",
  authors: (),
  date: false,
  titlepage: false,
  bibfile: "",
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
    "図" // どうしよ
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
    supplement: "式",
    numbering: "(1)",
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
    custom_outline()
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
    weight: 600,
  )

  // 改行時の行間を調整する
  // show parbreak : {
  // h(1em)
  // } // バグが多いので使えない
  // noindentの関数を作る

  body

  
  if bibfile != "" {
    heading([参考文献])
    bibliography(bibfile, title: none)
  }
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

// convert csv to table
//
// example
// #csv2table(csv("data/Pb_data.csv"), [鉛の厚みとエネルギースペクトルの関係], label: ("厚さ(cm)",$A$,$mu "(keV)"$,$sigma$,$I$))
//
#let csv2table(csv, caption, label: none, digits: 2) = {
  let csv_label = csv.first()
  let len = csv_label.len()

  let csved =()
  for row in csv.slice(1) {
    for s in row {
      if regex("\d+\.\d+") in s {
        let n = float(s)
        let round_n = calc.round(n, digits: digits)
        let str_n = str(round_n)
        csved = csved + (str_n,)
      } else {
        csved = csved + (s,)
      }
    }
  }

  let labeled = ()
  if label == none {
    for csv_l in csv_label {
      labeled = labeled + (strong(csv_l),)
    }
    figure(
      table(
        columns: (1fr, ) * len,
        ..labeled,
        ..csved,
      ),
      caption: caption,
    )
  } else {
    for l in label {
      labeled = labeled + (strong(l),)
    }
    figure(
      table(
        columns: (1fr, ) * len,
        ..labeled,
        ..csved,
      ),
      caption: caption,
    )
  }
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