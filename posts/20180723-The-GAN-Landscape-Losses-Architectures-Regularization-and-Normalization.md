---
layout: post
title:  The GAN Landscape: Losses, Architectures, Regularization, and Normalization
date:   2018-07-23
output: pdf_document
---
<!--
https://github.com/shunk031/paper-survey
-->

## 1. どんなもの？

実践的な視点からGANsの現状を分析した論文．  
GAN Landscapeを深く調査するだけでなく，現状のSOTAを再現した．

## 2. 先行研究と比べてどこがすごいの？

先行研究の調査論文.  
Loss, Regularization and Normalization, architecturesの3つ観点からGAN Landscapeを調査.  
落とし穴，再現性の問題，実践的な考慮事項を議論．

## 3. 技術や手法の"キモ"はどこにある？

### 3.1 Loss Functions
- $Q$をモデル分布，$P$をターゲット分布とする

- Non-saturating loss[8]
  - $P$と$Q$間のJensen-Shannon divergenceを最小化することに等しい．
$$
{\cal L}_D=-\mathbb{E}_{x \sim P} [log(D(x))] - \mathbb{E}_{\hat{x} \sim Q} [log(1-D(\hat{x}))] \\
{\cal L}_G=- \mathbb{E}_{\hat{x} \sim Q} [log(D(\hat{x}))]
$$

- Wasserstein GAN(WGAN)[2]
  - $P$と$Q$間のWasserstein distanceを最小化する．
  - 最適なDiscriminatorのもとで証明されている最適輸送への接続を利用することで，Generatorに関する評価関数の最小化は，PとQ間のWasserstein距離の最小化である．
  - 欠点は，Kantorovich-Rubinstein 双対性を利用することによる1-Lipschitz Discriminatorを補償しなければならないこと．
$$
{\cal L}_D=-\mathbb{E}_{x \sim P} [D(x)] + \mathbb{E}_{\hat{x} \sim Q} [D(\hat{x})] \\
{\cal L}_G=- \mathbb{E}_{\hat{x} \sim Q} [D(\hat{x})]
$$

- Least squared loss[19]
  - $P$と$Q$間のPearson　$\chi^2$ divergenceを最小化することに対応．
  - 直観的に，この損失は滑らかで，JS定式化のsigmoid cross entropyよりゆっくりと飽和する．
$$
{\cal L}_D=-\mathbb{E}_{x \sim P} [(D(x)-1)^2] + \mathbb{E}_{\hat{x} \sim Q} [D(\hat{x})^2] \\
{\cal L}_G=- \mathbb{E}_{\hat{x} \sim Q} [(D(\hat{x})-1)^2]
$$

### Regularization and Normalization of the Discriminator
-

<!---
![Figure 1](../assets/img/(title)/figure1.png)
-->

## 4. どうやって有効だと検証した？

## 5. 議論はあるか？

## 6. 次に読むべき論文はあるか？

### 論文情報・リンク

- [著者，"タイトル，" ジャーナル名，voluem，no.，ページ，年](論文リンク)
