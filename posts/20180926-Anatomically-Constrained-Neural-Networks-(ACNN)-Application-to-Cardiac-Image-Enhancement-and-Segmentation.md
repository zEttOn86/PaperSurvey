
---
title:  "Anatomically Constrained Neural Networks (ACNN): Application to Cardiac Image Enhancement and Segmentation"  
date:   2018-09-26
---

## <font color="MediumSpringGreen"> 1. どんなもの？ </font>

- CNNに解剖学的事前知識を組み込む一般的な学習戦略を提案

- 学習された形状の非線形表現を通して，基礎となる大局的な解剖特性に従うようにモデルを持っていく

- 超解像と心臓のセグメンテーションを行っている

  - 心臓をセグメンテーションする際には，解像度を上げながらセグメンテーションをしている点がすごい

## <font color="MediumSpringGreen"> 2. 先行研究と比べてどこがすごいの？ </font>

- 学習された3D形状深層モデルが，心臓病理学のクラス分類のためのバイオマーカーとして解釈の仕方と利用できることを実証する．

- 医用画像分析タスクのためのNNsに，形状とラベル構造上の事前知識を組み込む最新の技術を提案

## <font color="MediumSpringGreen"> 3. 技術や手法の"キモ"はどこにある？ </font>

- 新しい正則化ネットワークを提案

- computer graphicsで使われるT-L構造に基づいている．

- 解剖の非線形コンパクト表現を得るために，autoencoderとT-Lネットワークモデルを利用

  ![Figure 1](../assets/img/20180926-Anatomically-Constrained-Neural-Networks-(ACNN)-Application-to-Cardiac-Image-Enhancement-and-Segmentation/figure2.png)

- 全体のネットワークでT-Lネットみたいね

- T-Lモデルは2つのステージで訓練

  - AEをGT maskをcross-entropyを使って訓練

  - predictorが学習された空間hと一致するように，ユークリッド距離を使って訓練

  - これが終わったら，AEのencoder fの部分をcross entropyとeuclideanを使って更新

- 全体の構成

  ![](../assets/img/20180926-Anatomically-Constrained-Neural-Networks-(ACNN)-Application-to-Cardiac-Image-Enhancement-and-Segmentation/figure3.png)

- φの関数

  ![](../assets/img/20180926-Anatomically-Constrained-Neural-Networks-(ACNN)-Application-to-Cardiac-Image-Enhancement-and-Segmentation/figure1.png)

- SRの目的関数

  ![](../assets/img/20180926-Anatomically-Constrained-Neural-Networks-(ACNN)-Application-to-Cardiac-Image-Enhancement-and-Segmentation/figure5.png)

  ![](../assets/img/20180926-Anatomically-Constrained-Neural-Networks-(ACNN)-Application-to-Cardiac-Image-Enhancement-and-Segmentation/figure4.png)

  - weight decay, pixel-wise loss, global loss

  - λ1，λ2は事前形状の重みとweight decay項の重みを決定する

  - global loss LhpはGT HRと合成されたHRから生成されたコードかんのユークリッド距離

- もしsmooth l1 lossだけを使うなら

  ![](../assets/img/20180926-Anatomically-Constrained-Neural-Networks-(ACNN)-Application-to-Cardiac-Image-Enhancement-and-Segmentation/figure6.png)

- 結局，必要なデータ

  - 心臓セグメンテーションマスク（AEを訓練するために）

  - intensity画像

## <font color="SpringGreen"> 4. どうやって有効だと検証した？ </font>

- Full paper辛いので，SRの部分だけ

- データセット

  - UK Digital Heart Project Dataset

  - CETUS’14 Challenge Dataset

  - ACDC MICCAI’17 Challenge Dataset

- 超解像での評価値は，SSIMとMOSテスト

- 訓練1000，テスト200

- LR-HRのClinicalデータ両方を用いて，評価した

- 訓練中は，LR画像はMR acquisition modelを使って，clinical HRデータから人工的に生成された

  ![](../assets/img/20180926-Anatomically-Constrained-Neural-Networks-(ACNN)-Application-to-Cardiac-Image-Enhancement-and-Segmentation/figure7.png)

  ![](../assets/img/20180926-Anatomically-Constrained-Neural-Networks-(ACNN)-Application-to-Cardiac-Image-Enhancement-and-Segmentation/figure8.png)

## <font color="SpringGreen"> 5. 議論はあるか？ </font>

- 心臓のHRとLRが揃っているのに，超解像を行っていない．

- 人工的に，多分ダウンサンプリングしている気がする

  - 読み違い？？

- 画像サイズが小さいからこういうのができるんでね

## <font color="SpringGreen"> 6. 次に読むべき論文はあるか？ </font>

- MR acquisition model

  - H. Greenspan. Super-resolution in medical imaging. The Computer Journal, 52(1):43–63, 2009.

- 心臓のSRのSOTA

  - O. Oktay, W. Bai, M. Lee, R. Guerrero, K. Kamnitsas, J. Caballero, A. de Marvao, S. Cook, D. ORegan, and D. Rueckert. Multi-input cardiac image super-resolution using convolutional neural networks. In International Conference on MICCAI, pages 246–254. Springer, 2016.

- T-L architecture

  - R. Girdhar, D. F. Fouhey, M. Rodriguez, and A. Gupta. Learning a predictable and generative vector representation for objects. In ECCV, pages 484–499. Springer, 2016.

- 基礎となるネットワーク構造

  - A. Sharma, O. Grau, and M. Fritz. Vconv-dae: Deep volumetric shape learning without object labels. In ECCV Workshops, pages 236–250. Springer, 2016.

### <font color="SpringGreen"> 論文情報・リンク </font>

- [Oktay, O., Ferrante, E., Kamnitsas, K., Heinrich, M., Bai, W., Caballero, J., … Rueckert, D. (2017). Anatomically Constrained Neural Networks (ACNN): Application to Cardiac Image Enhancement and Segmentation, 1–13. https://doi.org/10.1109/TMI.2017.2743464](https://arxiv.org/pdf/1705.08302.pdf)
