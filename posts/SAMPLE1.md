---
title: SAMPLE1
auther: tzw
---

### <font color="LightGreen"> 3.3 Generator and Discriminator Architecture </font>

- DCGANとResNetの構造を考える．これらの構造は，どこにでもいるため．128 $\times$ 128の画像で考える

![Figure 1](../assets/img/SAMPLE1/figure1.png)


$$
{\cal L}_D=-\mathbb{E}_{x \sim P} [log(D(x))] - \mathbb{E}_{\hat{x} \sim Q} [log(1-D(\hat{x}))]
$$
