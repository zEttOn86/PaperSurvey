---
title:  "ESRGAN: Enhanced Super-Resolution Generative Adversarial Networks"  
date:   2018-09-11
---

## <font color="MediumSpringGreen"> 1. どんなもの？ </font>

- PISR2018-SR Challenge(Region3)の1位の手法

- SRGANをネットワーク構造，adversarial loss，perceptual lossの３つ観点から改造

## <font color="MediumSpringGreen"> 2. 先行研究と比べてどこがすごいの？ </font>

- PISR2018-SR Challengeのperceptual indexの評価値において，1位の手法

## <font color="MediumSpringGreen"> 3. 技術や手法の"キモ"はどこにある？ </font>

- ネットワーク構造

  - 不自然な模様を生成することがあるため，BNを取り外す

  - Residual Blockを Residual-in-Residual Dense Block(RRDB)に置き換える

  ![Figure 1](../assets/img/20180911-ESRGAN-Enhanced-Super-Resolution-Generative-Adversarial-Networks/figure1.png)

  - BNを外すことで計算コストを下げ，性能を向上させるが，ネットワークの規模を大きくする必要がある？

  - $\beta$ というresidual scaling パラメータを導入

  - 初期パラメータの分散をより小さくなるようにしたとき，訓練しやすくなる

- Relativitic Discriminator(相対的Discriminator)

  - 「その画像が本物か偽物かどうか」ではなく，「その画像が他のものより写実的であるかどうか」を判定

  ![Figure 2](../assets/img/20180911-ESRGAN-Enhanced-Super-Resolution-Generative-Adversarial-Networks/figure2.png)

  - $\sigma$ はシグモイド関数，$C(x)$ は変換されていないDiscriminatorの出力

  - Discriminator loss

    ![Figure 3](../assets/img/20180911-ESRGAN-Enhanced-Super-Resolution-Generative-Adversarial-Networks/figure3.png)

     ![Figure 4](../assets/img/20180911-ESRGAN-Enhanced-Super-Resolution-Generative-Adversarial-Networks/figure4.png)

  - Generator loss

    ![Figure 5](../assets/img/20180911-ESRGAN-Enhanced-Super-Resolution-Generative-Adversarial-Networks/figure5.png)

    - Perceptual lossまで含めると

    ![Figure 6](../assets/img/20180911-ESRGAN-Enhanced-Super-Resolution-Generative-Adversarial-Networks/figure6.png)

    ![Figure 7](../assets/img/20180911-ESRGAN-Enhanced-Super-Resolution-Generative-Adversarial-Networks/figure7.png)

    - $y$ : ground truth, $G(x_i)$ : 復元画像


- Perceptual loss

  - 活性化前を用いた方がよい

## <font color="SpringGreen"> 4. どうやって有効だと検証した？ </font>

- 使用データセット

  - DIV2K dataset

    - Agustsson, E., Timofte, R.: Ntire 2017 challenge on single image super-resolution: Dataset and study. In: CVPRW. (2017)

  - Flickr2K dataset

    - Timofte, R., Agustsson, E., Van Gool, L., Yang, M.H., Zhang, L., Lim, B., Son, S., Kim, H., Nah, S., Lee, K.M., et al.: Ntire 2017 challenge on single image super-resolution: Methods and results. In: CVPRW. (2017)

- 学習設定

  - パッチサイズ： 128*128

  - L1でpretraining, lr = 1*10^-4

    - lr decayを使ってるわ，これ

  - random horizontal flip, 90 degree rotations

- 結果画像

    ![Figure 8](../assets/img/20180911-ESRGAN-Enhanced-Super-Resolution-Generative-Adversarial-Networks/figure8.png)

## <font color="SpringGreen"> 5. 議論はあるか？ </font>

- L1を使うか迷う

- 今やってるやつパッチサイズ小さいんじゃね？？

## <font color="SpringGreen"> 6. 次に読むべき論文はあるか？ </font>

- 評価値

  - Ma’s score

    - Ma, C., Yang, C.Y., Yang, X., Yang, M.H.: Learning a no-reference quality metric for single-image super-resolution. CVIU 158 (2017) 1–16

  - NIQE

    - Mittal, A., Soundararajan, R., Bovik, A.C.: Making a completely blind image quality analyzer. IEEE Signal Process. Lett. 20(3) (2013) 209–212

  - perceptual-quality aware manner

    - Blau, Y., Michaeli, T.: The perception-distortion tradeoff. In: CVPR. (2017)

- semantic image priorを導入したやつ

  - Wang, X., Yu, K., Dong, C., Loy, C.C.: Recovering realistic texture in image super-resolution by deep spatial feature transform. In: CVPR. (2018)

- Relativistic GAN

  - Jolicoeur-Martineau, A.: The relativistic discriminator: a key element missing from standard gan. arXiv preprint arXiv:1807.00734 (2018)

- back projection

  - PSNRとperceptual indexを上げるために，後処理として使用

  - Timofte, R., Rothe, R., Van Gool, L.: Seven ways to improve example-based single image super resolution. In: CVPR. (2016)

### <font color="SpringGreen"> 論文情報・リンク </font>

- [Dong, C., Loy, C. C., Qiao, Y., & Tang, X. (n.d.). ESRGAN : Enhanced Super-Resolution.](https://arxiv.org/abs/1809.00219)
