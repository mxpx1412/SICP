# Exercise 1.1

+ [Exercise 1.1](./Exercise_Source/E1_1.scm)

# Exercise 1.2

+ [Exercise 1.2](./Exercise_Source/E1_2.scm)

```scheme
1 ]=> (/ 
  (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) 
  (* 3 (- 6 2) (- 2 7)))
;Value: -37/150
```

# Exercise 1.3

+ [Exercise 1.3](./Exercise_Source/E1_3.scm)
+ [Exercise 1.3b](./Exercise_Source/E1_3b.scm)

```scheme
1 ]=> ;
(define (sum-max-squares x y z) 
  (define minimum (min x y z))
  (cond 
    ((= minimum x) (+ (* y y) (* z z)))
    ((= minimum y) (+ (* x x) (* z z)))
    (else (+ (* x x) (* y y)))
    )
  )
;Value: sum-max-squares

1 ]=> (sum-max-squares 1 2 -3)
;Value: 5
```

# Exercise 1.4

+ [Exercise 1.4](./Exercise_Source/E1_4.scm)

```scheme
1 ]=> ;
(define (a-plus-abs-b a b) 
  ((if (> b 0) + -) a b))
;Value: a-plus-abs-b

1 ]=> #| 
Behaviour: if b greater than zero, execute a + b, 
but if b smaller than zero (negative), execute a - b, 
such that the expression essentially is a + |b| 
|#

(a-plus-abs-b 2 3)
;Value: 5

1 ]=> (a-plus-abs-b 2 -3)
;Value: 5
```

# Exercise 1.5

```scheme
(define (p) (p))
(define (test x y)
	(if (= x 0) 0 y))

(test 0 (p))
```
+ If this is applicative-order, the expression would not evaluate 
correctly. When the arguments are first being evaluated, `(p)` will 
infinitely call itself.
+ If this is normal-order, the expression will yield 0. The values 
of the operands are not called until they are needed, so the 
expression is first expanded into:

```scheme
(if (= 0 0) 0 (p))
```

+ ... then by the evaluation rule of `if` as a special form, the 
predicate is evaluated first, which returns true in this case, then 
it returns the consequent expression when predicate is true, which 
is `0`.

# Exercise 1.6

+ [Exercise 1.6](./Exercise_Source/E1_6.scm)
+ Even though `cond` is normally a special form that evaluates the 
predicates and then the consequent value iff the predicate is true, 
defining it as `new-if` changes this and instead uses the regular 
applicative-order evaluation.
+ As a result, when `new-if` is called inside `sqrt-iter`, it 
attempts to evaluate its operands, which calls `sqrt-iter` again 
resulting in recursion that never stops.
+ As such the maximum recursion depth is quickly reached and the 
program stops altogether due to error.

```scheme
1 ]=> ;
(define (new-if predicate then-clause else-clause) 
  (cond (predicate then-clause) 
        (else else-clause)))
;Value: new-if

1 ]=> ;
(define (sqrt-iter guess x) 
  (new-if (good-enough-sqrt guess x) 
          guess 
          (sqrt-iter (improve-sqrt guess x) x)))
;Value: sqrt-iter

1 ]=> (define (sqrt x) (sqrt-iter 1.0 x))
;Value: sqrt

1 ]=> (sqrt 9.0)
;Aborting!: maximum recursion depth exceeded
```

# Exercise 1.7

+ [The original program](./Exercise_Source/E1_7a.scm)
+ If small number such as `0.0001` was tried in the original `sqrt` 
function, the result is shown to be `0.03230844833048122`, but we 
know from basic arithmetic $\sqrt{0.0001}=0.01$. When the numbers 
are smaller than the tolerance of `0.001` initially imposed, the 
program will terminate even though the error is large relative to 
the numbers.
+ If a large number such as `99999999999999999999` or 
$\sum_{i=0}^{19}9\cdot 10^i$ is given as input, the result from the original 
program is `10000000000.`. We know from basic arithmetic that 
$10000000000^2={10}^{20}$, which is a difference of $1$ from the 
input. This is much larger than the tolerance of $0.001$, but it is 
not caught due to truncation and rounding when working with large 
numbers. 
```scheme
1 ]=> (define test_num 99999999999999999999)
;Value: test_num

1 ]=> (sqrt test_num)
;Value: 10000000000.
```
+ [Exercise 1.7](./Exercise_Source/E1_7.scm) implements a new test 
following new method recommended in exercise. The program now tests 
to see if an improved root is $<0.0001\%$ different than a previous 
root guess. This solves the issue for small numbers, however for 
large numbers the program can perform worse than before, as a fraction 
of a large number can be much greater than $0.001$ or even $1$.
```scheme
1 ]=> (define test_num 99999999999999999999)
;Value: test_num

1 ]=> (sqrt test_num)
;Value: 10000000000.023079

1 ]=> (square (sqrt test_num))
;Value: 1.0000000000046159e20
```
+ *Additional remarks*: consulting solutions by other students, it 
seems that in the previous program, large numbers often just fail to 
converge as the smallest possible difference between 
$\mathrm{guess}^2$ and $x$ is larger than $0.001$. In which case the 
modified program will perform better. Considering the tolerance as a 
fraction of the guesses allows for a larger absolute error (but a 
small relative error) thus allowing for convergence of some very large 
inputs.
+ For specific implementation of scheme and personal hardware used, 
the original program seem to handle very large inputs better than 
scheme implementations used by other students online. So for large 
numbers the original program sometimes perform better than the 
original program personally.

# Exercise 1.8

+ [Exercise 1.8](./Exercise_Source/E1_8.scm)

```scheme
1 ]=> ;
(define (improve-cube guess x) 
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))
;Value: improve-cube

1 ]=> ;
(define (cube-iter guess x) 
  (if (good-enough-cube guess x) 
    guess 
    (cube-iter (improve-cube guess x) x)))
;Value: cube-iter

1 ]=> ;
(define (cbrt x) 
  (cube-iter 1.0 x))
;Value: cbrt

1 ]=> (cbrt 1000)
;Value: 10.000000145265767

1 ]=> (* (cbrt 1000) (cbrt 1000) (cbrt 1000))
;Value: 1000.0000435797309
```

# Exercise 1.9

+ [Exercise 1.9](./Exercise_Source/E1_9.scm)
+ First procedure in subsitution model:

```scheme
(+ 4 5)
(inc (+ (dec 4) 5))
(inc (+ 3 5))
(inc (inc (+ (dec 3) 5)))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ (dec 2) 5))))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ (dec 1) 5)))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)

9
```

+ The first procedure is a recursive process as a growing 
deferred chain of operation exists before final evaluation 
(growing `inc`).
+ Second procedure in substitution model:

```scheme
(+ 4 5)
(+ (dec 4) (inc 5))
(+ 3 6)
(+ (dec 3) (inc 6))
(+ 2 7)
(+ (dec 2) (inc 7))
(+ 1 8)
(+ (dec 1) (inc 8))
(+ 0 9)

9
```

+ The second procedure is an iterative process as the program 
variables completely describe state of process, there is no 
growing chain of deferred operations.
+ Note that first procedure calls itself nested in another 
expression, while second procedure calls itself but as top 
expression.

# Exercise 1.10

+ [Exercise 1.10](./Exercise_Source/E1_10.scm)
+ Value for `(A 1 10)`:

```scheme
(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
(A 0 (A 0 (A 0 (A 1 7))))
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 4))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 8)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (* 2 16))))))
(A 0 (A 0 (A 0 (A 0 (A 0 32)))))
(A 0 (A 0 (A 0 (A 0 (* 2 32)))))
(A 0 (A 0 (A 0 (A 0 64))))
(A 0 (A 0 (A 0 (* 2 64))))
(A 0 (A 0 (A 0 128)))
(A 0 (A 0 (* 2 128)))
(A 0 (A 0 256))
(A 0 (* 2 256))
(A 0 512)
(* 512)
1024
```

+ Value for `(A 2 4)`:

```scheme
(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 (* 2 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 (* 2 2))))
(A 1 (A 0 (A 0 4)))
(A 1 (A 0 (* 2 4)))
(A 1 (A 0 8))
(A 1 (* 2 8))
(A 1 16)
(A 0 (A 1 15))
(A 0 (A 0 (A 1 14)))
(A 0 (A 0 (A 0 (A 1 13))))
(A 0 (A 0 (A 0 (A 0 (A 1 12)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6)))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
(A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
(A 0 (A 0 (A 0 (A 0 4096))))
(A 0 (A 0 (A 0 8192)))
(A 0 (A 0 16384))
(A 0 32768)
65536
```

+ Value for `(A 3 3)`:

```scheme
(A 3 3)
(A 2 (A 3 2))
(A 2 (A 2 (A 3 1)))
(A 2 (A 2 2))
(A 2 (A 1 (A 2 1)))
(A 2 (A 1 2))
(A 2 (A 0 (A 1 1)))
(A 2 (A 0 2))
(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 4)))
(A 1 (A 0 8))
(A 1 16)
#| ... |#
65536
```

+ In general:
+ $f(n) = A(0, n) = 2n$
+ $g(0) = 0$, $g(n) = A(1, n) = 2^n$ for $n>0$
+ $h(0) = 0$, $h(1) = 1$, $h(n) = A(2, n) = A(1, 2^n) = 2^{2^{\dots^2}}$ 
i.e. $2$ raised to the power of $2$ for $n$ times, in other words for 
$n>1$, $h(n) = {}^n 2$ (*tetration*).

# Exercise 1.11
+ [Recursive process for $f(n)$](./Exercise_Source/E1_11a.scm)
```scheme
1 ]=> #| Recursive process for exercise function |#

(define (f n) 
  (if (< n 3) 
    n 
    (+ (f (- n 1)) 
       (* 2 (f (- n 2))) 
       (* 3 (f (- n 3))))))
;Value: f

1 ]=> (f 5)
;Value: 25
```
+ [Iterative process for $f(n)$](./Exercise_Source/E1_11b.scm)
```scheme
1 ]=> #| Iterative process for exercise function |#

(define (f n) 
  (define (f-iter f_1 f_2 f_3 count) 
    (if (> 3 count) 
      f_1 
      (f-iter (+ f_1 (* 2 f_2) (* 3 f_3)) f_1 f_2 (- count 1))))
  (if (< n 3) 
    n
    (f-iter 2 1 0 n)))
;Value: f

1 ]=> (f 5)
;Value: 25
```

# Exercise 1.12

+ *Pascal's triangle*: numbers on edges are 1, numbers inside are 
sum of two numbers above each.
+ [Recursive process for Pascal's triangle](./Exercise_Source/E1_12.scm)
```scheme
1 ]=> (Pascal-triangle 16)
                                                             1  
                                                         1       1  
                                                     1       2       1  
                                                 1       3       3       1  
                                             1       4       6       4       1  
                                         1       5       10      10      5       1  
                                     1       6       15      20      15      6       1  
                                 1       7       21      35      35      21      7       1  
                             1       8       28      56      70      56      28      8       1  
                         1       9       36      84     126     126      84      36      9       1  
                     1       10      45     120     210     252     210     120      45      10      1  
                 1       11      55     165     330     462     462     330     165      55      11      1  
             1       12      66     220     495     792     924     792     495     220      66      12      1  
         1       13      78     286     715     1287    1716    1716    1287    715     286      78      13      1  
     1       14      91     364     1001    2002    3003    3432    3003    2002    1001    364      91      14      1  
 1       15     105     455     1365    3003    5005    6435    6435    5005    3003    1365    455     105      15      1  
;Unspecified return value
```

# Exercise 1.13

## Exercise 1.13 Proposition

$\mathrm{Fib}(n)$ is the closest integer to 
$\frac{\varphi^n}{\sqrt{5}}$ where $\varphi = \frac{(1+\sqrt{5})}{2}$. 

### *Proof of Exercise 1.13 Proposition*

First proving the below lemmas.

---

#### Exercise 1.13.a Lemma

Define $\psi$ where:  

$$
\psi = \frac{1-\sqrt{5}}{2}
$$
 
... then: 

$$
\mathrm{Fib}(n) = \frac{\varphi^n - \psi^n}{\sqrt{5}}
$$

##### Proof of Exercise 1.13.a Lemma

We will prove the lemma using induction. 

###### Base Case $n=0$

By definition of $\mathrm{Fib}(n)$, $\mathrm{Fib}(0) = 0$. 
Then we see: 

$$
\frac{\varphi^0 - \psi^0}{\sqrt{5}} = 
\frac{1-1}{\sqrt{5}} = 0 = \mathrm{Fib}(0)
$$

###### Base Case $n=1$

By definition of $\mathrm{Fib}(n)$, $\mathrm{Fib}(1) = 1$. 
Then we see: 

$$
\begin{align}
\frac{\varphi^1 - \psi^1}{\sqrt{5}} 
  &= \left(\frac{1+\sqrt{5}}{2} - \frac{1-\sqrt{5}}{2}\right)
   \frac{1}{\sqrt{5}} \\
  &= \frac{2\cdot\sqrt{5}}{2}\cdot\frac{1}{\sqrt{5}} \\
  &= \frac{\sqrt{5}}{\sqrt{5}} \\
  &= 1 \\
\implies \frac{\varphi^1 - \psi^1}{\sqrt{5}} 
  &= \mathrm{Fib}(1)
\end{align}
$$

###### Inductive Step

Assume for some $n>1$, we have: 

$$
\mathrm{Fib}(n) = \frac{\varphi^n - \psi^n}{\sqrt{5}}
$$

... and: 

$$
\mathrm{Fib}(n+1) = \frac{\varphi^{n+1} - \psi^{n+1}}{\sqrt{5}}
$$
 
From definition we know 
$\mathrm{Fib}(n+2)=\mathrm{Fib}(n)+\mathrm{Fib}(n+1)$. 
Then we have: 

$$
\begin{align}
\mathrm{Fib}(n+2) 
  &= \mathrm{Fib}(n) + \mathrm{Fib}(n+1) \\
  &= \frac{\varphi^{n} - \psi^{n}}{\sqrt{5}}
    + \frac{\varphi^{n+1} - \psi^{n+1}}{\sqrt{5}} \\
  &= \left(\varphi^n + \varphi^{n+1} - \psi^n - \psi^{n+1}\right) 
    \cdot \frac{1}{\sqrt{5}} \\
\implies \mathrm{Fib}(n+2) 
  &= \left(\varphi^n(1+\varphi) - \psi^n(1+\psi)\right)
    \cdot \frac{1}{\sqrt{5}}
\end{align}
$$

But observe:

$$
\begin{align}
1+\varphi 
  &= 1 + \frac{1+\sqrt{5}}{2} \\
  &= \frac{2 + 1 + \sqrt{5}}{2} \\
  &= \frac{3 + \sqrt{5}}{2} \\
  &= \frac{6 + 2\cdot\sqrt{5}}{4} \\
  &= \frac{1 + \sqrt{5} + \sqrt{5} + 5}{4} \\
  &= \frac{(1+\sqrt{5})(1+\sqrt{5})}{2\cdot2} \\
  &= \frac{1+\sqrt{5}}{2} \cdot \frac{1+\sqrt{5}}{2} \\
  &= \varphi \cdot \varphi \\
\implies 1+\varphi
  &= \varphi^2
\end{align}
$$

Similarly, we have: 

$$
\begin{align}
1+\psi 
  &= 1 + \frac{1-\sqrt{5}}{2} \\
  &= \frac{2 + 1 - \sqrt{5}}{2} \\
  &= \frac{3 - \sqrt{5}}{2} \\
  &= \frac{6 - 2\cdot\sqrt{5}}{4} \\
  &= \frac{1 - \sqrt{5} - \sqrt{5} + 5}{4} \\
  &= \frac{(1-\sqrt{5})(1-\sqrt{5})}{2\cdot2} \\
  &= \frac{1-\sqrt{5}}{2} \cdot \frac{1-\sqrt{5}}{2} \\
  &= \psi \cdot \psi \\
\implies 1+\psi 
  &= \psi^2
\end{align}
$$

So we have: 

$$
\begin{align}
\mathrm{Fib}(n+2) 
  &= \left(\varphi^n(1+\varphi) - \psi^n(1+\psi)\right)
    \cdot \frac{1}{\sqrt{5}} \\
  &= \left(\varphi^n \cdot \varphi^2 - \psi^n \cdot \psi^2\right) 
    \cdot \frac{1}{\sqrt{5}} \\
\implies \mathrm{Fib}(n+2) 
  &= \frac{\varphi^{n+2} - \psi^{n+2}}{\sqrt{5}}
\end{align}
$$

So if $\mathrm{Fib}(n)=(\varphi^n+\psi^n)/\sqrt{5}$ and 
$\mathrm{Fib}(n+1) = (\varphi^{n+1}+\psi^{n+1})/\sqrt{5}$ 
then $\mathrm{Fib}(n+2) = (\varphi^{n+2}+\psi^{n+2})/\sqrt{5}$. 
This completes the inductive step, and proves the 
Exercise 1.13.a Lemma. 

(Q.E.D)

---

#### Exercise 1.13.b Lemma 

If $r \in \mathbb{R}$ and $k \in \mathbb{Z}$ and 
$\left|k-r\right| \lt \frac{1}{2}$, then $k$ is the closest 
integer to $r$.

##### Proof of Exercise 1.13.b Lemma

###### Case $k \gt r$

If $k \gt r$ then $|k-r| = k-r$. From premise 
$k-r \lt \frac{1}{2}$. Consider some arbitrary $l\in\mathbb{Z}$ 
where $l \gt 0$. 

Since $k \gt r \implies |k-r| = k-r$, and since 
$|k-r| < \frac{1}{2}$, we have $k-r < \frac{1}{2}$. 
Then we see $k-\frac{1}{2} \lt r$. Then since $l \gt 0$, 
we have: 

$$
 k \gt r \gt k - \frac{1}{2} \gt k-1 \geq k-l 
$$

$$
\therefore k \gt r \gt k-l
$$

Then consider $|r - (k-l)|$. Since $r > k-l$, we have: 

$$
\begin{align}
|r - (k-l)| 
  &= r - (k-l) \\
  &= l + (r - k) \\
|r - (k-l)| 
  &= l - (k - r)
\end{align}
$$

But recall $k-r \lt \frac{1}{2}$, then: 

$$
\begin{align}
(k-r) &\lt \frac{1}{2} \\
-(k-r) &\gt -\frac{1}{2} \\
l-(k-r) &\gt l-\frac{1}{2}
\end{align}
$$

Thus: 

$$

  |r-(k-l)| = l-(k-r) \gt l-\frac{1}{2} 
  \geq 1-\frac{1}{2} = \frac{1}{2}

$$

$$

  \therefore |r-(k-l)| > \frac{1}{2}

$$

So $k-l$ is no closer to $r$ than $k$, since 
$|k-r|=|r-k|\lt\frac{1}{2}<|r-(k-l)|$. Since $l$ is an 
arbitrary integer and $l \gt 0$, we see that $k-l$ can be 
any integer smaller than $k$. Thus we have shown that all 
integers smaller than $k$ is no closer to $r$ than $k$ 
is. 

Then let us consider $k+l$. We see $k+l \gt k \gt r$ so: 

$$

  |(k+l)-r| = (k+l)-r = (k-r)+l \geq (k-r)+1 \gt 0+1 \gt \frac{1}{2}

$$

$$

  \therefore |(k+l)-r|>\frac{1}{2}

$$

So $k+l$ is also no closer to $r$ than $k$ since 
$|k-r|=k-r \lt \frac{1}{2} \lt |(k+l)-r|$. Since $k+l$ 
can be any arbitrary integer larger than $k$, we see that 
all integers greater than $k$ are no closer to $r$ than 
$k$. Altogether, we see that if $k \gt r$ and 
$|k-r|\lt \frac{1}{2}$, then $k$ is the closest integer to 
$r$. This proves the proposition for this case.

###### Case $r > k$

We still have $|k-r|=|r-k|\lt\frac{1}{2}$ from our premise. 
Consider again $l\in\mathbb{Z}$ where $l\gt 0$. Then for 
$k+l$, we see that: 

$$

  |k-r| = |r-k| = r-k \lt \frac{1}{2} \implies r \lt k + \frac{1}{2}

$$

Thus: 

$$

  k+l \geq k+1 \gt k+\frac{1}{2} \gt r \gt k \implies k+l\gt r\gt k

$$

Then consider $|(k+l)-r|$. Since $k+l \gt r$, we have: 

$$
\begin{align}
|(k+l)-r|
  &= (k+l) - r\\
  &= l+(k-r) \\
|(k+l)-r|
  &= l-(r-k) \\
\end{align}
$$

But recall $r-k\lt \frac{1}{2}$, then:

$$
\begin{align}
  r-k &\lt \frac{1}{2} \\
  -(r-k) &\gt -\frac{1}{2} \\
  l-(r-k) &\gt l-\frac{1}{2}
\end{align}
$$

Thus:

$$

|(k+l)-r| = l-(r-k) \gt l-\frac{1}{2} \gt 1-\frac{1}{2} \gt \frac{1}{2}

$$

$$

\therefore |(k+l)-r| \gt \frac{1}{2}

$$

So $k+l$ is no closer to $r$ than $k$, since 
$|k-r|=|r-k| \lt \frac{1}{2} \lt |(k+l)-r|$. Again since $l$ is an 
arbitrary integer and $l\gt 0$, we see that $k+l$ can be any 
integer larger than $k$. Thus we have shown that in case of $r\gt k$, 
no integer larger than $k$ are closer to $r$ than $k$.

Then let us consider $k-l$. We see $r \gt k \gt k-l$ so: 

$$

  |(k-l)-r| = r-(k-l) = (r-k)+l \geq (r-k)+1 \gt 0+1 \gt \frac{1}{2}

$$

$$

  \therefore |(k-l)-r| \gt \frac{1}{2}

$$

So similarly $k-l$ is no closer to $r$ than $k$ since 
$|k-r|=r-k \lt \frac{1}{2} \lt |(k-l)-r|$. Since $k-l$ 
can be any arbitrary integer smaller than $k$, we see that all 
integers smaller than $k$ are no closer to $r$ than $k$. Altogether 
we see that if $r \gt k$ and $|k-r|\lt\frac{1}{2}$, then $k$ is 
the closest integer to $r$. This proves the proposition in this case. 

Given the above two cases are proven, Exercise 1.13.b Lemma is now proved. 
The case of $k=r$ is trivial.

(Q.E.D.)

---

We can use the lemmae to prove proposition for Exercise 1.13. 
By Exercise 1.13.a lemme, notice that: 

$$
\begin{align}
\mathrm{Fib}(n) 
  &= \frac{\varphi^n - \psi^n}{\sqrt{5}} \\
\frac{\psi^n}{\sqrt{5}} 
  &= \frac{\varphi^n}{\sqrt{5}} - \mathrm{Fib}(n) \\
\left|\frac{\psi^n}{\sqrt{5}} \right|
  &= \left|\frac{\varphi^n}{\sqrt{5}} - \mathrm{Fib}(n)\right|\\
\frac{\left|\psi\right|^n}{\sqrt{5}}
  &= \left|\frac{\varphi^n}{\sqrt{5}} - \mathrm{Fib}(n)\right|\\
\end{align}
$$

Since $\sqrt{5} \gt 1$, we know $1-\sqrt{5} \lt 0$, so 
$|1-\sqrt{5}| = \sqrt{5}-1$. Observe that: 

$$
\begin{align}
9 &\gt 5 \\
\sqrt{9} &\gt \sqrt{5} \\
\sqrt{9}-1 &\gt \sqrt{5}-1 \\
3-1 &\gt \sqrt{5}-1 \\
2 &\gt \sqrt{5}-1 \\
\frac{2}{2} &\gt \frac{\sqrt{5}-1}{2} \\
1 &\gt \frac{\left|1-\sqrt{5}\right|}{|2|} \\
1 &\gt |\psi| \\
1^n = 1 &\gt |\psi|^n
\end{align}
$$

Now observe that: 

$$
\begin{align}
4 &\lt 5 \\
\sqrt{4} &\lt \sqrt{5} \\
\frac{1}{\sqrt{4}} &\gt \frac{1}{\sqrt{5}} \\
\frac{1}{2} &\gt \frac{1}{\sqrt{5}}
\end{align}
$$

Then: 

$$
\begin{align}
\frac{1}{2} \cdot 1
  &\gt \frac{1}{\sqrt{5}} \cdot |\psi|^n \\
\frac{1}{2} 
  &\gt \frac{|\psi|^n}{\sqrt{5}} 
    = \left|\frac{\varphi^n}{\sqrt{5}} - \mathrm{Fib}(n)\right| \\
\frac{1}{2} 
  &\gt \left|\frac{\varphi^n}{\sqrt{5}} - \mathrm{Fib}(n)\right|
    = \left|\mathrm{Fib}(n) - \frac{\varphi^n}{\sqrt{5}}\right| \\
\frac{1}{2} 
  &\gt \left|\mathrm{Fib}(n) - \frac{\varphi^n}{\sqrt{5}}\right|
\end{align}
$$

Then by Exercise 1.13.b lemma using $r:=\frac{\varphi^n}{\sqrt{5}}$ and 
$k:=\mathrm{Fib}(n)$, we see that $\mathrm{Fib}(n)$ is indeed the 
closest integer to $\frac{\varphi^n}{\sqrt{5}}$. This completes the 
proof for the proposition of Exercise 1.13.

(Q.E.D.)

---

# Exercise 1.14

See [separate file showing tree for `(cc 11 5)`](./Exercise_Source/E1_14.md).

## Growth of `(cc amount kind-of-coin)` in Steps

Let $T(n, k)$ be the steps it takes for particular `(cc n k)` to complete 
its process, where $n \in \mathbb{Z}$ and $n \geq 0$ represents the 
currency amount, and $k \in \mathbb{Z}$, $k \geq 1$ is some kind of coin 
with face value $v_k \geq 1$. Then: 

$$
T(n, k) = \sum_{i=0}^{\mathrm{ceiling}(n/v_k)} T(n-iv_k, k-1)
$$

To see this, consider the recursion tree of `(cc n k)`:

```
(cc n k)
|_____________________
|                    |
(cc n k-1)           (cc n-v_k k)
|                    |________________________
|                    |                       |
<ends in T(n, k-1)>  (cc n-v_k k-1)          (cc n-2v_k k)
                     |                       |__________________________
                     <ends in T(n-v_k, k-1>  |                         |
                                             <ends in T(n-2v_k, k-1)>  <repeats previous pattern>
                                                                       |
                                                                       (cc <0 or negative> k)
                                                                       |
                                                                       |
                                                                       <1 or 0, takes T(<0 or negative>, k) = 1 step>
```

We see that from the initial call, two other recursive calls to `cc` are made. 
One results in a branch that decrements the face value of the coin, which will 
terminate in $T(n, k-1)$ step by definition. The other results in a branch 
that decrements the change amount, with the change amount initially decreased 
to $n-v_k$. Then the change amount decreasing branch continues the pattern: 
first making a call that will end in some $T(m, k-1)$ step with $m$ 
depending on the decreased change amount; secondly making a call that further 
decreases the change amount. In other words, for each time the change amount 
decrements by $v_k$, $T(m, k-1)$ steps are to the process, and this 
will continue until the change amount is decremented to zero or a negative 
integer, which will be achieved in $\mathrm{ceiling}(n/v_k)$ depths. 
Altogether, the steps involved in the process is the sum mentioned above. 

Thus, the steps it takes for `(cc n k)` to finish running can be expressed 
as a sum, the number of terms in the sum depends on the amount $n$ and 
coin face value $v_k = v(k)$, and the terms themselves are mathematical 
functions of $n$, $v_k$ and $k-1$, namely $T(n-iv_k, k-1)$. Therefore, 
if we know the steps it takes for `cc` to complete for the lowest denomination 
coin, then the steps it takes for `cc` with larger denominations to complete 
will also be known. 

Given this is true, consider the following:

```
(cc n 1)
|__________
|         |
(cc n 0)  (cc n-1 1)
|         |____________
|         |           |
0         (cc n-1 0)  (cc n-2 1)
          |           |_____
          |           |    |
          0           ...  ...
                      |    |
                      0    (cc n-n 1)
                           |
                           1
```

The above assumes $v_1 = 1$, ie the lowest denomination $k=1$ represents 
a penny. We see that the branch decrementing the coin face immediately returns 
$0$ in one step. Meanwhile, the other branch decrementing the change amount 
decreases by one and goes on to make two more recursive calls, one again 
immedediately terminating in $1$ step by returning $0$, the other making 
further calls with amount decreased by $1$. The pattern continues until 
the amount is decremented to $n-n = 0$, in which case $1$ is returned. 
So the total steps involved for `(cc n 1)` is: 

$$
\begin{align}
T(n, 1) &= \left(\sum_{i=0}^n 2\right) - 1 \\
T(n, 1) &= 2(n + 1) - 1 \\
T(n, 1) &= 2n + 1
\end{align}
$$

Then, considering the sum previously, we immediately have the following: 

$$
\begin{align}
T(n, k) &= \sum_{i=0}^{\mathrm{ceiling}(n/v_k)} T(n-iv_k, k-1) \\
T(n, 2) &= \sum_{i=0}^{\mathrm{ceiling}(n/v_2)} T(n-iv_2, 2-1) \\
  &= \sum_{i=0}^{\mathrm{ceiling}(n/v_2)} T(n-iv_2, 1) \\
  &= \sum_{i=0}^{\mathrm{ceiling}(n/v_2)} 2(n-iv_2) + 1 \\
  &= \sum_{i=0}^{\mathrm{ceiling}(n/v_2)} 2n - 2iv_2 + 1 \\
  &\approx \frac{2n^2}{v_2} + \sum_{i=0}^{\mathrm{ceiling}(n/v_2)} 2iv_2 + 1 \\
  &\approx \frac{2n^2}{v_2} + (1 + (2v_2 + 1) + \dots + (2(n-1)v_2 + 1) + (2nv_2 + 1))
\end{align}
$$

We see that the dominating term above is proportional to $n^2$. So if two 
kinds of coins are present, the computation steps grows in $O(n^2)$. In 
fact we see for each additional kind of coin, the process above can be 
repeated. That is:

### Exercise 1.14 Proposition

If we have: 

$$
T(n,k)=C_k n^k + \Theta(n^{k-1})=\Theta(n^{k+1})
$$
 
... for constants $C_k$, then: 

$$
T(n,k+1)=C_{k+1}n^{k+1}+\Theta(n^k)=\Theta(n^{k+1})
$$

#### Proof

Given the premise in the proposition, and the previous result for $T(n, k)$, 
we have:

$$
\begin{align}
T(n, k+1)
  &= \sum_{i=0}^{\mathrm{ceiling}(n/v_k)} T(n-iv_k, k) \\
  &= \sum_{i=0}^{\mathrm{ceiling}(n/v_k)} (C_k n^k + \Theta(n^{k-1})) \\
  &= \left( \frac{n}{v_k} \right)C_k n^k 
  + \sum_{i=0}^{\mathrm{ceiling}(n/v_k)} \Theta(n^{k-1}) \\
  &= \frac{C_k}{v_k} n^{k+1} 
  + \sum_{i=0}^{\mathrm{ceiling}(n/v_k)} \left(C_{k-1}n^{k-1}+\dots+C_0n^0 \right) \\
  &= \frac{C_k}{v_k} n^{k+1} 
  + \frac{n}{v_k} \left( C_{k-1}n^{k-1} + \dots + C_0 n^0 \right) \\
  &= \frac{C_k}{v_k} n^{k+1} + \Theta(n^k) \\
  &= \Theta(n^{k+1})
\end{align}
$$

(Q.E.D)

Given proposition E1.14.1, and the fact that $T(n,1)=2n+1=\Theta(n^1)$, we 
see that the order of growth for `cc` in steps is in $\Theta(n^k)$ for 
however many $k$ kinds of coins there are.

## Growth of `(cc amount kind-of-coin)` in Space

The space requirement for `cc` is governed by the depth of the recursive 
tree since the depth represents the chain of deferred operations that must be 
stored in memory. For each non-trivial call of `cc`, it calls itself twice 
recursively (at least). 

```
(cc n k)
|_______________
|              |
(cc n k-1)     (cc n-v_k k)
|              |
<...>          <...>
```

Assuming applicative order of evaluation, the process will first evaluate 
the `(cc n k-1)` branch per the procedural definition of `cc`. We see that 
`(cc n k-1)` will then first try to evaluate its own recursive tree, starting 
at `(cc n k-2)`. Then similarly `(cc n k-2)` will first evaluate `(cc n k-3)` 
and so on. When the recursive calls reach `(cc n 1)`, it will call `(cc n 0)` 
similar to the preceeding calls; however, `(cc n 0)` evaluates to `0` and 
terminates. Then the other deferred call in `(cc n 1)` is evaluated, namely 
`(cc n-1 1)`. We see that `(cc n-1 1)` calls `(cc n-1 0)` which again 
terminates as it evaluates to `1`. So the other deferred call in `(cc n-1 1)` 
is evaluated, namely `(cc n-2 1)`. This process continues until 
`(cc <0 or less> 1)`, which terminates as it evaluates to `0`. 

```
(cc n k)
|_______________
|              |
(cc n k-1)     (cc n-v_k k)
|              |
|              <...>
|_______________
|              |
(cc n k-2)     (cc n-v_{k-1} k-1)
|              |
<...>          <...>
|
(cc n 1)
|_______________
|              |
(cc n 0)       (cc n-1 1)
|              |____________
|              |           |
0              (cc n-1 0)  (cc n-2 1)
               |           |
               1           |____________
                           |           |
                           (cc n-2 0)  (cc n-3 1)
                           |           |
                           1           <...>
                                       |____________
                                       |           |
                                       1           (cc <0 or less> 1)
                                                   |
                                                   0
```

We see that the depth below `(cc n 1)` to `(cc 0 1)` is $n$, as the 
`amount` argument decrements once per depth until `(cc 0 1)`. We also 
see the depth from `(cc n k)` to `(cc n 1)` to be $k$, as the 
`kinds-of-coin` argument also decrements once per depth. Altogether the 
deferred operations from the initial call of `(cc n k)` to `(cc 0 1)` creates 
a depth of $n+k$. We also see that this is the maximum depth reached by the 
function. Other operations in stack after the branch of `(cc n k)`-to-
`(cc n 1)`-to-`(cc 0 1)` were deferred at a higher depth of `(cc n l)` where 
$l \in \mathbb{Z}$ and $1 \lt l \lt k$. Subsequently the other 
recursive calls decreementing change amount should terminate quicker than 
than `(cc n 1)` as other coin faces are greater. Therefore they would 
have less deferred operations within, and would not require more space 
than the `(cc n k)`-to-`(cc n 1)`-to-`(cc 0 1)` branch. Thus `(cc n k)` 
has a max depth of $n+k$ and the space requirement has order of growth 
in $\Theta(n)$. 

## Summary for `(cc n k)`

We see that `(cc n k)` grows exponentially in steps with order of 
$\Theta(n^k)$, and `(cc n k)` grows linearly in space with order 
of $\Theta(n)$. 

# Exercise 1.15

## 1.15.a

Consider:

```scheme
(sine 12.15)
(p (sine (/ 12.15 3.0)))
(p (sine 4.05))
(p (p (sine (/ 4.05 3.0))))
(p (p (sine 1.35)))
(p (p (p (sine (/ 1.35 3.0)))))
(p (p (p (sine 0.45))))
(p (p (p (p (sine (/ 0.45 3))))))
(p (p (p (p (sine 0.15)))))
(p (p (p (p (p (sine (/ 0.15 3.0)))))))
(p (p (p (p (p (sine 0.05))))))
(p (p (p (p (p 0.05)))))
```

The recursive calls stop when $12.15$ gets divided $3.0$ for $5$ times 
into $0.05 \lt 0.1$. Therefore procedure `p` is applied $5$ times when 
`(sine 12.15)` is evaluated. 

## 1.15.b

### Growth of `(sine a)` in Space

A deferred procedure of `p` is produced once per division of the angle until 
it is less than or equal to $0.1$ radians. Let $n$ be the number of times 
$a$ must be divided by $3$ until the result is less than or equal to 
$0.1$. Thus:

$$
\begin{align}
\frac{a}{3^n} &\leq 0.1 \\
\frac{a}{0.1} &\leq 3^n \\
\mathrm{ln}\left(\frac{a}{0.1}\right) &\leq \mathrm{ln}\left(3^n \right) \\
\mathrm{ln}\left(\frac{a}{0.1}\right) &\leq n\cdot\mathrm{ln}(3) \\
\frac{\mathrm{ln}\left(\frac{a}{0.1}\right)}{\mathrm{ln}(3)} &\leq n \\
\frac{\mathrm{ln}(a)- \mathrm{ln}(0.1)}{\mathrm{ln}(3)} &\leq n \\
c_1 \mathrm{ln}(a)- c_0 &\leq n \\
\mathrm{ceiling}\left(c_1 \mathrm{ln}(a)- c_0\right) &= n
\end{align}
$$

Since it takes $c_1 \mathrm{ln}(a) + c_0$ divisions (ceiled to integer), 
the same number of deferred operations are the same, resulting in space 
requirement growing in $\Theta(\mathrm{ln}(a))$. 

### Growth of `(sine a)` in Steps

For some angle $a$, the `sine` procedure will first make recursive calls 
to itself, generating deferred `p` procedures in the process as mentioned. 
The recursive calls then stop when the angle becomes less than $0.1$, 
and the chain of deferred `p` is evaluated. Since each `sine` call generates 
at most one deferred `p`, and each `p` takes a constant number of steps to 
evaluate, the order of growth in steps is proportional to the number of 
deferred `p`. In other words, the order of growth in steps is the same 
as the order of growth in space, namely $\Theta(\mathrm{ln}(a))$.

# Exercise 1.16

See [Exercise 1.16 source file code](./Exercise_Source/E1_16.scm). The code 
makes use of the *invariant quantity* suggested by the problem statement via 
the following:

+ $n$ odd then $b^n = a \cdot b^{n-1}$, $a=b$.
+ $n$ even then $b^n = a \cdot b^{n}$, $a=1$.

```scheme
1 ]=> ;
(define (f-expt-iter a b n) 
    (cond 
        ((= n 0) a) 
        ((is-even n) (f-expt-iter a (* b b) (/ n 2))) 
        (else (f-expt-iter (* a b) b (- n 1)))))
;Value: f-expt-iter

1 ]=> ;
(define (fast-expt-iter b n) 
    (f-expt-iter 1 b n))
;Value: fast-expt-iter

1 ]=> (fast-expt-iter 2 1)
;Value: 2

1 ]=> (fast-expt-iter 2 4)
;Value: 16
```

# Exercise 1.17

+ [Exercise 1.17](./Exercise_Source/E1_17.scm)
```scheme
1 ]=> #| Using `int-times` instead of `*` to not confuse functions. |#


(define (int-times a b) 
    (define (int-times-iter a_0 a-iter b-iter) 
        (cond 
            ((= b-iter 0) a_0)
            ((is-even b-iter) (int-times-iter a_0 (double a-iter) (halve b-iter))) 
            (else (int-times-iter (+ a_0 a-iter) a-iter (- b-iter 1)))))
    (if (or (and (< a 0) (< b 0)) (and (> a 0) (> b 0)))
        (int-times-iter 0 (abs a) (abs b)) 
        (int-times-iter 0 (- (abs a)) (abs b))))
;Value: int-times

1 ]=> (int-times -1 3)
;Value: -3

1 ]=> (int-times 1 -3)
;Value: -3

1 ]=> (int-times 2 4)
;Value: 8

1 ]=> (int-times -5 -3)
;Value: 15

1 ]=> (int-times -9 0)
;Value: 0

1 ]=> (int-times 0 3)
;Value: 0
```

# Exercise 1.18

+ Included with exercise 1.17 code.
+ [Exercise 1.17](./Exercise_Source/E1_17.scm)

# Exercise 1.19

## Exercise 1.19 Proposition

Given transformation $T_{pq}$ where:

$$
\begin{align}
T_{pq}(a, b)
  &= {\begin{pmatrix} 
    bq + aq + ap \\ 
    bp + aq 
    \end{pmatrix}} \newline
\end{align}
$$

Let $T^2_{p'q'} = T_{pq}(T_{pq}(a, b))$, $p':=p^2 + q^2$ and 
$q':=2pq + q^2$, then we have:

$$

  T^2_{pq}(a, b) := T_{pq}(T_{pq}(a, b)) = T_{p'q'}(a, b)

$$

### Proof

$$
\begin{align}
T_{pq}(a, b)
  &= {\begin{pmatrix} 
    bq + aq + ap \\ 
    bp + aq 
    \end{pmatrix}} \newline
T_{pq}\left( T_{pq}(a,b) \right)
  &= \begin{pmatrix} 
    (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p \\ 
    (bp + aq)p + (bq + aq + ap)q 
    \end{pmatrix} \newline
T_{pq}\left( T_{pq}(a,b) \right)
  &= \begin{pmatrix} 
    bpq + aq^2 + bq^2 + aq^2 + apq + bqp + aqp + ap^2 \\
    bp^2 + aqp + bq^2 + aq^2 + apq 
    \end{pmatrix} \newline
T_{pq}\left( T_{pq}(a,b) \right)
  &= \begin{pmatrix} 
    b(2pq + q^2) + a(2pq + q^2) + a(p^2 + q^2) \\
    b(p^2 + q^2) + a(2pq + q^2) 
    \end{pmatrix} \newline
T^2_{pq}(a, b)
  &= \begin{pmatrix} 
    bq' + aq' + ap' \\
    bp' + aq' 
    \end{pmatrix} \newline
T^2_{pq}(a, b)
  &= T_{p'q'}(a, b)
\end{align}
$$

(Q.E.D.)

+ [Exercise 1.19](./Exercise_Source/E1_19.scm)


# Exercise 1.20

## Evaluation of `(gcd 206 40)` Using Normal Order of Evaluation

```scheme
(gcd 206 40)
; `remainder` evaluated 0 times

(if (= 40 0)
  206
  (gcd 
    40 
    (remainder 206 40)))
; `remainder` evaluated 0 times

(gcd 
  40 
  (remainder 206 40))
; `remainder` evaluated 0 times

(if (= (remainder 206 40) 0) 
  40
  (gcd 
    (remainder 206 40) 
    (remainder 40 (remainder 206 40))))
; `remainder` evaluated 0 times

(if (= 6 0) 
  40
  (gcd 
    (remainder 206 40) 
    (remainder 40 (remainder 206 40))))
; `remainder` evaluated 1 time

(gcd 
  (remainder 206 40) 
  (remainder 40 (remainder 206 40)))
; `remainder` evaluated 1 time

(if (= (remainder 40 (remainder 206 40)) 0) 
  (remainder 206 40)
  (gcd 
    (remainder 40 (remainder 206 40)) 
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
; `remainder` evaluated 1 time

(if (= 4 0) 
  (remainder 206 40)
  (gcd 
    (remainder 40 (remainder 206 40)) 
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
; `remainder` evaluated 3 times

(gcd 
  (remainder 40 (remainder 206 40)) 
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
; `remainder` evaluated 3 times

(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) 
  (remainder 40 (remainder 206 40))
  (gcd 
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
    (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
; `remainder` evaluated 3 times

(if (= 2 0) 
  (remainder 40 (remainder 206 40))
  (gcd 
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
    (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
; `remainder` evaluated 7 times

(gcd 
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
  (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
; `remainder` evaluated 7 times

(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0) 
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
  (gcd 
    (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 
    (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
; `remainder` evaluated 7 times

#| Evaluation of above predicate
  (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
  (= (remainder (remainder 40 6) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
  (= (remainder 4 (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
  (= (remainder 4 (remainder 6 (remainder 40 (remainder 206 40)))) 0)
  (= (remainder 4 (remainder 6 (remainder 40 6))) 0)
  (= (remainder 4 (remainder 6 4)) 0)
  (= (remainder 4 2) 0)
  (= 2 0)
  ; In the predicate, `remainder` evaluated 7 times, in total `remainder` evaluated 14 times
|#

(if (= 2 0) 
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
  (gcd 
    (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 
    (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
; `remainder` evaluated 14 times

(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
; `remainder` evaluated 14 times

2
; `remainder` evaluated 18 times
```

## Evaluation of `(gcd 206 40)` Using Applicative Order of Evaluation

```scheme
(gcd 206 40)
; `remainder` evaluated 0 times

(if (= 40 0)
  206
  (gcd 40 (remainder 206 40)))
; `remainder` evaluated 0 times

(gcd 40 6)
; `remainder` evaluated 1 time

(if (= 6 0) 
  40
  (gcd 6 (remainder 40 6)))
; `remainder` evaluated 1 time

(gcd 6 4)
; `remainder` evaluated 2 times

(if (= 4 0) 
  6
  (gcd 4 (remainder 6 4)))
; `remainder` evaluated 2 times

(gcd 4 2)
; `remainder` evaluated 3 times

(if (= 2 0) 
  4
  (gcd 2 (remainder 4 2)))
; `remainder` evaluated 3 times

(gcd 2 0)
; `remainder` evaluated 4 times

(if (= 0 0) 
  2
  (gcd 0 (remainder 2 0)))
; `remainder` evaluated 4 times

2
; `remainder` evaluated 4 times
```

# Exercise 1.21

```scheme
(smallest-divisor 199)
;Value: 199

(smallest-divisor 1999)
;Value: 1999

(smallest-divisor 19999)
;Value: 19999
```

Writing out the evaluation for 
`(smallest-divisor 19999)` to show process:

```scheme
(smallest-divisor 19999)

(find-divisor 19999 2)
(find-divisor 19999 3)
(find-divisor 19999 4)
(find-divisor 19999 5)
(find-divisor 19999 6)
(find-divisor 19999 7)
7
```

# Exercise 1.22

+ [Exercise 1.22 source code.](./Exercise_Source/E1_22.scm)

```scheme
1 ]=> (consec-prime-test 1000000000 3)
1000000000
1000000001
1000000003
1000000005
1000000007 => t = 30000.000000000007
1000000009 => t = 30000.
1000000011
1000000013
1000000015
1000000017
1000000019
1000000021 => t = 30000.
;Unspecified return value

1 ]=> (consec-prime-test 10000000000 3)
10000000000
10000000001
10000000003
10000000005
10000000007
10000000009
10000000011
10000000013
10000000015
10000000017
10000000019 => t = 80000.00000000001
10000000021
10000000023
10000000025
10000000027
10000000029
10000000031
10000000033 => t = 89999.99999999997
10000000035
10000000037
10000000039
10000000041
10000000043
10000000045
10000000047
10000000049
10000000051
10000000053
10000000055
10000000057
10000000059
10000000061 => t = 99999.99999999997
;Unspecified return value

1 ]=> (consec-prime-test 100000000000 3)
100000000000
100000000001
100000000003 => t = 279999.99999999994
100000000005
100000000007
100000000009
100000000011
100000000013
100000000015
100000000017
100000000019 => t = 270000.
100000000021
100000000023
100000000025
100000000027
100000000029
100000000031
100000000033
100000000035
100000000037
100000000039
100000000041
100000000043
100000000045
100000000047
100000000049
100000000051
100000000053
100000000055
100000000057 => t = 300000.0000000003
;Unspecified return value

1 ]=> (consec-prime-test 1000000000000 3)
1000000000000
1000000000001
1000000000003
1000000000005
1000000000007
1000000000009
1000000000011
1000000000013
1000000000015
1000000000017
1000000000019
1000000000021
1000000000023
1000000000025
1000000000027
1000000000029
1000000000031
1000000000033
1000000000035
1000000000037
1000000000039 => t = 870000.0000000001
1000000000041
1000000000043
1000000000045
1000000000047
1000000000049
1000000000051
1000000000053
1000000000055
1000000000057
1000000000059
1000000000061 => t = 900000.0000000003
1000000000063 => t = 879999.9999999999
```
The expected order of growth is in $\Theta(\sqrt{n})$. Therefore the 
time $t$ needed is $t\approx c \sqrt{n}$. Let each trial we calcauted 
have $t_i \approx c \sqrt{n_i}$. Given each time our inputs increase 
by a factor of $10$, we have:

$$
\frac{t_j}{t_i} = \frac{c\sqrt{n_j}}{c\sqrt{n_i}} = \sqrt{\frac{n_j}{n_i}}=\sqrt{10}
$$

So we expect that the ratio of computation times between successive trials 
be be $\sqrt{10}\approx 3.16$. 

| Trial | Input range | Average time for first three primes | $\frac{t_i}{t_{i-1}}$ |
| --- | --- | --- | --- |
| 1 | 1000000000 | 30000.00000000000233333333  | --- |
| 2 | 10000000000 | 89999.99999999998333333333 | $\frac{90000}{30000} \approx 3.00 $ |
| 3 | 100000000000 | 283333.33333333341333333333 | $\frac{283333}{90000} \approx 3.15 $ |
| 4 | 1000000000000 | 883333.33333333343333333333 | $\frac{883333}{283333} \approx 3.12 $ |
| **Average** | --- | --- | $3.09$ |

Overall the time ratios between trials are similar to the expected value. 
Since the order of growth of real program running time is the same as the 
analyzed order of growth in steps, it is compatible with the expected 
proportionality. 

# Exercise 1.23

+ [Exercise 1.23 source, using the incrementing proecedure suggested by text.](./Exercise_Source/E1_23a.scm)
+ Note: in `smallest-divisor`, it is pointless to test even numbers larger 
than $2$, because either: 
  + The number is divisible by $2$, in which case the smallest divisor 
  for the number is $2$ (since $2$ is the smallest integer that is 
  also larger than $1$).
  + The number is not divisible by $2$, therefore it cannot be divisible 
  by any other larger even numbers, since even numbers are $2\cdot k$ for 
  some integer $k$ by definition. 

```scheme

1 ]=> (consec-prime-test 1000000000 3)
1000000000
1000000001
1000000003
1000000005
1000000007 => t = 20000.000000000004
1000000009 => t = 19999.99999999999
1000000011
1000000013
1000000015
1000000017
1000000019
1000000021 => t = 20000.00000000002
;Unspecified return value

1 ]=> (consec-prime-test 10000000000 3)
10000000000
10000000001
10000000003
10000000005
10000000007
10000000009
10000000011
10000000013
10000000015
10000000017
10000000019 => t = 49999.999999999985
10000000021
10000000023
10000000025
10000000027
10000000029
10000000031
10000000033 => t = 60000.
10000000035
10000000037
10000000039
10000000041
10000000043
10000000045
10000000047
10000000049
10000000051
10000000053
10000000055
10000000057
10000000059
10000000061 => t = 60000.00000000005
;Unspecified return value

1 ]=> (consec-prime-test 100000000000 3)
100000000000
100000000001
100000000003 => t = 170000.00000000003
100000000005
100000000007
100000000009
100000000011
100000000013
100000000015
100000000017
100000000019 => t = 209999.99999999997
100000000021
100000000023
100000000025
100000000027
100000000029
100000000031
100000000033
100000000035
100000000037
100000000039
100000000041
100000000043
100000000045
100000000047
100000000049
100000000051
100000000053
100000000055
100000000057 => t = 170000.00000000015
;Unspecified return value

1 ]=> (consec-prime-test 1000000000000 3)
1000000000000
1000000000001
1000000000003
1000000000005
1000000000007
1000000000009
1000000000011
1000000000013
1000000000015
1000000000017
1000000000019
1000000000021
1000000000023
1000000000025
1000000000027
1000000000029
1000000000031
1000000000033
1000000000035
1000000000037
1000000000039 => t = 569999.9999999999
1000000000041
1000000000043
1000000000045
1000000000047
1000000000049
1000000000051
1000000000053
1000000000055
1000000000057
1000000000059
1000000000061 => t = 580000.0000000001
1000000000063 => t = 560000.0000000005
;Unspecified return value
```

| Trial | Input range | Average time for first three primes OLD | Average time for the first three primes NEW | $\frac{t_{\mathrm{new}}}{t_{\mathrm{old}}}$ |
| --- | --- | --- | --- | --- |
| 1 | 1000000000 | 30000.00000000000233333333  | 20000.00000000000466666667 | $66.7\%$ |
| 2 | 10000000000 | 89999.99999999998333333333 | 56666.66666666667833333333 | $63.0\%$ |
| 3 | 100000000000 | 283333.33333333341333333333 | 183333.33333333338333333333 | $64.7\%$ |
| 4 | 1000000000000 | 883333.33333333343333333333 | 570000.00000000016666666667 | $64.5\%$ |
| **Average** | --- | --- | --- | $64.73\%$ |


We see that the improvement in speed is closer to $35.3\%$ rather than the 
expected $50\%$. The `next-divisor` function (named `next` in the text) 
adds the following steps:

+ The call to `next-divisor`
+ Conditional `(if (= test-divisor 2) 3 (+ test-divisor 2))`

Assuming that the adding operation `(+ test-divisor 2)` has similar time 
demand as before, the other steps in function calls and conditional 
evaluation will still result in additional steps per divisor. 
Therefore, while the number of divisors checks are approximately halved 
from before, the calculation steps per divisor likely increased. 
Thus, while there is an overall improvement in speed, it is not 
half the amount as before. 

An attempt was made to further improve the program such that the time is 
indeed halved. [See exercise 1.13 source with additional improvements](./Exercise_Source/E1_23b.scm).
The results are as follows:

```scheme
1 ]=> (consec-prime-test 1000000000 3)
1000000000
1000000001
1000000003
1000000005
1000000007 => t = 20000.000000000004
1000000009 => t = 10000.00000000001
1000000011
1000000013
1000000015
1000000017
1000000019
1000000021 => t = 9999.999999999982
;Unspecified return value

1 ]=> (consec-prime-test 10000000000 3)
10000000000
10000000001
10000000003
10000000005
10000000007
10000000009
10000000011
10000000013
10000000015
10000000017
10000000019 => t = 70000.
10000000021
10000000023
10000000025
10000000027
10000000029
10000000031
10000000033 => t = 60000.
10000000035
10000000037
10000000039
10000000041
10000000043
10000000045
10000000047
10000000049
10000000051
10000000053
10000000055
10000000057
10000000059
10000000061 => t = 60000.00000000005
;Unspecified return value

1 ]=> (consec-prime-test 100000000000 3)
100000000000
100000000001
100000000003 => t = 140000.
100000000005
100000000007
100000000009
100000000011
100000000013
100000000015
100000000017
100000000019 => t = 140000.
100000000021
100000000023
100000000025
100000000027
100000000029
100000000031
100000000033
100000000035
100000000037
100000000039
100000000041
100000000043
100000000045
100000000047
100000000049
100000000051
100000000053
100000000055
100000000057 => t = 240000.
;Unspecified return value

1 ]=> (consec-prime-test 1000000000000 3)
1000000000000
1000000000001
1000000000003
1000000000005
1000000000007
1000000000009
1000000000011
1000000000013
1000000000015
1000000000017
1000000000019
1000000000021
1000000000023
1000000000025
1000000000027
1000000000029
1000000000031
1000000000033
1000000000035
1000000000037
1000000000039 => t = 450000.0000000002
1000000000041
1000000000043
1000000000045
1000000000047
1000000000049
1000000000051
1000000000053
1000000000055
1000000000057
1000000000059
1000000000061 => t = 430000.0000000002
1000000000063 => t = 419999.9999999995
;Unspecified return value
```

| Trial | Input range | Average time for first three primes OLD | Average time for the first three primes NEW IMPROVED| $\frac{t_{\mathrm{new}}}{t_{\mathrm{old}}}$ |
| --- | --- | --- | --- | --- |
| 1 | 1000000000 | 30000.00000000000233333333  | 13333.333333333332 | $44.4\%$ |
| 2 | 10000000000 | 89999.99999999998333333333 | 63333.33333333335 | $70.4\%$ |
| 3 | 100000000000 | 283333.33333333341333333333 | 173333.33333333333333333333 | $61.2\%$ |
| 4 | 1000000000000 | 883333.33333333343333333333 | 433333.3333333333 | $49.1\%$ |
| **Average** | --- | --- | --- | $56.3\%$ |

The improved `smallest-divisor` in the latest iteration immeidately returns 
`2` if `n` is even, so that the `(= test-divisor 2)` test is not performed for 
every `test-divisor`. Then `find-divisor` can start at `3` for `test-divisor` 
and increment by `2`. The new procedures comes closer to halving the time, 
but is still short of it. This is likely because the new procedures still have 
additional conditionals compared to the original procedures. Notably, the test 
for trial 2 seem to perform *worse* in the new improvements than the initial 
improvements. The author is unsure why, perhaps due to quirks of the computing 
device or more fundamental workings of Scheme.

# Exercise 1.24

The expected order of growth using Fermat's test is in $\Theta(\log{n})$. 
Therefore time $t\approx c\log{n}$. Let each trial have 
$t_i\approx c\log{n_i}$. Given each time our inputs increase by a factor 
of $10$, we have:

$$
\begin{align}
  \frac{t_j}{t_i} 
    &= \frac{c\log{n_j}}{c\log{n_i}} \\
    &= \frac{\log{10n_i}}{\log{n_i}} \\ 
    &= \frac{\log{10} + \log{n_i}}{\log{n_i}} \\
  \frac{t_j}{t_i} 
    &= \frac{\log{10}}{\log{n_i}} + 1 
\end{align}
$$

In fact, this suggests that for very large inputs, the ratio of computation 
times between successive trials becomes $1$. To test our estimation, the 
procedures were [modified as suggested by the text to use Fermat's test](./Exercise_Source/E1_24.scm). 
The timing test results are as follows:

```scheme
1 ]=> (consec-prime-test 1000000000 3)
1000000000
1000000001
1000000003
1000000005
1000000007 => t = 49999.99999999999
1000000009 => t = 30000.
1000000011
1000000013
1000000015
1000000017
1000000019
1000000021 => t = 40000.00000000001
;Unspecified return value

1 ]=> (consec-prime-test 10000000000 3)
10000000000
10000000001
10000000003
10000000005
10000000007
10000000009
10000000011
10000000013
10000000015
10000000017
10000000019 => t = 49999.999999999985
10000000021
10000000023
10000000025
10000000027
10000000029
10000000031
10000000033 => t = 70000.
10000000035
10000000037
10000000039
10000000041
10000000043
10000000045
10000000047
10000000049
10000000051
10000000053
10000000055
10000000057
10000000059
10000000061 => t = 50000.000000000044
;Unspecified return value

1 ]=> (consec-prime-test 100000000000 3)
100000000000
100000000001
100000000003 => t = 50000.000000000044
100000000005
100000000007
100000000009
100000000011
100000000013
100000000015
100000000017
100000000019 => t = 49999.999999999935
100000000021
100000000023
100000000025
100000000027
100000000029
100000000031
100000000033
100000000035
100000000037
100000000039
100000000041
100000000043
100000000045
100000000047
100000000049
100000000051
100000000053
100000000055
100000000057 => t = 59999.99999999994
;Unspecified return value

1 ]=> (consec-prime-test 1000000000000 3)
1000000000000
1000000000001
1000000000003
1000000000005
1000000000007
1000000000009
1000000000011
1000000000013
1000000000015
1000000000017
1000000000019
1000000000021
1000000000023
1000000000025
1000000000027
1000000000029
1000000000031
1000000000033
1000000000035
1000000000037
1000000000039 => t = 39999.99999999993
1000000000041
1000000000043
1000000000045
1000000000047
1000000000049
1000000000051
1000000000053
1000000000055
1000000000057
1000000000059
1000000000061 => t = 50000.000000000044
1000000000063 => t = 49999.999999999825
;Unspecified return value
```
Tabulating the results we have:

| Trial | Input range | Average time for the first three primes | ${\left(\frac{t_j}{t_i}\right)}_{\mathrm{real}}$ | $\frac{\log{10}}{\log{n_i}}+1$ |
| --- | --- | --- | --- | --- |
| 1 | 1000000000 | 40000 | --- | --- |
| 2 | 10000000000 | 56666.6666666667 | 1.41666666666667 | 1.11111111111111 |
| 3 | 100000000000 | 53333.3333333333 | 0.941176470588235 | 1.1 |
| 4 | 1000000000000 | 46666.6666666666 | 0.874999999999999 | 1.09090909090909 |
| Average | --- | --- | 1.07761437908497 | 1.1006734006734 |

We notice that the average time ratio is close to the one predicted by our 
calculation, and both are close to $1$ at our relatively large input sizes. 

# Exercise 1.25

To help test the validity of Alyssa's suggestion, 
[the simpler `expmod` is written and renamed as `exp-mod-new`](./Exercise_Source/E1_25.scm). 
Both procedures are used to calculate 
$(1000^{1000003}\mod 1000003)$. Using Fermat's Little Theorem, and 
the prime number $1000003$, we know that 
$(1000^{1000003}\mod 1000003) = (1000\mod 1000003) = 1000$. The 
following are the outputs from our test:

```scheme
1 ]=> ; Time tests:
(define init-runtime (runtime))
;Value: init-runtime

1 ]=> (time-test init-runtime (expmod 1000 1000003 1000003))
Time elapsed: 0.
;Value: 1000

1 ]=> (define init-runtime (runtime))
;Value: init-runtime

1 ]=> (time-test init-runtime (expmod-new 1000 1000003 1000003))
Time elapsed: 30.35
;Value: 1000
```

We are able to confirm that both processes give the correct result. 
However we clearly see that `expmod-new` uses much more time, while 
the previous `expmod` has trivial runtime. By using the compatibility 
of congruent modulo $n$ with multiplication, the previous `expmod` 
does not have to deal with numbers much larger than `m`, making 
large inputs much easier to handle. Therefore while the implementation 
is more nuanced, the previous `expmod` is superior overall.

# Exercise 1.26

Procedure `expmod` grows in steps with increasing input due to its 
recursive calls to itself, which are made continuously until the 
initial `expnt` is reduced to zero. Let $n$ be the initial 
exponent. Since `expmod` use successive squaring to decrement the 
exponent, the exponent is roughly halved each time. The number of 
decrements $k$ needed can can be determined as follows:

$$
\begin{align}
  \frac{n}{2^k} &= 1 \\
  n &= 2^k \\
  \log n &= k \log 2 \\
  \frac{\log n}{\log 2} &= k
\end{align}
$$

In the initial `expmod`, the recursive calls for even exponents 
are made as single arguments to `square`. This means `expmod` makes 
at most one recursive call to itself per decrement in the exponent. 
Assuming other parts of the procedure have constant steps, then 
the total steps is approximately $ck = c\frac{\log n}{\log 2}$, 
hence why the original procedure has order of growth $\Theta(\log n)$. 

However, when Louis Reasoner modified the `expmod` procedure, he used 
explicit multiplication `(* (expmod <...>) (expmod <...>))` instead 
of `(square (expmod <...>))`. This means that even exponent cases 
results in *two* recursive calls to `expmod`. For the worst cases 
where $n=2^l$, the procedure will have to make two recursive calls 
for every decrement (save the last two at exponents of $1$ and $0$). 
In other words, there would by $2^k$ recursive calls, since two 
recursive calls are made per decrement. But we know $k=\frac{\log n}{\log 2}$. 
Therefore, the total recursive calls needed is:

$$
\begin{align}
  2^k 
    &= 2^{\frac{\log n}{\log 2}} \\
    &= 2^{\log_2 n} \\
    &= n
\end{align}
$$

(Note: we made use of base change $\log_2 n = \frac{\log n}{\log 2}$ 
formula above)

So assuming constant steps per recursive calls, we will have 
$2^k c = nc $ steps, resulting in a new procedure with $\Theta(n)$ 
order of growth in steps. 

# Exercise 1.27

+ [Exercise 1.27](./Exercise_Source/E1_27.scm), result shows Fermat test 
returns true for all positive integers $a\lt n$ if $n$ is one of the 
Carmichael numbers.

```scheme
1 ]=> (fermat-test-all 561)
;Value: #t

1 ]=> (fermat-test-all 1105)
;Value: #t

1 ]=> (fermat-test-all 1729)
;Value: #t

1 ]=> (fermat-test-all 2465)
;Value: #t

1 ]=> (fermat-test-all 2821)
;Value: #t

1 ]=> (fermat-test-all 6601)
;Value: #t
```

# Exercise 1.28

+ [Exercise 1.28](./Exercise_Source/E1_28.scm)
+ [Output from student defined `miller-rabin-all` test.](./Exercise_Source/E1_28_output.md)
+ [Checking output against known primes from $1$ to $6601$.](./Exercise_Source/E1_28_checking.ods)
+ We see that the Miller-Rabin test indeed returns correct results for the 
Carmichael numbers listed by the text.

# Exercise 1.29

+ *Simpson's Rule*: 

$$
\begin{align}
  \int_{a}^{b} f(x) \,\mathrm{d}x 
    &= \frac{h}{3} 
      \left( y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 + \dots + 2y_{n-2} + 4y_{n-1} + y_n \right) \\
\end{align}
$$

  + Where $h=(b-a)/n$ for some even integer $n$ and $y_i = f(a + ih)$. 
  + As $n \to \infty$, $\mathrm{d}x \to 0$, approximation become 
  more accurate. 
+ [Exercise 1.29](./Exercise_Source/E1_29.scm)
+ The results show using Simpson's rule is much more accurate.
```scheme
1 ]=> ; Known result: 0.25 (asked by prompt)
(integral-mid-pt cube 0 1 0.01)
;Value: .24998750000000042

1 ]=> (integral-mid-pt cube 0 1 0.001)
;Value: .249999875000001

1 ]=> (integral-simpson cube 0 1 100)
;Value: .25

1 ]=> (integral-simpson cube 0 1 1000)
;Value: .25

1 ]=> ; Known result: 9
(integral-mid-pt square 0 3 0.01)
;Value: 8.999974999999958

1 ]=> (integral-mid-pt square 0 3 0.001)
;Value: 8.999999749998981

1 ]=> (integral-simpson square 0 3 100)
;Value: 9.

1 ]=> (integral-simpson square 0 3 1000)
;Value: 9.
```

# Exercise 1.30

+ [Exercise 1.30](./Exercise_Source/E1_30.scm)
```scheme
; Iteratively evolving `sum`
(define (sum sum-term a next-term b) 
  (define (sum-iter iter-a iter-result) 
    (if 
      (> iter-a b) 
      iter-result 
      (sum-iter (next-term iter-a) (+ iter-result (sum-term iter-a)))))
  (sum-iter a 0))
```
+ Testing with previous integration procedure...
```scheme
1 ]=> ; Known analytical result: 41.333...
(integral-mid-pt square 1 5 (/ (- 5 1) 100))
;Value: 41.33280000000004

1 ]=> (integral-mid-pt square 1 5 (/ (- 5 1) 1000))
;Value: 41.33332799999952

1 ]=> (integral-simpson square 1 5 100)
;Value: 41.333333333333336

1 ]=> (integral-simpson square 1 5 1000)
;Value: 41.33333333333333
```

# Exercise 1.31

+ [Exercise 1.31.a](./Exercise_Source/E1_31a.scm)
```scheme
1 ]=> ; Iterative process version of `product`

(define (product prod-term a next-term b) 
  (define (prod-iter iter-a iter-result) 
    (if 
      (> iter-a b) 
      iter-result 
      (prod-iter (next-term iter-a) (* (prod-term iter-a) iter-result))))
  (prod-iter a 1))
;Value: product

1 ]=> ;
(define (john-wallis-pi n-terms) 
  (define (inc-JW-pi i) (+ i 2))
  (define (JW-pi-term i) 
    (/ (* (- i 1) (+ i 1)) (square i))) 
  (product JW-pi-term 3. inc-JW-pi n-terms))
;Value: john-wallis-pi

1 ]=> (* 4 (john-wallis-pi 1000))
;Value: 3.1431638424192028
```
+ [Exercise 1.31.b](./Exercise_Source/E1_31b.scm)
```scheme
1 ]=> ; Recursive process version of `product`

(define (product prod-term a next-term b) 
  (if 
    (> a b) 
    1 
    (* (prod-term a) (product prod-term (next-term a) next-term b))))
;Value: product
```
```scheme
1 ]=> (* 4 (john-wallis-pi 1000))
;Value: 3.143163842419204
```

# Exercise 1.32

+ [Exercise 1.32.a](./Exercise_Source/E1_32a.scm)
```scheme
1 ]=> ; Iterative process version: 
(define (accumulate combiner null-value acc-term a next-term b) 
  (define (acc-iter iter-a iter-result) 
    (if 
      (> iter-a b) 
      iter-result 
      (acc-iter (next-term iter-a) (combiner (acc-term iter-a) iter-result)))) 
  (acc-iter a null-value))
;Value: accumulate

1 ]=> ;
(define (sum sum-term a next-term b) 
  (accumulate + 0 sum-term a next-term b))
;Value: sum

1 ]=> ;
(define (product prod-term a next-term b) 
  (accumulate * 1 prod-term a next-term b))
;Value: product

1 ]=> (define (inc x) (+ x 1))
;Value: inc

1 ]=> (sum square 1 inc 3)
;Value: 14

1 ]=> (product square 1 inc 3)
;Value: 36
```
+ [Exercise 1.32.b](./Exercise_Source/E1_32b.scm)
```scheme
1 ]=> ; Recursive process version: 
(define (accumulate combiner null-value acc-term a next-term b) 
  (if 
    (> a b) 
    null-value 
    (combiner (acc-term a) (accumulate combiner null-value acc-term (next-term a) next-term b))))
;Value: accumulate

1 ]=> ;
(define (sum sum-term a next-term b) 
  (accumulate + 0 sum-term a next-term b))
;Value: sum

1 ]=> ;
(define (product prod-term a next-term b) 
  (accumulate * 1 prod-term a next-term b))
;Value: product

1 ]=> (define (inc x) (+ x 1))
;Value: inc

1 ]=> (sum square 1 inc 3)
;Value: 14

1 ]=> (product square 1 inc 3)
;Value: 36
```

# Exercise 1.33

+ [Exercise 1.33](./Exercise_Source/E1_33.scm)
```scheme
1 ]=> ; From iterative process version of `accumulate`: 

(define (filtered-accumulate combiner null-value acc-term a next-term b filter) 
  (define (acc-iter iter-a iter-result) 
    (cond 
      ((> iter-a b) iter-result) 
      (else 
        (acc-iter 
          (next-term iter-a) 
          (if 
            (filter iter-a) 
            (combiner (acc-term iter-a) iter-result) 
            iter-result)))))
  (acc-iter a null-value))
;Value: filtered-accumulate
```
```scheme
; 1.33.a
(define (filtered-sum sum-term a next-term b filter) 
  (filtered-accumulate + 0 sum-term a next-term b filter))
;Value: filtered-sum

1 ]=> (define (identity x) x)
;Value: identity

1 ]=> (define (inc x) (+ x 1))
;Value: inc

1 ]=> (filtered-sum identity 1 inc 5 is-prime)
;Value: 11

1 ]=> (filtered-sum square 1 inc 5 is-prime)
;Value: 39
```

```scheme
1 ]=> ; 1.33.b
(define (filtered-product prod-term a next-term b filter) 
  (filtered-accumulate * 1 prod-term a next-term b filter))
;Value: filtered-product

1 ]=> ;
(define (prod-n-rel-prime n) 
  (define (rel-prime-to-n i) (is-rel-prime i n)) 
  (filtered-product identity 1 inc (- n 1) rel-prime-to-n))
;Value: prod-n-rel-prime

1 ]=> (prod-n-rel-prime 5)
;Value: 24

1 ]=> (prod-n-rel-prime 6)
;Value: 5
```

# Exercise 1.34

```scheme
(define (f g) (g 2))

(f square)
;Value: 4
(f (lambda (z) (* z (+ z 1))))
;Value: 6
```

Suppose we try to evaluate `(f f)`, assuming applicative order of evaluation: 

```scheme
(f f)
(f 2)
(2 2)
```

Value would not be defined, as the `(f f)` call would result in `2` being 
called as a defined procedure, but it is not a procedure. The actual output 
from `mit-scheme` using the defined `f` is: 

```scheme
1 ]=> (f f)

;The object 2 is not applicable.
;To continue, call RESTART with an option number:
; (RESTART 2) => Specify a procedure to use in its place.
; (RESTART 1) => Return to read-eval-print level 1.
```

# Exercise 1.35

We know that $\varphi = \frac{1+\sqrt{5}}{2}$. Let 
$f(x)=1+\frac{1}{x}$, then: 

$$
\begin{align}
f(\varphi) 
  &= 1 + \frac{1}{\varphi} \\
  &= 1 + \frac{2}{1+\sqrt{5}} \\
  &= \frac{1+\sqrt{5}}{1+\sqrt{5}} + \frac{2}{1+\sqrt{5}} \\ 
  &= \frac{3+\sqrt{5}}{1+\sqrt{5}} \\
  &= \frac{1-\sqrt{5}}{1-\sqrt{5}} \cdot\frac{3+\sqrt{5}}{1+\sqrt{5}} \\
  &= \frac{3-3\sqrt{5}+\sqrt{5}-5}{1-\sqrt{5}+\sqrt{5}-5} \\
  &= \frac{(-2)-2\sqrt{5}}{-4} \\
  &= \frac{1+\sqrt{5}}{2} \\
f(\varphi) 
  &= \varphi
\end{align}
$$

So we see $f(\varphi)=\varphi$, so $\varphi$ is a fixed point of $f$. 

```scheme
1 ]=> (define (f x) (+ 1.0 (/ 1.0 x)))
;Value: f

1 ]=> (fixed-point f 1.0)
;Value: 1.6180327868852458
```

Calculation using `fixed-point` converges to expected value of $\varphi$. 

# Exercise 1.36

Reason why the solution to $x^x = 1000$ can be obtained by solving a fixed 
point problem: 

$$
\begin{align}
x^x &= c \\
x \log x &= \log c \\
x &= \frac{\log c}{\log x} 
\end{align}
$$

We see that if we have $f(x) = \frac{\log c}{\log x}$ then finding 
fixed point where $f(x) = x = \frac{\log c}{\log x}$ obtains solution 
to original problem ($c$ can be arbitrary number greater than $1$, 
e.g. $1000$). 

Consider true solution $x_t$, if we make guess $x_i = x_t + \epsilon$ for 
$\epsilon \gt 0$, then we see $x_t \lt x_t + \epsilon = x_i$. Since 
$\log$ increases monotonically, we know also: 

$$
\frac{\log c}{\log x_i}=\frac{\log c}{\log (x+\epsilon)} \lt \frac{\log c}{\log x} = x
$$

Therefore the true solution is between our guess $x_i$ and 
$f(x_i)=\frac{\log c}{\log x_i}$:

$$
\frac{\log c}{\log x_i} \lt x_t \lt x_i
$$

On the other hand, if our guess is $x_i' = x_t - \epsilon$, then by similar 
calculations we would have:

$$
\frac{\log c}{\log x_i'} \gt x_t \gt x_i'
$$

Therefore the true solution is again between the guess $x_i'$ and 
$f(x_i')=\frac{\log c}{\log x_i'}$, except direction of inequality 
is reversed. Another way to see this is by using a simple 
transformation similar to the book example. We can solve the following 
average-damped fixed point problem to obtain the same solution: 

$$
\begin{align}
2x &= \frac{\log c}{\log x} + x \\
x &= \frac{1}{2}\left( \frac{\log c}{\log x} + x\right) \\
x = g(x) &:= \frac{1}{2}\left( \frac{\log c}{\log x} + x\right) \\
g(x) &= \frac{1}{2}(f(x) + x)
\end{align}
$$

Translating both the undamped $f$ and damped $g$ into 
Scheme and [solve using `fixed-point`](./Exercise_Source/E1_36.scm) 
gives following results: 

```scheme
1 ]=> (define c 1000)
;Value: c

1 ]=> (define (f x) (/ (log c) (log x)))
;Value: f

1 ]=> (define (g x) (average (f x) x))
;Value: g

1 ]=> (fixed-point f 2.0)
9.965784284662087
3.004472209841214
6.279195757507157
3.759850702401539
5.215843784925895
4.182207192401397
4.8277650983445906
4.387593384662677
4.671250085763899
4.481403616895052
4.6053657460929
4.5230849678718865
4.577114682047341
4.541382480151454
4.564903245230833
4.549372679303342
4.559606491913287
4.552853875788271
4.557305529748263
4.554369064436181
4.556305311532999
4.555028263573554
4.555870396702851
4.555315001192079
4.5556812635433275
4.555439715736846
4.555599009998291
4.555493957531389
4.555563237292884
4.555517548417651
4.555547679306398
4.555527808516254
4.555540912917957
4.555532270803653
;Value: 4.555532270803653

1 ]=> (fixed-point g 2.0)
5.9828921423310435
4.922168721308343
4.628224318195455
4.568346513136242
4.5577305909237005
4.555909809045131
4.555599411610624
4.5555465521473675
4.555537551999825
;Value: 4.555537551999825
```

It is clear that the average-damped function converges much faster. 
Additionally the answers are indeed good approximations to 
$x^x = 1000$.

# Exercise 1.37

If the infinite continued fraction: 

$$

f=\frac{N_1}{D_1 + \frac{N_2}{D_2 + \frac{N_3}{D_3 + \dots}}}

$$

... has $N_i = D_i = 1$, then $f = \frac{1}{\varphi}$. To 
see this, recall how $varphi$ is the fixed point for 
$g(x)=1+\frac{1}{x}$, then we see: 

$$
\begin{align}
g(x) &= 1+\frac{1}{x} \\
g(g(x)) &= 1+\frac{1}{1+\frac{1}{x}} \\
g(g(g(x))) &= 1+\frac{1}{1+\frac{1}{1+\frac{1}{x}}} \\
g(\dots g(x)) &= 1+\frac{1}{1+\frac{1}{1+\frac{1}{\dots}}} \\
\end{align}
$$

... this is exactly the denominator below $N_1=1$ in $f$, 
assuming all $N_i=D_i=1$, 
but we also know as we compose $g(x)$ to infinity we would 
obtain $\varphi$ (from exercise 1.35), so 
$f=N_1/\varphi=1/\varphi$ if we set all $N_i=D_i=1$. 

+ [Calculated iteratively using `cont-frac`](./Exercise_Source/E1_37a.scm). 
```scheme
1 ]=> ; Iterative process version of `cont-frac`:
(define (cont-frac n d k) 
  (define (cont-frac-iter i frac-result) 
    (if 
      (= i 0) 
      frac-result 
      (let 
        ((next-frac (/ (n i) (+ (d i) frac-result)))) 
        (cont-frac-iter (- i 1) next-frac))))
  (cont-frac-iter k 0))
;Value: cont-frac
```
+ [Calculated recursively using `cont-frac`](./Exercise_Source/E1_37b.scm). 
```scheme
1 ]=> ; Recursive process version of `cont-frac`:
(define (cont-frac n d k) 
  (define (next-frac i) 
    (if 
      (> i k) 
      0
      (/ (n i) (+ (d i) (next-frac (+ i 1))))))
  (next-frac 1))
;Value: cont-frac
```

```scheme
1 ]=> ;
(cont-frac 
  (lambda (i) 1.0) 
  (lambda (i) 1.0) 
  k)
;Value: .6180339887498948

1 ]=> ; Actual value for $\frac{1}{\varphi}$: 
(/ 1.0 (/ (+ 1 (sqrt 5)) 2.0))
;Value: .6180339887498948
```

# Exercise 1.38

+ [Exercise 1.38](./Exercise_Source/E1_38.scm).

```scheme
1 ]=> ;
(define (euler-num) 
  (+ 
    2.0 
    (cont-frac 
      (lambda (i) 1) 
      (lambda 
        (i) 
        (if 
          (= 0 (remainder (- i 2) 3)) 
          (* 2 (+ 1 (/ (- i 2) 3))) 
          1))
      100)))
;Value: euler-num

1 ]=> ;
(euler-num)
;Value: 2.718281828459045
```

# Exercise 1.39

+ [Exercise 1.39](./Exercise_Source/E1_39.scm).

```scheme
1 ]=> ;
(define (tangent-cf x k) 
  (/ 
    (cont-frac 
      (lambda (i) (- (square x))) 
      (lambda (i) (+ 1 (* (- i 1) 2))) 
      k) 
    (if (= x 0) -1 (- x))))
;Value: tangent-cf

1 ]=> ;
(define pi-approx 3.14159265)
;Value: pi-approx

1 ]=> ;
(define k 10000)
;Value: k

1 ]=> (tangent-cf (* pi-approx 0) k)
;Value: 0

1 ]=> (tangent-cf (* pi-approx 0.25) k)
;Value: .9999999982051034

1 ]=> (tangent-cf (* pi-approx 0.5) k)
;Value: 557135191.5048437

1 ]=> (tangent-cf (* pi-approx 0.75) k)
;Value: -1.0000000053846894

1 ]=> (tangent-cf (* pi-approx 1.0) k)
;Value: -3.5897929852236686e-9``scheme
```

# Exercise 1.40

+ [Exercise 1.40](./Exercise_Source/E1_40.scm)

```scheme
1 ]=> ;
(define (cubic a b c) 
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))
;Value: cubic

1 ]=> ; Solve $0 = x^3 - 2x^2 - 9x + 18
; Known results: -3, 2, 3

(newton-method (cubic -2 -9 18) -4.0)
;Value: -2.9999999999999827

1 ]=> (newton-method (cubic -2 -9 18) 1.0)
;Value: 2.000000000000876

1 ]=> (newton-method (cubic -2 -9 18) 4.0)
;Value: 3.00000000000017
```

# Exercise 1.41

+ [Exercise 1.41](./Exercise_Source/E1_41.scm)
```scheme
1 ]=> ;
(define (double f) 
  (lambda (x) (f (f x))))
;Value: double

1 ]=> (define (inc i) (+ i 1))
;Value: inc

1 ]=> ((double inc) 5)
;Value: 7

1 ]=> (((double double) inc) 5)
;Value: 9

1 ]=> (((double (double double)) inc) 5)
;Value: 21

1 ]=> (((double (double (double double))) inc) 5)
;Value: 261

1 ]=> (((double (double (double (double double)))) inc) 5)
;Value: 65541
```
+ The result for `((double (double double) inc) 5)` is `21`. 
+ The student was confused as to why it was not `13`, the folowing is 
an explanation. The key is that `(double double)` is doubled:

```scheme
(((double (double double)) inc) 5)
(((double double) ((double double) inc)) 5)
(((double double) (double (double inc))) 5)
(((double double) (double (double inc))) 5)
((double (double (double (double inc)))) 5)
```
+ In general, if we rewrite `double` as $d$, we can show that 
$d^n(d)(f(x)) = f^{2^{2^n}}(x)$. 

## Exercise 1.41 Proposition

Consider the set $F$ of functions $f$, where:

$$
F = \{ f: x\in X \implies f(x)\in X\}
$$

In other words, $F$ is the set of all single-argument functions $f$ 
where the range of $f$ is a subset of the domain of $f$. Define 
a function $d$ on $F$, where: 

$$
d(f)(x) := f^2(x) = f(f(x)) = (f\circ f)(x)
$$

Note the notation:

$$
\begin{align}
f^n(x) 
  &:= \underbrace{f(\dots f}_{\mathrm{n\,times}}(x)) 
  = \left(\underbrace{f\circ\dots\circ f}_{\mathrm{n\,times}}\right)(x)
\end{align}
$$

Remark that by construction of $F$, $d\in F$. Therefore $d(d)$ is 
defined in $F$. 

The following can be shown: 

$$
 d^n(d)(f(x)) = f^{2^{2^{n}}}(x)
$$

### Proof of Exercise 1.41 Proposition

We use induction to prove our proposition. 

#### Base Case $n=0$

$$
\begin{align}
  d^0(d)(f(x)) 
    &= (d)(f)(x) \\
    &= d(f(x)) \\
    &= f(f(x)) \\
    &= f^{2}(x) \\
  d^0(d)(f(x)) 
    &= f^{2^{2^0}}(x)
\end{align}
$$

This is exactly what we need. 

#### Inductive Step

Assume for some $n$, we have: 

$$
d^n(d)(f(x))=f^{2^{2^n}}(x)
$$

... for all $f\in F$. Let $d':= d^n(d)$, then we see: 

$$
 d^{n+1}(d) = d(d^n(d)) = d(d') 
$$

By the inductive premise, $d'(f(x)) = f^{2^{2^n}}(x)$. Then: 

$$
\begin{align}
  d^{n+1}(d)(f(x)) 
    &= d(d')(f(x)) \\
    &= d'(d'(f(x))) \\
    &= d'(f^{2^{2^n}}(x)) \\
\end{align}
$$

But by construction $f^{2^{2^n}}$ is in $F$, therefore for 
$f':=f^{2^{2^n}}$, $d'(f') = f'^{2^{2^n}} = (f^{2^{2^n}})^{2^{2^n}}$: 

$$
\begin{align}
  d^{n+1}(d)(f(x)) 
    &= (f^{2^{2^n}})^{2^{2^n}}(x) \\
    &= f^{2^{2^n} 2^{2^n}}(x) \\
    &= f^{2^{2^n + 2^n}}(x) \\
    &= f^{2^{2\cdot 2^n}}(x) \\
  d^{n+1}(d)(f(x)) 
    &= f^{2^{2^{n+1}}}(x)
\end{align}
$$

This is exactly what we need, and proves our proposition. 

(Q.E.D)

# Exercise 1.42

+ [Exercise 1.42](./Exercise_Source/E1_42.scm).

```scheme
1 ]=> ;
(define (compose f g) 
  (lambda (x) (f (g x))))
;Value: compose

1 ]=> (define (inc i) (+ i 1))
;Value: inc

1 ]=> ((compose square inc) 6)
;Value: 49
```

# Exercise 1.43

+ [Exercise 1.43](./Exercise_Source/E1_43.scm).

```scheme
1 ]=> ;
(define (repeated f n) 
  (define (rep-iter f_i i) 
    (if 
      (< i 2) 
      f_i 
      (rep-iter (compose f f_i) (- i 1))))
  (rep-iter f n))
;Value: repeated

1 ]=> ((repeated square 2) 5)
;Value: 625

1 ]=> ((repeated square 4) 2)
;Value: 65536

1 ]=> ((repeated inc 60) 9)
;Value: 69
```

# Exercise 1.44

+ [Exercise 1.44](./Exercise_Source/E1_44.scm).

```scheme
1 ]=> ;
(define (smoothed f) 
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3.0)))
;Value: smoothed

1 ]=> ;
(define (n-smoothed f n) 
  ((repeated smoothed n) f))
;Value: n-smoothed

1 ]=> (define dx 1.0)
;Value: dx

1 ]=> ((smoothed square) 0)
;Value: .6666666666666666

1 ]=> ((n-smoothed square 2) 0)
;Value: 1.3333333333333333
```

+ Output in tests above agree with hand calculation. 

# Exercise 1.45

By [testing](./Exercise_Source/E1_45a.scm), it seems that if taking the 
$n^{\mathrm{th}}$ root of $x$ (i.e. $\sqrt[n]{x}$), we need 
$k-1$ dampings, where $k$ is the smallest integer that obeys:

$$
\begin{align}
  n &\lt 2^k \\
  \log n &\lt k \log 2 \\
  \frac{\log n}{\log 2} &\lt k
\end{align}
$$

```scheme
1 ]=> ;
(define (nth-root x n num-damps) 
  (fixed-point 
    ((repeated average-damp num-damps) 
      (lambda (y) (/ x (expt y (- n 1)))))
    1.0))
;Value: nth-root

1 ]=> ; 4th root converges after 2 damps:
(define root 4)
;Value: root

1 ]=> (nth-root 9 root 2)
;Value: 1.73205080756899

1 ]=> ; 7th root converges after 2 damps:
(define root 7)
;Value: root

1 ]=> (nth-root 9 root 2)
;Value: 1.3687348350428596

1 ]=> ; 8th root converges after 3 damps:
(define root 8)
;Value: root

1 ]=> (nth-root 9 root 3)
;Value: 1.3160740129846937

1 ]=> ; 15th root converges after 3 damps:
(define root 15)
;Value: root

1 ]=> (nth-root 9 root 3)
;Value: 1.1577490900162686

1 ]=> ; 16th root converges after 4 damps:
(define root 16)
;Value: root

1 ]=> (nth-root 9 root 4)
;Value: 1.1472026904858685

1 ]=> ; 31st root converges after 4 damps:
(define root 31)
;Value: root

1 ]=> (nth-root 9 root 4)
;Value: 1.0734550659729893

1 ]=> ; 32nd root converges after 5 damps:
(define root 32)
;Value: root

1 ]=> (nth-root 9 root 5)
;Value: 1.071075483073177
```

Therefore the number of dampings is `(floor (/ (log n) (log 2)))`. This 
can be [implemented](./Exercise_Source/E1_45.scm):

```scheme
1 ]=> ;
(define (nth-root x n) 
  (fixed-point 
    ((repeated 
        average-damp 
        (floor (/ (log n) (log 2)))) 
      (lambda (y) (/ x (expt y (- n 1)))))
    1.0))
;Value: nth-root

1 ]=> (nth-root 9 32)
;Value: 1.071075483073177

1 ]=> (nth-root 256 8)
;Value: 2.000000000003967

1 ]=> (nth-root 15640.31349 5)
;Value: 6.900001649023265
```

# Exercise 1.46

+ [Exercise 1.46](./Exercise_Source/E1_46.scm)

```scheme
(define (iterative-improve is-close improve) 
  (define (iterate guess) 
    (if 
      (is-close guess) 
      guess 
      (iterate (improve guess))))
  iterate)
```

```scheme
(define (sq-root x) 
  ((iterative-improve 
    (lambda (guess) (< (abs (- (square guess) x)) 0.000001)) 
    (lambda (guess) (average guess (/ x guess)))) 
  1.0))

```

```scheme
(define (fixed-point f first-guess) 
  ((iterative-improve 
    (lambda (guess) (< (abs (- (f guess) guess)) 0.000001)) 
    f) 
    first-guess))
```

Testing the procedures:
```scheme
1 ]=> (sq-root 2)
;Value: 1.4142135623746899

1 ]=> (sq-root 9)
;Value: 3.000000001396984

1 ]=> (sq-root 10)
;Value: 3.162277665175675
```

```scheme
1 ]=> (fixed-point cos 1.0)
;Value: .7390845495752126

1 ]=> (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)
;Value: 1.2587287680106494

1 ]=> (fixed-point (average-damp (lambda (y) (/ 2.0 y))) 1.0)
;Value: 1.4142135623746899

```

Veni, vidi, vici. 
