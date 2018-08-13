@date 20180724

# Markdownからpdf(数式付き)に変換する方法のまとめ
`markdown-pdf`だと数式が変換されなかったため，まとめる．  
本当は[こんな感じ](http://shunk031.me/paper-survey/)でかっこよくしたかったと思う．
#### 環境
- Windows 10 Pro 64bit
- Atom 1.28.2
- Latex
```
pdfTeX 3.14159265-2.6-1.40.19 (TeX Live 2018/W32TeX)
kpathsea version 6.3.0
Copyright 2018 Han The Thanh (pdfTeX) et al.
There is NO warranty.  Redistribution of this software is
covered by the terms of both the pdfTeX copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the pdfTeX source.
Primary author of pdfTeX: Han The Thanh (pdfTeX) et al.
Compiled with libpng 1.6.34; using libpng 1.6.34
Compiled with zlib 1.2.11; using zlib 1.2.11
Compiled with xpdf version 4.00
```
- pandoc
```
pandoc 2.2.2.1
Compiled with pandoc-types 1.17.5.1, texmath 0.11.0.1, skylighting 0.7.2
Default user data directory: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Copyright (C) 2006-2018 John MacFarlane
Web:  http://pandoc.org
This is free software; see the source for copying conditions.
There is no warranty, not even for merchantability or fitness
for a particular purpose.
```

### 手引き
1. Atomのインストール
2. Atomに以下のパッケージをインストール  
    1. `markdown-preview-plus`  
      markdownのプレビューで数式を表示できるようにする.  
      参考文献[1,2]では，「`markdown-preview`をDisableにする」とあるが，自動化されている．

    2. `mathjax-wrapper`  
      tex風に数式をかけるようにする．

3. Latexをインストール（TexLive 2018）
    1. 以下のサイトから，TexLiveをダウンロード(isoファイルを推奨)  
    [TeX Live/Windows](https://texwiki.texjp.org/?TeX%20Live%2FWindows)

    2. 「Install-tl-windows.bat」をクリックしてインストール開始
    <img src="/assets/img/README/figure1.png" alt="Figure 1" width=75% height=75%>

    3. Tex(Latex)がインストールできたかは確認するべし  
    [Microsoft Windows](https://texwiki.texjp.org/?Microsoft%20Windows#notefoot_1)

4. pandocのインストール[3]
    1. 以下のサイトから，`pandoc-2.2.2.1-windows-x86_64.msi`をダウンロード  
    [pandoc](https://github.com/jgm/pandoc/releases)

5. pandocによる変換[4]
    1. UTF-8 の Markdown テキスト（日本語含むもの）SAMPLE.mdを用意
    ```
    # ほげ
    - FUGA
    - ピヨ
    $$
    \frac{1}{2}
    $$
    ```

    2. 日本語を PDF 変換するため、`h-luatexja.tex` というファイルを同フォルダに用意
    ```
    \usepackage{luatexja}
    \hypersetup{unicode=true}
    ```

    3. 変換する  
    `--latex-engine`は，`--pdf-engine`に変更されている
    ```
    pandoc SAMPLE.md -o SAMPLE.pdf --pdf-engine=lualatex -H h-luatexja.tex
    ```
    [pandocのオプション日本語まとめ](https://qiita.com/danpansa/items/7ea8db3942a7946dd56a)

6. Result  
拡大したもの  
<img src="/assets/img/README/figure2.PNG" alt="Figure 2" width=75% height=75%>

 **追記1**  
batファイルで動くように，手引きの5番を少し変更した．
1. 同様
2. `headers`フォルダにh-luatexja.texを作成
3. batファイル(`markdown2pdf.bat`)を実行  
batファイルでは，`posts`フォルダ内の最新のmarkdownを取得し，`pdf`フォルダ内に同じファイル名でpdfを出力する．

 **追記2**  
 `h-luatexja.tex`を変更．画像のサイズを変更をできるようにし，出力pdfのマージンを決定．
 ```
 \makeatletter
 \def\maxwidth{\ifdim\Gin@nat@width>\linewidth\linewidth\else\Gin@nat@width\fi}
 \def\maxheight{\ifdim\Gin@nat@height>\textheight\textheight\else\Gin@nat@height\fi}
 \makeatother
 % Scale images if necessary, so that they will not overflow the page
 % margins by default, and it is still possible to overwrite the defaults
 % using explicit options in \includegraphics[width, height, ...]{}
 \setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}

 \usepackage{luatexja-otf}
 \hypersetup{unicode=true}
 \usepackage{geometry}
 % http://joker.hatenablog.com/entry/2012/07/09/153537
 % ######## measure #########
 % # mm = 1mm = 2.85pt      #
 % # cm = 10mm = 28.5pt     #
 % # in = 25.4mm = 72.27pt  #
 % # pt = 0.35mm = 1pt      #
 % # em = width of [M]      #
 % # ex = height of [x]     #
 % # zw = width of [Kanji]  #
 % # zh = height of [Kanji] #
 % ##########################
 % ##################### Portrait Setting #########################
 % # TOP = 1inch + ¥voffset + ¥topmargin + ¥headheight + ¥headsep #
 % #     = 1inch + 0pt + 4pt + 20pt + 18pt (default)              #
 % # BOTTOM = ¥paperheight - TOP -¥textheight                     #
 % ################################################################
 \setlength{\textheight}{\paperheight}   % 紙面縦幅を本文領域にする（BOTTOM=-TOP）
 \setlength{\topmargin}{4.6truemm}       % 上の余白を30mm（=1inch+4.6mm）に
 \addtolength{\topmargin}{-\headheight}  %
 \addtolength{\topmargin}{-\headsep}     % ヘッダの分だけ本文領域を移動させる
 \addtolength{\textheight}{-60truemm}    % 下の余白も30mm（BOTTOM=-TOPだから+TOP+30mm)

 % #################### Landscape Setting #######################
 % # LEFT = 1inch + ¥hoffset + ¥oddsidemargin (¥evensidemargin) #
 % #      = 1inch + 0pt + 0pt                                   #
 % # RIGHT = ¥paperwidth - LEFT - ¥textwidth                    #
 % ##############################################################
 \setlength{\textwidth}{\paperwidth}     % 紙面横幅を本文領域にする（RIGHT=-LEFT）
 \setlength{\oddsidemargin}{-0.4truemm}  % 左の余白を25mm(=1inch-0.4mm)に
 \setlength{\evensidemargin}{-0.4truemm} %
 \addtolength{\textwidth}{-50truemm}     % 右の余白も25mm（RIGHT=-LEFT）

 ```
### 手引きの変更(20180725)
今までは`pandoc`を使って，`latex` ➡ `pdf`に変換していたが，出力pdfが思っていたのと違ったたのと変換が遅いので，以下のように変更する．

新： `markdown` ➡(pandoc) `html`  ➡(Google Chorome) `pdf`  

旧： `markdown` ➡(pandoc) `pdf`

必要なものは以下の通り．

- pandoc
  - html変換用

- Google chrome
  - pdfの変換用

これに伴いbatファイルも変更した．出力は，`html`フォルダと`pdf`フォルダにできる．参考文献は，[8-11]が役にたった．


#### 参考文献
[1] https://qiita.com/noppefoxwolf/items/335323b98f0400a6f07d  
[2] http://cartman0.hatenablog.com/entry/2016/03/22/023632  
[3] https://qiita.com/tsujimitsu/items/907d7a2fae2057d0fb1f  
[4] https://qiita.com/saitotak/items/c5630267c06b2ad0dccd  
[5] https://sky-y.github.io/osc-kyoto2017-pandoc/  
[6] https://qiita.com/takada-at/items/c807c163bd861bbec7cf  
[7] https://orumin.blogspot.com/2017/09/pandoc-markdown-pdf.html  
[8] http://jinjor-labo.hatenablog.com/entry/2016/02/04/154126  
[9] http://takuya-1st.hatenablog.jp/entry/2017/06/16/133000  
[10] http://sky-y.github.io/site-pandoc-jp/users-guide/  
[11] https://qiita.com/yohm/items/f14f03ccee918d4d7213
