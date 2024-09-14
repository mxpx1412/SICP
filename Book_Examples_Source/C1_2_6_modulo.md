
# Additional Notes on Congruent Modulo $m$

+ *Congruent modulo*: two numbers $a$ and $b$ are "congruent modulo $m$" 
(for some $m\in \mathbb{Z}$, $m\neq 0$) 
if there exists integer $k$ such that $a - b = km$, and we write 
$a \equiv b \pmod{m}$.
+ Following are equivalent for integers $a$, $b$, and $m$ 
(where $m\gt 0$):
    1. Integers $a$, $b$ are *congruent modulo $m$*, i.e. $a\equiv b \pmod{m}$
    2. Integers $a$ and $b$ have the same remainder when divided by $m$.

## *Proof*: 

### "$\implies$": 

+ we have $a \equiv b\pmod{m}$. Express 
$a = q_1 m + r_1$ and $b = q_2 m + r_2$ by Euclidean division, 
where $r_1$ and $r_2$ are the respective remainders of $a$ 
and $b$ when divided by $m$. Then by the premise we have:

$$
\begin{align}
a - b &= km \\
(q_1 m + r_1) - (q_2 m + r_2) &= km \\
(q_1 - q_2)m + (r_1 - r_2) &= km
\end{align}
$$

+ we see that the RHS is divisible by $m$, then the LHS must also 
by divisible by $m$, thus $r_1 - r_2 = lm$ for some integers 
$l$; but by the property of remainder we have $r_1 \in [0, m)$ 
and $r_2 \in [0, m)$. Therefore, $-m < lm = r_1 - r_2 < m$ i.e. 
$ -1 < l < 1$. We see that $l=0$, and so 
$r_1 - r_2 = 0 \implies r_1 = r_2$. This means given 
$a\equiv b\pmod{m}$, we see $a$ and $b$ have the same 
remainder $r_1 = r_2 = r$ when divided by $m$.

### "$\impliedby$":

+ Integers $a$ and $b$ have the same remainder $r$ when 
divided by $m$, then $a=q_1 m + r$ and $b=q_2 m + r$. 
Consider $a-b = (q_1-q_2)m + (r - r)=(q_1 - q_2)m$, we see 
that $a\equiv b\pmod{m}$ with $k=(q_1 - q_2)$.
+ (Q.E.D.)

## Properties of Congruent Modulo $m$

+ The following are properties of congruent modulo $m$:
    + **Reflexive**: $a\equiv a \pmod{m}$, since we see 
    $a-a = 0\cdot m$.
    + **Symmetric**: we see that 
    $a\equiv b\pmod{m} \implies b\equiv a\pmod{m}$, since 
    $a-b=km \implies b-a=-km=lm$ with $l=-k$.
    + **Transitive**: we see that $a\equiv b\pmod{m}$ and 
    $b\equiv \pmod{m}$ means $a\equiv c\pmod{m}$, because: 

$$
\begin{align}
(a-b) + (b-c) &= k_{ab} m + k_{bc} m \\
a-c &= (k_{ab}+k_{bc})m
\end{align}
$$

    + For remaining listed properties, assume premise of $a\equiv b\pmod{m}$ 
    and $c \equiv d\pmod{m}$, where $a-b=km$ and $c-d=lm$:
        + **Compatibility with addition**: 
        $(a+c) \equiv (b+d)\pmod{m}$:
        
$$
\begin{align}
(a-b) - (d-c) &= km + lm \\
(a+c) - (b+d) &= (k+l)m \\
\implies (a+c) &\equiv (b+d)\pmod{m}
\end{align}
$$

    + **Compatibility with multiplication**: 
    $ac \equiv bd \pmod{m}$:
        
$$
\begin{align}
a\equiv b\pmod{m} &\iff a = b + km \\
c\equiv d\pmod{m} &\iff c = d + lm \\
&\therefore \\
ac &= (b + km)(d + lm) \\
ac &= bd + kmd + blm + klm^2 \\
ac - bd &= (kd + bl + klm)m \\
\implies ac &\equiv bd \pmod{m}
\end{align}
$$

