# 2021-adsp-hw


2. Compute the DFT of two $N$-point real signals $x_1$ and $x_2$ using only one $N$-point DFT.<br />
    DFT:  $X[m]=\sum\limits_{n=0}^{N-1}x[n]e^{-j(2\pi/N)mn}$. When x[n] is real, $X[m]=X^*[N-m]$.<br />
    - Steps :<br />
    (1) $x_3[n]=x_1[n]+jx_2[n]$. <br />
    (2) $X_3[m]=$ DFT of $x_3[n]$.  <br />
    (3) $X_1[m]=\dfrac{X_3[m]+X_3^*[N-m]}{2}$
