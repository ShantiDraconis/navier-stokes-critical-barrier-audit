# ESTABILIZADO — como seria, em formulação contrafactual auditável

Date: 2026-09-13

## Regra de leitura

Este documento não afirma que Navier--Stokes 3D foi resolvido. Ele especifica
o teorema que seria suficiente:

\[
\mathrm{ActualNS}\Longrightarrow
\mathrm{TypedEntropy}+\mathrm{Noncollapse}+\mathrm{CriticalDecomposition}
\Longrightarrow \mathrm{SignedDepletion}
\Longrightarrow F.
\]

Somente a segunda metade dessa cadeia está fechada condicionalmente. A primeira
seta é o `OPEN_BRIDGE`.

## Correções obrigatórias

### Contagem

Os blocos anteriormente enumerados continham 20 itens antes de `F`, três
refinamentos e o teorema final:

\[
20+3+F=24.
\]

Para usar o rótulo `22 -> 25 -> 3 -> 1`, acrescentam-se explicitamente:

1. `K1d_TYPED_DEFECT`: o defeito variacional pertence a um único espaço de
   Hilbert e sua norma quadrática é bem definida;
2. `G1e_ACTUAL_NS_MAP`: as três estruturas são derivadas de uma solução real
   de NSE, e não apenas assumidas.

Assim há 22 obrigações-base, três refinamentos, três estruturas agregadas e uma
conclusão.

### Parâmetros

A lista numérica contém dez valores, não onze:

\[
\nu,E_0,\kappa_0,\varepsilon_0,\delta_{tail},
\theta,\gamma,\alpha,\Phi,c_0.
\]

Para onze, inclui-se separadamente a constante analítica `C_BS`. Mesmo assim,
`Phi` não deve ser parâmetro livre: sua cota precisa ser conclusão de um lema
não circular.

### Amplitude e escala espacial

Use símbolos distintos:

\[
R_\varepsilon=\sqrt{|\omega|^2+\varepsilon^2},
\qquad
\ell=\text{escala espacial}.
\]

O funcional dimensionalmente homogêneo proposto é

\[
Q_{joint,\varepsilon}
=\ell^2|\nabla\xi_\varepsilon|^2
+\alpha\frac{\ell^2}{\nu}(\xi_\varepsilon\!\cdot S\xi_\varepsilon)_+.
\]

`R_epsilon` regulariza o denominador; `ell` produz a taxa viscosa
`nu / ell^2`.

## As 22 obrigações-base

### K0 — totalização

1. `K0a`: `R_epsilon >= epsilon` e `xi_epsilon` é total.
2. `K0b`: para `omega in W^{1,2}(R^3)`, `z=0 -> y=0`.

### K1 — limite e defeito variacional

3. `K1a`: Chebyshev somente no supernível:

   \[
   |\{|\omega|\ge\delta\}|\le y/\delta^2.
   \]

4. `K1b`: a estimativa ponderada correta é

   \[
   R_\varepsilon^2|\nabla\xi_\varepsilon|^2
   \le |\nabla\omega|^2.
   \]

   Ela não fornece controle uniforme do gradiente sem peso.

5. `K1c`: Fatou/semicontinuidade para a densidade não negativa corretamente
   normalizada.
6. `K1d_TYPED_DEFECT`: existe um defeito `D_NS` tensorial ou vetorial bem
   tipado; não se soma `P_perp S xi` (vetor) diretamente com `Hess f` (tensor).

### G1a — evolução

7. Evolução do componente direcional.
8. Evolução do componente de strain normalizado.
9. Estimativa do comutador sem singularidade residual em `epsilon -> 0`.
10. Controle dos termos de corte e movimento de escala.
11. Detecção do exemplo expansivo. Para `alpha=1`, `Q_joint=2`; em geral,
    `Q_joint=2 alpha`. Isso não exclui todos os modos mortos.

### G1b — absorção

12. Transporte absorvido com custo `gamma_1`.
13. Comutador absorvido com custo `gamma_2`.
14. Orçamento total, incluindo todos os resíduos:

    \[
    \theta_{total}=\gamma_1+\gamma_2+\theta_{tail}
      +\theta_{cutoff}+\theta_{motion}<1.
    \]

### G1c — cauda principal-value

15. Decomposição do kernel em anéis afastados da diagonal ou com principal
    value e cancelamento angular.
16. Controle da cauda excepcional. Dados percentuais não implicam esse lema;
    os proxies observados de 8.46%--18.82% são evidência diagnóstica, não uma
    cota universal de 5%.

### G1d — coeficiente temporal

17. Construção de um multiplicador uniforme que não contenha o endpoint
    `||u||_3`, enstrofia uniforme, palinstrofia ou `z/y`.
18. Com

    \[
    a(t)\le C_*\|\nabla u(t)\|_2^2,
    \]

    a energia fornece

    \[
    \int_0^{T^*}a(t)dt\le C_*E_0/(2\nu).
    \]

### G2--G4

19. Grönwall para a desigualdade de enstrofia.
20. Reconstrução crítica `L-infinity_t L3_x`.
21. Aplicação precisa do endpoint ESS à classe de solução considerada.

### G1e — mapa que decide o prêmio

22. `G1e_ACTUAL_NS_MAP`: toda solução NSE admissível produz os certificados
    K1, evolução, absorção, cauda, multiplicador e orçamento estrito, com
    constantes independentes da solução futura.

## Três refinamentos

23. Ausência de defeito de concentração no limite regularizado.
24. Não-colapso ponderado, formulado com unidades e medida finita precisas.
25. Existência, regularidade e normalização de `f_NS`, junto com o cálculo
    integral completo da derivada da entropia.

## Três estruturas agregadas

### 1. Entropia NSE bem tipada

Seria necessário provar, não postular,

\[
\frac d{dt}\mathcal W_{NS}
+\mathcal D_{NS}
=\mathcal R_{NS},
\qquad
\mathcal D_{NS}=\int|\mathfrak D_{NS}|^2d\mu\ge0,
\]

com

\[
\mathcal R_{NS}\le a(t)\mathcal W_{NS},
\qquad a\in L^1_t.
\]

### 2. Não-colapso crítico

Uma medida ponderada explicitamente definida teria de satisfazer

\[
\mathrm{Vol}_W(B_\ell)\ge\kappa\ell^3
\]

nas regiões e escalas especificadas. Isso é um novo teorema PDE, não uma
consequência dos CSVs sintéticos.

### 3. Decomposição crítica preservando a solução

Não se realiza cirurgia na vorticidade. Usa-se blow-up, localização,
decomposição em perfis ou extração compacta sem alterar `u`, a pressão ou a
equação.

## Cálculo do cenário numérico proposto

Para

\[
\nu=0.01,\quad E_0=1,\quad \theta=0.375,
\]

a margem diferencial é

\[
2(1-\theta)\nu=2(0.625)(0.01)=0.0125.
\]

Se `Phi=0.6` e

\[
\int a\le C\Phi^2E_0/(2\nu),
\]

então

\[
\int a\le18C.
\]

O valor 36 corresponde a `C=2`. Nesse caso, para `y_0=1`,

\[
y(t)\le e^{72}\approx1.858671745\times10^{31},
\]

e

\[
\|u(t)\|_3\lesssim y(t)^{1/4}le e^{18}
\approx6.565996914\times10^7
\]

quando `E0=1` e a constante de reconstrução é normalizada para um. É um bound
finito, porém extremamente grande. O valor `4.17` exigiria

\[
\int a\approx0.713958,
\]

não 36.

Se `Phi=C_H/sqrt(kappa)` com `kappa=0.5`, então:

* `C_H=0.6` implica `Phi ~= 0.848528`;
* `Phi=0.6` implica `C_H ~= 0.424264`.

Essas duas normalizações não podem ser usadas simultaneamente.

## Teorema contrafactual final

Se as 25 obrigações forem demonstradas a partir de `ActualNS`, então:

\[
\mathcal S\le\theta\nu z+ay,
\quad\theta<1,\quad a\in L^1
\]

implica

\[
\sup_{t<T^*}y(t)<\infty
\Longrightarrow
u\in L^\infty_tL^3_x
\Longrightarrow
T^*=\infty.
\]

O status presente permanece:

```text
conditional composition                         = PROVED_LOGIC
typed NSE entropy                               = PROPOSED
NSE noncollapse                                 = PROPOSED
critical decomposition preserving the solution = PROPOSED
ActualNS -> three structures                    = OPEN_BRIDGE
unconditional F                                 = NOT_ESTABLISHED
```

