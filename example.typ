#import "template.typ": *
#import "@preview/physica:0.9.0": *

#show: project.with(
  title: "シャルピー衝撃試験レポート",
  authors: (
    "伊豆大学1年 今村 耕平",
  ),
  date: true,
  titlepage: false,
)

= 目的
#cbox([目的])[
  この実験の目的は、特定の材料（例：鋼、アルミニウムなど）の衝撃エネルギー吸収能力を測定し、その特性を理解することです。他にも、振り子の錘が試験片にあたった後に、実験者の股間に当たらないようにすることも目的です。
]

= 背景

シャルピー衝撃試験は、材料の衝撃強度、特にその脆性または靭性を評価するために広く使用される一種の試験です。この試験は、材料が急激な力や衝撃にどのように反応するかを理解する上で重要です。以下に、シャルピー衝撃試験の主な側面を詳しく説明します。

== 基本原理

シャルピー衝撃試験では、試験片に衝撃を加え、その際に吸収されるエネルギー量を測定します。このエネルギー量は、材料が衝撃に抵抗する能力、つまりその靭性を表します。
@シャルピー衝撃試験 のように文字を定義する。重量のあるハンマーをある高さh' から振り下ろすと、ハンマーは切り込みをつけた試験片を破壊して再び高さh まで振り上がる。この時の位置エネルギーの差

$ E & = m g (h' - h) \
& = m g l (cos beta - cos alpha) $

が、試験片を破壊する際の吸収エネルギーということになる。ここで、

- m ：ハンマーの質量
- g ：重力加速度
- l ：ハンマー回転中心からハンマー重心までの距離

#figure(
  image("image\Charpy_impact_test_sketch.svg", width: 50%),
  caption: "シャルピー衝撃試験の概念図",
)<シャルピー衝撃試験>

== 試験装置

*振り子式衝撃試験機*: 試験は、振り子の重量を利用して試験片に衝撃を与える機械を使用して行われます。振り子は一定の高さから解放され、試験片を打撃します。

*エネルギー計測*: 振り子は衝撃を与えた後も動き続け、その最高点での位置から衝撃によって吸収されたエネルギーが計算されます。

= 実験手順

試験片を機械に取り付け、規定の高さから振り子を落として衝撃を加える。衝撃後の振り子の残存エネルギーを測定し、衝撃エネルギー吸収量を計算する。

+ 試験片の準備: 適切な形状とサイズの試験片を準備します。
+ 試験環境の設定: 必要に応じて、試験片を特定の温度に調整します。
+ 実験者の股間の設定: 試験片の先に実験者の股間を置きます。
+ 衝撃の適用: 振り子を解放し、試験片に衝撃を与えます。
+ データ記録: 振り子の残存エネルギーから、試験片が吸収したエネルギーを計算します。また、実験者の股間の状態を記録します。


= 結果

#figure(
  table(
    columns: 5,
    [試験], [1回目], [2回目], [3回目], [4回目],
    [角度$alpha$], $150 degree$, $138 degree$, $101 degree$, $133 degree$,
    [股間の状態], [破壊], [破壊], [破壊], [破壊],
  ),
  caption: [試験結果],
)

一回目の試験では、必ず試験片を破壊しないといけないため、角度$alpha = 150 degree$に設定しました。この角度では、振り子の錘によって試験片は破壊され、そのまま実験者の股間に衝突しました。

二回目の試験では、過去レポートを参考にして、角度$alpha = 138 degree$に設定しました。しかし、このレポートは間違っており、試験片は破壊され振り子が実験者の股間に衝突しました。

三回目の試験では、過去レポートの計算ミスを修正をすると、角度は$alpha = 101 degree$になりました。しかし、４人の実験者内２人の股間を痛めているのに、ほかの２人は股間を痛めなくても良いというのは不公平だと思い、角度$alpha$に憎しみ係数$N$を掛けて、$alpha' = N times 101 degree = 134 degree$に設定しました。そのため、試験片は破壊され、振り子は実験者の股間に衝突しました。

四回目の試験では、角度$alpha = 133 degree$に設定しました。結果は、試験片は破壊され、振り子は実験者の股間に衝突しました。これで、誰も股間を痛めなくてもいい人はいなくなり、公平な試験ができました。

= 参考文献

+ ぐらんぶる 井上堅二 著 吉岡公威 漫画