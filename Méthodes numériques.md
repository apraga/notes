#maths #mathsappl


## Systèmes linéaires

$$Ax = b$$ Pour des systèmes pleins, méthodes directes.

### Décomposition LU

Si A est inversible, on peut appliquer le pivot de Gauss pour avoir une décomposition 
$A = LU$ , L triangulaire inférieure U triangulaire supérieure
Cout total en $O(\frac{2}{3}n^3)$.\
*Attention:* Si le pivot est trop petit, les approximations numériques peuvent donner de résultats faux. Pivot partiel : on choisit la ligne de coefficient maximal.

### Méthode de Cholesky

Si la matrice A est symétrique définie positive, elle peut se mettre sous la forme $T T^t$ avec T triangulaire inférieure.
Cout total en $O(\frac{1}{3}n^3)$.
Si le système est creux, méthodes itératives. On décompose $A=M-N$ :
$$M x_{k+1} = N x_k + b$$

### Méthode de Jacobi

$M=D$ et $N=A-D$ où D est la diagonale de A.\
Converge ssi à diagonale strictement dominante ($a_{ii} > 0$)
Peu utilisée.

### Méthode de Gauss-Seidel

$M=D+L$ et $N=-U$ où D est la diagonale de A, L triangulaire inférieure,
U triangulaire supérieure.
Peu utilisée.

### Méthode SOR

Gauss-Seidel avec un paramètre de relaxation $\omega$.\
$M=\frac{1}{\omega}D+L$ et $N=\frac{1-\omega}{\omega}D-U$\
Si A est symétrique, définie positive, convergence ssi
$\omega \in [0,2]$

## Fonctions non linéaires

### Méthode de Newton

Permet de trouver les racines de $f(x)=0$
$$x_{k+1} = x_k-Df^{-1}(x_k) f(x_k)$$ Convergence quadratique mais
calcul de la jacobienne couteux.

### Méthode de Broyden

Quasi newton : on approche la jacobienne par
$$J_n(x_n-x_{n-1}) = F(x_n)-F(x_{n-1})$$ Peut être sous déterminé.
D'autres méthodes de calcul de $J_n$ existent.

## Méthodes d'optimisations

Les deux premières méthodes avec le gradient s'appliquent pour des
fonctions $C^1$. Le gradient conjugué s'utilise pour des fonctions
$C^2$.

### Gradient à pas constant

$x_{k+1} = x_k - \rho \nabla f(x_k)$ avec $\rho > 0$ fixé.\
Peu utilisée à cause d'instabilités numériques.

### Méthode de plus grande descente

$$x_{k+1} = x_k - \rho_k \nabla f(x_k)$$ $\rho_k$ est adapté à chaque
étape en minimisant $$\phi(\rho)=f(x_k - \rho_k \nabla f(x_k))$$ Si f
est convexe, on peut utiliser la méthode de Newton pour résoudre
$\phi'(\rho)=0$. On peut aussi procédér par dichotomie : sur $[a,b]$, f
doit être unimodale[^1] Convergence linéaire.

### Gradient conjugué

Pour une fonction quadratique $f(x)=\frac{1}{2} x^t A x - x^t b$.\
Soit $r k=Ax_k-b$. Itération : $x_{k+1}=x_k-\rho_k \omega_k$ avec
$$\left\{
\begin{array}{l}
\omega_k =r_k+\theta_k \omega_{k-1} \text{ et }
\theta_k=\frac{||r_k||_2^2}{||r_{k-1}||_2^2}\\
\rho_k =\frac{||r_k||_2^2}{w_k^t A w^k}
\end{array}
\right.$$

# EDP

## EDP linéaires d'ordre 1

On veut résoudre $$\nabla \phi(X)\cdot F(x)+g(X)\phi(X) = h(X)$$ Les
caractéristiques sont données par $$\frac{dX}{ds}=F(X)$$ Sur les
caractéristiques, cela revient à résoudre une EDP d'ordre 1
$$\frac{d \phi(X(s))}{ds}=-g(X(s)) \phi(X(s)) + h(X(s))$$

## EDP linéaires d'ordre 2

$$a(x,y) \frac{\partial^2 u}{\partial x^2}+
b(x,y) \frac{\partial^2 u}{\partial x \partial y}+
c(x,y) \frac{\partial^2 u}{\partial y^2}+
f(x,y,\frac{\partial u}{\partial x}, \frac{\partial u}{\partial y})=0$$
On fait une discussion sur le type d'EDP sur un domaine D.

### Cas hyperbolique

Si $b^2-4ac > 0$, on fait un changement de coordonnées pour avoir 2
équations de transports : $$\left\{
\begin{array}{l}
2a \xi_x+(b-\sqrt{b^2-4ac}) \xi_x = 0\\
2a \eta_x+(b-\sqrt{b^2-4ac}) \eta_x = 0\\
\end{array}
\right.$$

Forme canonique :
$$\frac{\partial^2 v}{\partial \xi \partial \eta}=G(\xi,\eta,v,
\frac{\partial v}{\partial \xi},\frac{\partial v}{\partial \eta})$$

### Cas parabolique

Si $b^2-4ac = 0$, on fait un changement de coordonnées pour avoir 2
équations de transports : $$\left\{
\begin{array}{l}
2a \xi_x+ b \xi_x=0\\
\eta \text{ est choisi tel que } \phi \text{ est un } C^2 \text{-diff\'eomorphisme}
\end{array}
\right.$$

Forme canonique : $$\frac{\partial^2 v}{\partial \eta^2}=G(\xi,\eta,v,
\frac{\partial v}{\partial \xi},\frac{\partial v}{\partial \eta})$$

### Cas elliptique

Forme canonique : $$\frac{\partial^2 v}{\partial \xi^2}
+\frac{\partial^2 v}{\partial \eta^2}+G(\xi,\eta,v,
\frac{\partial v}{\partial \xi},\frac{\partial v}{\partial \eta})=0$$

A COMPLETER

## Schémas numériques

### Consistance, convergence, stabilité

Discrétisation : $u_{n+1}=C(\Delta t,\Delta x) u_n$\
Consistance d'un schéma : caractérise l'erreur de troncature.
$$\lim_{(\Delta t,\Delta x)\rightarrow 0} 
\sup_{t_n} ||\frac{u(t_n+\Delta t)-C(\Delta t,\Delta x)u(t_n)}{\Delta t}||=0$$
Schéma d'ordre r en espace et q en temps
$$\sup_{t_n} ||u(t_n+\Delta t)-C(\Delta t,\Delta x)u(t_n)||=
O(|\Delta t|^{q+1}+
|\Delta t| |\Delta x |^r)$$ Stabilité d'un schéma : Il existe une
constante $K_T$ telle que $\forall \Delta x, \Delta t, n \Delta t \le T$
$$|| C(\Delta t,\Delta x)^n|| \le K_T$$ Convergence d'un schéma :
L'écart entre la solution approchée et la solution exacte tend vers 0
quand le pas de discrétisation tend vers 0.\
Théorême de Lax : soit un schéma consistant. Alors il est convergent ssi
il est stable.\
Analyse de von Neumann : prendre la transformée de Fourier
$$\hat{U}^{n+1}(\lambda)=G(\Delta x, \Delta t, 2\pi \lambda) \hat{U}^n$$
Stabilité : Il existe une constante $K_T$ telle que
$\forall \Delta x, k, \Delta t, n \Delta t \le T$
$$|| G(\Delta t,\Delta x,k)^n|| \le K_T$$ Soit $\lambda_i$ les valeurs
propres de G.\
Théoreme de von Neumann :\
CN de stabilité $$\sup_k \max_i |\lambda_i| \le 1+O(|\Delta t|)$$ Si G
est normale, c'est une CNS.

### Types de schémas

Exemple de l'équation de transport.

#### Schéma euler explicite décentré

Aval :
$$\frac{u_j^{n+1}- u_j^n}{\Delta t} +c \frac{u_j^n- u_{j-1}^n}{\Delta x}=0$$
Ordre 1 en espace et 1 en temps pour l'équation de transport.\
Toujours instable\
Amont : Stable si $c \frac{\Delta x}{\Delta t} \le 1$

#### Schéma euler explicite centré

$$\frac{u_j^{n+1}- u_j^n}{\Delta t} +
c \frac{u_{j+1}^n- u_{j-1}^n}{2 \Delta x}=0$$ Ordre 2 en espace et 1 en
temps pour l'équation de transport.\
Instable si $\frac{\Delta x}{\Delta t}$ reste constant.

#### Schéma de Lax Wendrof

$$\frac{u_j^{n+1}- u_j^n}{\Delta t} +
c \frac{u_{j+1}^n- u_{j-1}^n}{2 \Delta x}-
\frac{c^2}{2}\frac{\Delta t}{\Delta x^2} 
\frac{u_{j+1}^n+2 u_j- u_{j-1}^n}{2 \Delta x}=0$$ Ordre 2 en temps et en
espace.\
Stable si $|c| \frac{\Delta x}{\Delta t} \le 1$

