# Exercise 2.1

+ Since `gcd` returns positive integers, can 
[manipulate sign of `divisor`](./Exercise_Source/E2_1.scm) 
before division.
```scheme
(define 
  (make-rat n d) 
  (let 
    ((divisor ((if (< d 0) - abs) (gcd n d)))) 
    (cons 
      (/ n divisor) 
      (/ d divisor))))
```
```scheme
1 ]=> (print-rat (make-rat 4 20))
1/5
;Unspecified return value

1 ]=> (print-rat (make-rat -4 -20))
1/5
;Unspecified return value

1 ]=> (print-rat (make-rat -4 20))
-1/5
;Unspecified return value

1 ]=> (print-rat (make-rat 4 -20))
-1/5
;Unspecified return value
```
# Exercise 2.2

+ [Exercise 2.2](./Exercise_Source/E2_2.scm).
+ Point compound data object:
```scheme
(define (make-point x y) 
  (cons x y))

(define (x-point pt) 
  (car pt))

(define (y-point pt) 
  (cdr pt))
```
+ Line segment compound data object:
```scheme
(define (make-segment start-pt end-pt) 
  (cons start-pt end-pt))

(define (start-segment line) 
  (car line))

(define (end-segment line) 
  (cdr line))
```
```scheme
(define (midpoint-segment line) 
  (make-point 
    (average 
      (x-point (start-segment line))  
      (x-point (end-segment line))) 
    (average 
      (y-point (start-segment line))  
      (y-point (end-segment line)))))
```
+ Testing point and line segment objects:
```scheme
1 ]=> (define u (make-point -1.2 7.4))
;Value: u

1 ]=> (define v (make-point 2.8 -3.2))
;Value: v

1 ]=> (define line-u-v (make-segment u v))
;Value: line-u-v

1 ]=> (print-point (midpoint-segment line-u-v))
(.7999999999999999, 2.1)
;Unspecified return value
```

# Exercise 2.3

+ [Exercise 2.3](./Exercise_Source/E2_3.scm). 

## Rectangle Defined by Diagonal Line Segment and Base-Diagonal Angle

The first representation of the rectangle we can define is by defining the 
rectangle's diagonal segment, and the angle from the rectangle's diagonal 
to the base. 

```scheme
(define (make-rectang diagonal diag-angle) 
  (cons diagonal diag-angle))
(define (diagonal rectangle) (car rectangle))
(define (diag-angle rectangle) (cdr rectangle))
```

The lengths of the rectangle's base and height can be calculated from the 
diagonal and diagonal angle, and from them the area and perimeter of the 
rectangle can be calculated. 

```scheme
(define (base-len rectangle) 
  (* (len-segment (diagonal rectangle)) (cos (diag-angle rectangle)))) 
(define (height-len rectangle) 
  (* (len-segment (diagonal rectangle)) (sin (diag-angle rectangle)))) 
(define (area rectangle) 
  (* (base-len rectangle) (height-len rectangle)))
(define (perimeter rectangle) 
  (* 2.0 (+ (base-len rectangle) (height-len rectangle))))
```

Checking with sample rectangle. 

```scheme
(define d 
  (make-segment 
    (make-point 1 1) 
    (make-point 5 4)))
;Value: d

1 ]=> (define a (radian 36.86989765))
;Value: a

1 ]=> (define R (make-rectang d a))
;Value: r

1 ]=> (degree (diag-angle R))
;Value: 36.86989765

1 ]=> (area R)
;Value: 12.000000000507749

1 ]=> (perimeter R)
;Value: 14.000000000145072
```

The results are within expectation, the angle used was calculated to 
create a rectangle of base $4$ and height $3$. This method of 
rectangle definition can be 
[graphed in Desmos as seen here](https://www.desmos.com/calculator/ayhdefmxfr).

## Rectangle Defined by Point, Rotation, Base, and Height

A rectangle can also be defined by setting a point, then defining the 
rectangle's rotation (angle between rectangle's base to the x-axis), 
base, and height. 

```scheme
(define (make-rectang position dims) (cons position dims))
; Constructor and selectors related to position:
(define (make-position origin rotation) (cons origin rotation)) 
(define (rectang-position rectangle) (car rectangle))
(define (origin rectangle) (car (rectang-position rectangle)))
(define (rotation rectangle) (cdr (rectang-position rectangle)))
; Constructor and selectors related to dimensions: 
(define (make-dims base-len height-len) (cons base-len height-len))
(define (rectang-dims rectangle) (cdr rectangle))
(define (base-len rectangle) (car (rectang-dims rectangle)))
(define (height-len rectangle) (cdr (rectang-dims rectangle)))
```

The diagonal and diagonal angle in terms of these new selectors 
are as follows: 

```scheme
(define (diag-angle rectangle) 
  (atan (height-len rectangle) (base-len rectangle)))
(define (diagonal rectangle) 
  (let 
    ((b (base-len rectangle)) 
      (h (height-len rectangle)) 
      (a (rotation rectangle)) 
      (x_0 (x-point (origin rectangle))) 
      (y_0 (y-point (origin rectangle)))) 
    (make-segment 
      (origin rectangle) 
      (make-point 
        (+ x_0 (- (* b (cos a)) (* h (sin a)))) 
        (+ y_0 (+ (* b (sin a)) (* h (cos a))))))))
```

We can calculate the area and perimeter directly using the previous 
`area` and `perimeter`: 

```scheme
(define R 
  (make-rectang 
    (make-position 
      (make-point 1 1) 
      (radian 30)) 
    (make-dims 4 3)))
;Value: r

1 ]=> (degree (diag-angle R))
;Value: 36.86989764584402

1 ]=> (area R)
;Value: 12

1 ]=> (perimeter R)
;Value: 14.
```

The barrier of abstrction is successful in maintaining the functionality 
of `area` and `perimeter`, since we defined these in terms of the 
`base-len` and `height-len`, so we only need to tweak how the base 
and length are calculated between the two sets of definitions to make 
use of `area` and `perimeter`. 

This alternative definition can be 
[visualized in Desmos similar to before](https://www.desmos.com/calculator/p5un8wyjgw). 

# Exercise 2.4

+ [Exercise 2.4](./Exercise_Source/E2_4.scm).

```scheme
(define (cons-alt x y) 
  (lambda (m) (m x y)))

(define (car-alt z) 
  (z (lambda (p q) p)))

(define (cdr-alt z) 
  (z (lambda (p q) q)))
```

Verification by evaluating in Scheme: 

```scheme
1 ]=> (car-alt (cons-alt "sun" "moon"))
;Value: "sun"

1 ]=> (cdr-alt (cons-alt "red" "blue"))
;Value: "blue"
```

Verification by substitution model: 

```scheme
(cdr-alt (cons-alt "red" "blue"))

((cons-alt "red" "blue") (lambda (p q) q))

((lambda (m) (m "red" "blue")) (lambda (p q) q))

((lambda (p q) q) "red" "blue")

"blue"
```

# Exercise 2.5

Notice that $2^a$ is not divisible by $3$ and $3^b$ is not divisible by 
$2$. Thus, if $n = 2^a 3^b$ then we can extract $a$ by counting the 
number of times $m$ we need to divide $n$ by $2$ until the result is 
not divisible by $2$, this will occur precisely when $m=a$. We can 
extract $b$ similarly, just dividing by $3$ instead of $2$. 

The constructor and selectors for such integer pairs can be 
[defined as follows](./Exercise_Source/E2_5.scm):

```scheme
(define (count-divisions n divisor) 
  (define (iter-div iter-n count) 
    (if 
      (= (remainder iter-n divisor) 0) 
      (iter-div (/ iter-n divisor) (+ count 1)) 
      count)) 
  (iter-div n 0))

(define (cons-int a b) 
  (* (expt 2 a) (expt 3 b)))

(define (car-int c) (count-divisions c 2))

(define (cdr-int c) (count-divisions c 3))
```

Testing our procedures:

```scheme
1 ]=> (define z (cons-int 2 3))
;Value: z

1 ]=> (car-int z)
;Value: 2

1 ]=> (cdr-int z)
;Value: 3

1 ]=> (define z (cons-int 4 9))
;Value: z

1 ]=> (car-int z)
;Value: 4

1 ]=> (cdr-int z)
;Value: 9

1 ]=> (define z (cons-int 1 11))
;Value: z

1 ]=> (car-int z)
;Value: 1

1 ]=> (cdr-int z)
;Value: 11

1 ]=> (define z (cons-int 8 0))
;Value: z

1 ]=> (car-int z)
;Value: 8

1 ]=> (cdr-int z)
;Value: 0
```

This type of representation of integer pairs can be constructed using not 
just $2$ and $3$, but any two integers that are relatively prime 
(only positive common divisor between the two is $1$). 

# Exercise 2.6

Evaluation of `(add-1 zero)` using the substitution model:

```scheme
(add-1 zero)

(lambda (f) (lambda (x) (f ((zero f) x))))

(lambda (f) (lambda (x) (f ((lambda (x) x) x))))

(lambda (f) (lambda (x) (f x)))
```

Since the last line above is the result of `(add-1 zero)`, it is in fact 
`one`. Then: 

```scheme
(add-1 one)

(lambda (f) (lambda (x) (f ((one f) x))))

(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))

(lambda (f) (lambda (x) (f (f x))))
```

In fact, in general *Church numerals* represent positive integers as 
repeated evaluation of function $f$ on some argument $x$. Therefore 
addition for Church numerals $m$, $n$ can be defined by applying 
$f$ and total of $m+n$ times [as follows](./Exercise_Source/E2_6.scm):

```scheme
(define (plus m n) 
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))
```

```scheme
1 ]=> ; Testing Church numeral with one and two.
(define (inc i) (+ i 1))
;Value: inc

1 ]=> (define (half-step x) (+ x 0.5))
;Value: half-step

1 ]=> ((one inc) 0)
;Value: 1

1 ]=> ((one half-step) 0)
;Value: .5

1 ]=> ((two inc) 0)
;Value: 2

1 ]=> ((two half-step) 0)
;Value: 1.

1 ]=> (((plus one two) inc) 0)
;Value: 3

1 ]=> (((plus one two) half-step) 0)
;Value: 1.5
```

Defining procedures that convert regular numbers to/from Church numerals 
allow for easy testing of large Church numerals:

```scheme
(define (num-to-church n) 
  (define (church-iter i church-i) 
    (if 
      (= i n) 
      church-i 
      (church-iter (+ i 1) (add-1 church-i)))) 
  (church-iter 0 zero))

(define (church-to-num church-n) 
  ((church-n inc) 0))
```

```scheme
1 ]=> ; Testing Church numeral addition with large numbers.
(define c-125 (num-to-church 125))
;Value: c-125

1 ]=> (define c-415 (num-to-church 415))
;Value: c-415

1 ]=> (define result (plus c-125 c-415))
;Value: result

1 ]=> (church-to-num result)
;Value: 540

1 ]=> ((result half-step) 0)
;Value: 270
```

# Exercise 2.7

+ [Exercise 2.7](./Exercise_Source/E2_7.scm).

General problem premise for exercise 2.7 to 2.16 is found in section 2.1.4 
of the text. 

```scheme
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))
```

# Exercise 2.8

+ [Exercise 2.8](./Exercise_Source/E2_8.scm).

```scheme
(define (sub-interval x y) 
  (make-interval 
    (- (lower-bound x) (upper-bound y)) 
    (- (upper-bound x) (lower-bound y))))
```
```scheme
(define X (make-interval 1 2))
;Value: x

1 ]=> (define Y (make-interval -1 3))
;Value: y

1 ]=> (print-interval (sub-interval X Y))
(-2, 3)
```

# Exercise 2.9

## Widths When Intervals are Summed or Subtracted

By the definition given, for interval $I$ with upperbound $UB_I$ and 
lowerbound $LB_I$, the width is defined as: 

$$
w_I = \frac{UB_I - LB_I}{2}
$$

Let $J$ be another interval with bounds $UB_J$ and $LB_J$. Consider 
$K = I - J$. 

$$
\begin{align}
w_K &= \frac{UB_K - LB_K}{2} \\
  &= \frac{1}{2} \left((UB_I - LB_J) - (LB_I - UB_J)\right) \\
  &= \frac{1}{2} \left( UB_I - LB_I - LB_J + UB_J \right) \\
  &= \frac{1}{2} \left( (UB_I - LB_I) + (UB_J - LB_J)\right) \\
  &= w_I + w_J
\end{align}
$$

On the other hand, consider $L = I + J$

$$
\begin{align}
w_L &= \frac{UB_L - LB_L}{2} \\
  &= \frac{1}{2} \left( (UB_I + UB_J) - (LB_I + LB_J) \right) \\
  &= \frac{1}{2} \left( UB_I - LB_I + UB_J - LB_J \right) \\
  &= w_I + w_J
\end{align}
$$

So we see that the widths from summing or subtracting intervals is a 
function of only the input intervals' widths.

## Widths When Intervals are Multiplied or Divided

Consider $I = [2, 5]$, $J = [3, 7]$ and $K = [1, 5]$. Observe that 
$w_J = w_K = 2$. However: 

$$
\begin{align}
w(I\times J) &= w([6, 35]) = 14.5 \\
w(I \times K) &= w([2, 25]) = 6.5 
\end{align}
$$

Despite $J$ and $K$ having the same width, their interval products 
with $I$ does not have the same width. Therefore the widths of 
intervals produced by multiplication are not just functions of the 
input intervals' widths. 

Similarly:

$$
\begin{align}
w\left(\frac{I}{J}\right) &= w([0.2857\ldots, 1.\overline{6}]) = 0.6904\ldots \\
w\left(\frac{I}{K}\right) &= w([0.4, 5]) = 2.3
\end{align}
$$

So widths of intervals produced by division are also not just functions 
of the input intervals' widths. Below are tests done in 
[Scheme](./Exercise_Source/E2_9.scm):

```scheme
(define (width-interval interval) 
  (/ (- (upper-bound interval) (lower-bound interval)) 2.0))
```

```scheme
(define I (make-interval 2 5))
;Value: i

1 ]=> (define J (make-interval 3 7))
;Value: j

1 ]=> (define K (make-interval 1 5))
;Value: k

1 ]=> (width-interval I)
;Value: 1.5

1 ]=> (width-interval J)
;Value: 2.

1 ]=> (width-interval K)
;Value: 2.

1 ]=> (width-interval (mul-interval I J))
;Value: 14.5

1 ]=> (width-interval (mul-interval I K))
;Value: 11.5

1 ]=> (width-interval (div-interval I J))
;Value: .6904761904761905

1 ]=> (width-interval (div-interval I K))
;Value: 2.3
```

# Exercise 2.10

+ [Exericse 2.10](./Exercise_Source/E2_10.scm).
+ Denominator interval is okay if its upperbound is smaller than $0$ 
or if its lowerbound is greater than $0$.

```scheme
(define (div-interval x y) 
  (if 
    (or 
      (< (upper-bound y) 0) 
      (> (lower-bound y) 0)) 
    (mul-interval 
      x
      (make-interval 
        (/ 1.0 (upper-bound y)) 
        (/ 1.0 (lower-bound y))))
    (error "Division undefined, denominator interval spans over 0.")))
```

```scheme
1 ]=> (print-interval (div-interval (make-interval 1 2) (make-interval 0 2)))
;Division undefined, denominator interval spans over 0.
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.

2 error> (print-interval (div-interval (make-interval 1 2) (make-interval -2 0)))
;Division undefined, denominator interval spans over 0.
;To continue, call RESTART with an option number:
; (RESTART 2) => Return to read-eval-print level 2.
; (RESTART 1) => Return to read-eval-print level 1.

3 error> (print-interval (div-interval (make-interval 1 2) (make-interval -2 2)))
;Division undefined, denominator interval spans over 0.
;To continue, call RESTART with an option number:
; (RESTART 3) => Return to read-eval-print level 3.
; (RESTART 2) => Return to read-eval-print level 2.
; (RESTART 1) => Return to read-eval-print level 1.

4 error> (print-interval (div-interval (make-interval 1 2) (make-interval 0.1 2)))
(.5, 20.)
;Unspecified return value

4 error> (print-interval (div-interval (make-interval 1 2) (make-interval -2 -0.1)))
(-20., -.5)
;Unspecified return value
```

# Exercise 2.11

The nine cases based on signs of the endpoints can be determined and 
computed [as follows](./Exercise_Source/E2_11.scm):

```scheme
(define (mul-interval x y) 
  (let 
    ((u-x (upper-bound x)) 
    (l-x (lower-bound x)) 
    (u-y (upper-bound y)) 
    (l-y (lower-bound y))) 
    (if (> u-x 0) 
      (if (> l-x 0) 
        (if (> u-y 0) 
          (if (> l-y 0) 
            (make-interval (* l-x l-y) (* u-x u-y)) 
            (make-interval (* u-x l-y) (* u-x u-y)))
          (make-interval (* u-x l-y) (* l-x u-y)))
        (if (> u-y 0)
          (if (> l-y 0) 
            (make-interval (* l-x u-y) (* u-x u-y)) 
            (make-interval 
              (min (* u-x l-y) (* l-x u-y)) 
              (max (* u-x u-y) (* l-x l-y))))
          (make-interval (* u-x l-y) (* l-x l-y))))
      (if (> u-y 0)
        (if (> l-y 0) 
          (make-interval (* l-x u-y) (* u-x l-y))
          (make-interval (* l-x u-y) (* l-x l-y)))
        (make-interval (* u-x u-y) (* l-x l-y))))))
```

```scheme
1 ]=> (print-interval (mul-interval (make-interval 2 3) (make-interval 4 5)))
(8, 15)
;Unspecified return value

1 ]=> (print-interval (mul-interval (make-interval 2 3) (make-interval -5 4)))
(-15, 12)
;Unspecified return value

1 ]=> (print-interval (mul-interval (make-interval 2 3) (make-interval -5 -4)))
(-15, -8)
;Unspecified return value

1 ]=> (print-interval (mul-interval (make-interval -3 2) (make-interval 4 5)))
(-15, 10)
;Unspecified return value

1 ]=> (print-interval (mul-interval (make-interval -3 2) (make-interval -5 4)))
(-12, 15)
;Unspecified return value

1 ]=> (print-interval (mul-interval (make-interval -3 2) (make-interval -5 -4)))
(-10, 15)
;Unspecified return value

1 ]=> (print-interval (mul-interval (make-interval -3 -2) (make-interval 4 5)))
(-15, -8)
;Unspecified return value

1 ]=> (print-interval (mul-interval (make-interval -3 -2) (make-interval -5 4)))
(-12, 15)
;Unspecified return value

1 ]=> (print-interval (mul-interval (make-interval -3 -2) (make-interval -5 -4)))
(8, 15)
;Unspecified return value
```

# Exercise 2.12

+ [Exercise 2.12](./Exercise_Source/E2_12.scm):
+ The solution uses some of the procedures defined by the problem statement 
to be concise. 

```scheme
(define (make-center-percent c p) 
  (make-center-width c (abs (* c (/ p 100)))))

(define (percent i) 
  (* 100 (/ (width i) (abs (center i)))))
```

```scheme
1 ]=> (print-interval (make-center-percent 50 5.0))
(47.5, 52.5)
;Unspecified return value

1 ]=> (print-interval (make-center-percent -50 5.0))
(-52.5, -47.5)
;Unspecified return value

1 ]=> (percent (make-interval -1 2))
;Value: 300

1 ]=> (percent (make-interval 1.8 2.2))
;Value: 10.000000000000004
```

# Exercise 2.13

Consider some interval $I=[l_I,u_I]$. We have:

$$
\begin{align}
w_I &= \frac{u_I - l_I}{2} \\
c_I &= \frac{u_I + l_I}{2} \\
u_I &= c_I + w_I \\
l_I &= c_I - w_I \\
p_I &= \frac{w_I}{|c_I|} 
\end{align}
$$

Where $l_I$ and $u_I$ are the lower and upper bounds of $I$, 
$w_I$ is the width of $I$, $c_I$ is the width of $I$, and 
$p_I$ is the percent tolerance of $I$. If the interval has 
only positive numbers then: 

$$
p_I = \frac{w_I}{c_I}
$$

We can rewrite the tolerance in terms of the upper and lower bounds: 

$$
p_I = \frac{u_I - l_I}{u_I + l_I}
$$

Let us first consider a few example intervals:
+ $I:=[49,51]$ and $J:=[0.099,0.101]$:
  + $p_I = 1/50 = 0.02$ and $p_J = 0.001/0.1 = 0.01$.
  + $K:=I\times J = [4.851, 5.151] $, and $p_K = \frac{5.151-4.851}{5.151+4.851} \approx 0.02999$
  + Remark $0.02 + 0.01 = 0.03$.
+ $I:=[86,90]$ and $J:=[2000,2008]$
  + $p_I = 2/88 \approx 0.022727$ and $p_J = 4/2004 \approx 0.001996$
  + $K:=I\times J = [17200, 180720]$, and $p_K = \frac{180720-172000}{180720+17200} \approx 0.024744$
  + Remark $0.022727 + 0.001996 = 0.024723 $.
+ $I:=[505,515]$ and $J:=[689,691]$:
  + $p_I = 5/510 \approx 0.009804$ and $p_J = 1/690 \approx 0.001449$
  + $K:=I\times J = [347945, 355865]$, and $p_K = \frac{7920}{703810} \approx 0.011253$
  + Remark $0.009804+0.001449=0.011253$.

It appears that for intervals $I$ and $J$ with small tolerances $p_I$, 
$p_J$, the tolerance $p_K$ of the product $K=I\times K$ is 
approximately equal to $p_I + p_J$. Let us prove this proposition 
for intervals with positive bounds. 

Let $I$ and $J$ be two positive intervals with small tolerances 
$p_I$, $p_J$.  Small tolerances means 

$$
0\approx p_I = \frac{w_I}{c_I} \implies c_I \gt \gt w_I
$$
 
and similarly for $p_J$. 

Let $K:=I\times J$. If only positive numbers are considered, then we 
will have: 

$$
K=[l_K,u_K]=[l_I l_J, u_I u_J]=[(c_I-w_I)(c_J-w_J),(c_I+w_I)(c_J+w_J)]
$$

Observe that:

$$
\begin{align}
  u_K - l_K 
    &= (c_I + w_I)(c_J + w_J) - (c_I - w_I)(c_J - w_J) \\
    &= (c_I c_J + w_I c_J + c_I w_J + w_I w_J) -
      (c_I c_J - w_I c_J - c_I w_J + w_I w_J) \\
    &= 2(w_I c_J + c_I w_J)
\end{align}
$$

... and:

$$
\begin{align}
  u_K + l_K 
    &= (c_I + w_I)(c_J + w_J) + (c_I - w_I)(c_J - w_J) \\
    &= (c_I c_J + w_I c_J + c_I w_J + w_I w_J) +
      (c_I c_J - w_I c_J - c_I w_J + w_I w_J) \\
    &= 2(c_I c_J + w_I w_J)
\end{align}
$$

However, based on our small tolerance assumption $c_I \gt \gt w_I$ and 
$c_J \gt \gt w_J$ we can say $c_I c_J \gt \gt w_I w_J$ and thus 
$c_I c_J + w_I w_J \approx c_I c_J$, which results in:

$$
u_K + l_K \approx 2 c_I c_J
$$

Then we see that:

$$
\begin{align}
p_K 
  &= \frac{w_K}{c_K} \\
  &= \frac{u_K - l_K}{u_K + l_K} \\
  &\approx \frac{2 (w_I c_J + c_I w_J)}{2 c_I c_J} \\
  &= \frac{w_I}{c_I} + \frac{w_J}{c_J} \\
p_K
  &= p_I + p_J 
\end{align}
$$

Therefore the product of two intervals with small percent tolerances has a 
simple approximate formula as its onw percent tolerance, namely the sum of 
the factors' tolerances. 

# Exercise 2.14

+ Note that for a positive interval $A$ with small percent tolerance, 
$1/A$ would have approximately the same percent tolerance as $A$.
+ To see this consider $\frac{1}{A}$:

$$ 
\frac{1}{A} = \left[ \frac{1}{c_A + w_A}, \frac{1}{c_A - w_A} \right] 
$$

+ The width of $\frac{1}{A}$:

$$
\begin{align}
w\left( \frac{1}{A} \right)
  &= \frac{1}{2} \left( \frac{1}{c_A - w_A} - \frac{1}{c_A + w_A}\right) \\
  &= \frac{1}{2} \left( \frac{c_A + w_A - c_A + w_A}{c_A^2 - w_A^2} \right)\\
  &\approx \frac{1}{2} \left( \frac{2 w_A}{c_A^2} \right) \impliedby c_A \gt \gt w_A \\
w\left(\frac{1}{A}\right)
  &= \frac{w_A}{c_A} 
\end{align}
$$

+ The centre of $\frac{1}{A}$:

$$
\begin{align}
c\left(\frac{1}{A}\right) 
  &= \frac{1}{2} \left( \frac{1}{c_A - w_A} + \frac{1}{c_A + w_A}\right) \\
  &= \frac{1}{2} \left( \frac{2c_A}{c_A^2 - w_A^2} \right) \\
  &\impliedby \frac{1}{2} \left( \frac{2c_A}{c_A^2} \right) \impliedby c_A \gt \gt w_A \\
c\left(\frac{1}{A}\right) 
  &= \frac{1}{c_A} 
\end{align}
$$

+ The percent tolerance of $\frac{1}{A}$:

$$
\begin{align}
p\left(\frac{1}{A}\right)
  &= \frac{w(1/A)}{c(1/A)} \\
  &\approx \frac{w_A/c_A^2}{1/c_A} \\
  &= \frac{w_A}{c_A} \\
  &= p_A
\end{align}
$$

+ [Exercise 2.14](./Exercise_Source/E2_14.scm).

```scheme
(define (print-interval-ct interval) 
  (newline) 
  (display (center interval))
  (display " +- ")
  (display (percent interval))
  (display "%"))
```

```scheme
(define (par1 r1 r2) 
  (div-interval 
    (mul-interval r1 r2) 
    (add-interval r1 r2)))

(define (par2 r1 r2) 
  (let 
    ((one (make-interval 1 1))) 
      (div-interval 
        one 
        (add-interval 
          (div-interval one r1) 
          (div-interval one r2)))))
```

```scheme
1 ]=> (define A (make-center-percent 365 4))
;Value: a

1 ]=> (define B (make-center-percent 1867 5))
;Value: b

1 ]=> (print-interval-ct (div-interval A A))
1.0032051282051282 +- 7.987220447284356%
;Unspecified return value

1 ]=> (print-interval-ct (div-interval A B))
.19638276193966436 +- 8.982035928143715%
;Unspecified return value

1 ]=> (print-interval-ct (par1 A B))
307.9713582363062 +- 13.758735666495026%
;Unspecified return value

1 ]=> (print-interval-ct (par2 A B))
305.30719383542475 +- 4.163653865714964%
;Unspecified return value
```

Lem E. Tweakit is correct that the two procedures for parallel resistances 
can produce different results, despite given the same inputs and 
representing the same algebraic expression. Also observe above that 
`(div-interval A A)` does not produce an interval with centre at `1`, 
but rather off by some amount. The width of `(div-interval A A)` is also 
double the width of `A` for small width intervals (this makes sense as our 
interval division definition $A/A$ would compute it essentially as 
$A \cdot \frac{1}{A}$, the width of $\frac{1}{A}$ is approx. the 
same as $A$ for small intervals, and the width of an interval product 
is approx. the sum of its widths' factors), so we see $A/A$ is not the 
same as an interval $1$ with width zero when computed with interval arithmetic. 

# Exercise 2.15

Eva Lu Ator is correct. Consider the additive identity $0$ for 
real arithmetic. In real arithmetic, for any $x\in\mathbb{R}$, 
we have the property that $x+0=x$. Furthermore we can obtain 
the additive identity $0$ by computing $x-x$. Therefore 
the expression $x+0$ can be re-written as $x + (x-x)$. 

For interval arithmetic we can also have an additive identity $\mathbf{0}$ 
where $\mathbf{0}=[0,0]$. For any interval $I$ it does satisfy the 
property that: 

$$
I+\mathbf{0}=[l_I + 0, u_I+0]=[l_I,u_I]=I
$$

What is different however, is that we do not generally obtain $\mathbb{0}$ 
by computing $I-I$:

$$
I-I = [l_I - u_l, u_l - l_I]
$$

If $I$ has non-zero width, $l_I - u_l \neq 0$ and $u_l - l_I\neq 0$. 
Therefore, while adding/subtracting $x-x$ for real numbers will have 
trivial results, it is not trivial for intervals, where the inherent 
uncertainty in the interval will alter the result. Indeed, while in 
reals we always have $-x$ as the additive inverse of $x \in \mathbb{R}$, 
such that $x + -x = 0$, there is no such additive inverse for intervals. 
To see this suppose $J$ is the additive inverse of $I$, and so 
$I + J = \mathbb{0}$, then:

$$
\begin{align}
I + J &= [0, 0] \\
[l_I + l_J, u_I + u_J] &= [0, 0] \\
&\therefore \\
l_J &= -l_I \\
u_J &= -u_J \\
J &= [-l_I, -u_J] \\
\end{align}
$$

But notice we need to have $u_I \geq l_I$, and so 
$-u_I \leq -l_I$, but if $-u_I = u_J$ and $-l_I = l_J$, 
and we need $u_J \geq l_J$, this would cause a contradiction 
in cases other than the trivial $I=J=\mathbf{0}$, therefore 
the additive inverse $J$ does not exist for an arbitrary $I$. 

A similar situation exists for the real number multiplicative identity 
$1$ and the real number multiplicative inverse $1/x$ (where 
$x\in\mathbf{R}$, $x\neq 0$). As we saw before, for an interval 
$I$: 

$$
\frac{I}{I} = \left[\frac{l_I}{u_I}, \frac{u_I}{l_I}\right]\neq \mathbf{1} = [1,1]
$$

And similarly we would also reach a contradiction if we want to consider a 
general multiplicative inverse of an arbitrary interval. 

Overall, expressions with repeating variables that produce additive 
or multiplicative identities for real numbers would not do the same for 
intervals, in fact additive and multiplicative inverses do not 
generally exist for intervals as we have defined them, therefore 
trivial repeat of variables in real number expressions must be 
reduced to prevent undesired growth of uncertainties. Comparing 
`par1` and `par2` from the last problem we also see that the 
results from `par2` using less repetition of intervals did provide 
tighter tolerance results. 

Sometimes we do want to use such properties of intervals to describe 
real problems. For instance, say a worker is using a scoop to scoop 
out concrete on a construction site. The volume of concrete per scoop 
is likely subject to uncertainty, therefore the volume scooped is 
$V=[l_V, u_V]$. If the worker scoops two scoops of concrete into a 
mold, then decides to remove one scoop from the mold, the remaining 
volume of concrete inside the mold would be $V+V-V$. The fact that 
the $V-V$ cannot be re-written as $\mathbf{0}$ is in fact an 
appropriate property, since the uncertainties in the second and 
third scoops mean the scoopful left in the mold is not the same 
as the initial scoop. Therefore the user must be careful that when they 
repeat uncertain variables, the repetition describes the problem at 
hand. If the repetition is unnecessary and the expression would 
result in additive / multiplicative in real arithmetic, the user 
should reduce the expressions as real numbers beforehand before 
introducing the uncertainty. 

# Exercise 2.16

See above answer for Exercise 2.15 as well. In short, we have seen 
that equivalent expressions in real numbers may be relying on the 
fact that expressions reduces to operational identities such as 
$0$ for addition and $1$ for multiplicative, which in turn 
can rely on the fact that these identities can be produced by 
operational inverses such as $-x$ for $x$ in addition and 
$1/x$ for $x$ in multiplication. These objects may not 
necessarily be produced with similar expressions if the underlying 
construct changes, and indeed may not exist at all. Therefore 
seemingly identical algebraic expressions can lead to different 
results if the nature of the inputs are different. 

Intuitively an interval-arithmetic package that avoids the 
shortcoming seems impossible. Consider the concrete scoop example 
described earlier in 2.15, the fact that an interval subtracted 
from itself does not produce $\mathbf{0}$ is actually an 
accurate description in that situation. In a way these properties 
are not shortcomings, and it seems hard to capture instances 
where these properties apply/don't apply in a general manner. 

The problem for non-equivalent algebraic expressions between 
real and interval arithmetics is the "dependency problem", and appears 
impossible upon cursory further reading. 

# Exercise 2.17

+ [Exercise 2.17](./Exercise_Source/E2_17.scm).

```scheme
(define (last-pair items) 
  (if 
    (null? (cdr items)) 
    items 
    (last-pair (cdr items))))
```

```scheme
1 ]=> (last-pair (list 1 2 3 4))
;Value: (4)
```

# Exercise 2.18 

+ [Exercise 2.18](./Exercise_Source/E2_18.scm).

```scheme
; Exercise 2.18 recursive process
(define (reversed-recursive items) 
  (define (iter-reverse iter-items) 
    (if 
      (null? (cdr iter-items)) 
      (list (car iter-items)) 
      (append 
        (iter-reverse (cdr iter-items)) 
        (list (car iter-items))))) 
  (iter-reverse items))
```

```scheme
1 ]=> (reversed-recursive one-through-four)
;Value: (4 3 2 1)

1 ]=> (reversed-recursive (list 1))
;Value: (1)

1 ]=> (reversed-recursive (list 1 (list 2 3)))
;Value: ((2 3) 1)
```

```scheme
(define (reversed items) 
  (define (iter-reverse iter-items iter-result) 
    (if 
      (null? iter-items) 
      iter-result 
      (iter-reverse 
        (cdr iter-items) 
        (append (list (car iter-items)) iter-result)))) 
  (iter-reverse items ()))
```

```scheme
1 ]=> (reversed one-through-four)
;Value: (4 3 2 1)

1 ]=> (reversed (list 1))
;Value: (1)

1 ]=> (reversed (list 1 (list 2 3)))
;Value: ((2 3) 1)
```

# Exercise 2.19

+ [Exercise 2.19](./Exercise_Source/E2_19.scm).

```scheme
(define (first-denom coin-values) 
  (car coin-values))

(define (except-first-denom coin-values) 
  (cdr coin-values))

(define (no-more coin-values) (null? coin-values))
```
```scheme
(define (cc amount coin-values) 
  (cond 
    ((= amount 0) 1) 
      ((or (< amount 0) (no-more coin-values)) 0) 
      (else 
        (+ 
          (cc 
            amount 
            (except-first-denom coin-values)) 
          (cc 
            (- amount (first-denom coin-values)) 
            coin-values)))))
```
```scheme
1 ]=> (cc 4 us-coins)
;Value: 1

1 ]=> (cc 11 us-coins)
;Value: 4

1 ]=> (cc 4 uk-coins)
;Value: 9

1 ]=> (cc 11 uk-coins)
;Value: 62
```
+ The ordering of the coins in the list does not matter. 
+ This is because the procedure counts all combinations with a particular 
type of coin on one branch of the recursive tree, and counts all combinations 
without that coin on the other branch. 
+ Whether a coin is counted earlier or later is irrelevant, overall the program 
is sure to process each coin, and all combinations containing that coin. 
+ Reversed order testing:
  ```scheme
  1 ]=> (define us-coins (reversed us-coins))
  ;Value: us-coins

  1 ]=> us-coins
  ;Value: (1 5 10 25 50)

  1 ]=> (define uk-coins (reversed uk-coins))
  ;Value: uk-coins

  1 ]=> uk-coins
  ;Value: (.5 1 2 5 10 20 50 100)

  1 ]=> (cc 4 us-coins)
  ;Value: 1

  1 ]=> (cc 11 us-coins)
  ;Value: 4

  1 ]=> (cc 4 uk-coins)
  ;Value: 9

  1 ]=> (cc 11 uk-coins)
  ;Value: 62
  ```
+ Mixed order testing:
  ```scheme
  1 ]=> (define us-coins (list 25 50 1 5 10))
  ;Value: us-coins

  1 ]=> us-coins
  ;Value: (25 50 1 5 10)

  1 ]=> (define uk-coins (list 1 0.5 10 20 5 2 100 50))
  ;Value: uk-coins

  1 ]=> uk-coins
  ;Value: (1 .5 10 20 5 2 100 50)

  1 ]=> (cc 4 us-coins)
  ;Value: 1

  1 ]=> (cc 11 us-coins)
  ;Value: 4

  1 ]=> (cc 4 uk-coins)
  ;Value: 9

  1 ]=> (cc 11 uk-coins)
  ;Value: 62
  ```
+ [Alternative procedures](./Exercise_Source/2_19b.scm):
  ```scheme
  (define first-denom car)
  (define except-first-denom cdr)
  (define no-more null?)
  ```
  + Returns the same results as previous. 

# Exercise 2.20

+ [Exercise 2.20](./Exercise_Source/E2_20.scm).

```scheme
(define (same-parity 1st-int . int-list) 
  (define par-check (if (even? 1st-int) even? odd?)) 
  (define (par-iter iter-list iter-result) 
    (if (null? iter-list) iter-result 
      (let 
        ((iter-num (car iter-list))) 
        (par-iter 
          (cdr iter-list) 
          (if 
            (par-check iter-num) 
            (cons iter-num iter-result) 
            iter-result))))) 
  (reverse (par-iter int-list (list 1st-int))))
```

```scheme
1 ]=> (same-parity 1 2 3 4 5 6 7)
;Value: (1 3 5 7)

1 ]=> (same-parity 2 3 4 5 6 7 8)
;Value: (2 4 6 8)

1 ]=> (same-parity 1)
;Value: (1)

1 ]=> (same-parity 1 2)
;Value: (1)

1 ]=> (same-parity 17 51 2 44 34 99)
;Value: (17 51 99)
```

# Exercise 2.21

+ [Exercise 2.21](./Exercise_Source/E2_21.scm).

  ```scheme
  (define (sqr-list items) 
    (if (null? items) 
      ()  
      (cons (square (car items)) (sqr-list (cdr items)))))
  ```
  ```scheme
  1 ]=> (sqr-list nums-1-to-4)
  ;Value: (1 4 9 16)

  1 ]=> (sqr-list num-1)
  ;Value: (1)

  1 ]=> (sqr-list num-neg-1-2)
  ;Value: (1 4)
  ```
  ```scheme
  (define (sqr-list items) 
    (map square items))
  ```
  ```scheme
  1 ]=> (sqr-list nums-1-to-4)
  ;Value: (1 4 9 16)

  1 ]=> (sqr-list num-1)
  ;Value: (1)

  1 ]=> (sqr-list num-neg-1-2)
  ;Value: (1 4)
  ```

+ `map` accomplishes the same task, but is more succinct. The first procedure 
that evolves a recursive process may also be more inefficient. 

# Exercise 2.22

+ [Exercise 2.22](./Exercise_Source/E2_22.scm).
+ Louis Reasoner's first procedure for `square-list`:
  ```scheme
  (define (square-list items)
    (define (iter things answer)
      (if (null? things)
        answer
        (iter (cdr things)
          (cons (square (car things))
            answer))))
    (iter items ()))
  ```
  ```scheme
  1 ]=> (square-list (list 1 2 3 4))
  ;Value: (16 9 4 1)
  ```
  + In the `iter` procedure above, it iterates "down" the list `things` 
  by using `(cdr things)` for the next iteration. 
  + However, for the newest number that has to be added to the list, it 
  is used as the first argument in the `cons` procedure. 
  + Therefore, as the iteration occurs down the `things` list, the newest 
  squared number becomes appended at the front of the `answer` list. So 
  in the end everything is reversed.
+ Louis Reasoner's second procedure for `square-list`:
  ```scheme
  (define (square-list items)
    (define (iter things answer)
      (if (null? things)
        answer
        (iter (cdr things)
          (cons answer
            (square (car things))))))
    (iter items ()))
  ```
  ```scheme
  1 ]=> (square-list (list 1 2 3 4))
  ;Value: ((((() . 1) . 4) . 9) . 16)
  ```
  + In the second procedure, Louis now tries to append the new number 
  at the end. The ordering of the numbers themselves are correct. 
  + However, the results are still faulty. This is because the initial 
  list used as input to start the interation is `()` (`nil` in text, 
  `nil` no longer applicable in latest version of Scheme). Therefore, 
  instead of the regular structure of ending the list at `()`, it 
  becomes distorted and `()` is in front. 
  + Further, for a list, `car` must extract just the first element in 
  the list, while `cdr` will extract the rest of the list. This is not 
  the results produced by the second procedure. In the `cons` part above, 
  the list is being iteratively `cons`'ed in the `car` position, while 
  the newest number is at the `cdr` position. So in the end, the `cdr` 
  would extract the last element while `car` extracts the rest of the list. 
  
# Exercise 2.23

+ [Exercise 2.23](./Exercise_Source/E2_23.scm).

```scheme
(define (for-each-item proc items) 
  (if 
    (null? items) 
    #t 
    (let 
      ((run (proc (car items)))) 
      (for-each-item proc (cdr items)))))
```
```scheme
1 ]=> (for-each-item 
  (lambda (x) (newline) (display x)) 
  (list 1 2 3 4))
1
2
3
4
;Value: #t
```

# Exercise 2.24

+ [Exercise 2.24](./Exercise_Source/E2_24.scm). 
```scheme
1 ]=> (list 1 (list 2 (list 3 4)))
;Value: (1 (2 (3 4)))
```
+ Box and pointer representation:

```
                                  (2 (3 4))    (3 4)
                                  |            | 
                                  v            v 
(1 (2 (3 4))) -> | * | * | -> | * | * | -> | * | * | -> | * | () |
                   |            |            |            |
                   v            v            v            v
                 | 1 |        | 2 |        | 3 |        | 4 |
```
+ Tree representation:
```
(1 (2 (3 4)))
|______________
|             |
v             v
1             (2 (3 4))
              |__________
              |         |
              v         v
              2         (3 4)
                        |______
                        |     |
                        v     v
                        3     4
```

# Exercise 2.25

+ [Exercise 2.25](./Exercise_Source/E2_25.scm).
+ Element `7` must be extracted from each of the following lists using `car` 
and `cdr` combo:
```scheme
(define items-1 (list 1 3 (list 5 7) 9))
(define items-2 (list (list 7)))
(define items-3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
```
```scheme
1 ]=> items-1
;Value: (1 3 (5 7) 9)

1 ]=> items-2
;Value: ((7))

1 ]=> items-3
;Value: (1 (2 (3 (4 (5 (6 7))))))
```
+ Combination of `car`s and `cdr`s used:
```scheme
(car (cdr (car (cdr (cdr items-1)))))
(car (car items-2))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr items-3))))))))))))
```
```scheme
1 ]=> (car (cdr (car (cdr (cdr items-1)))))
;Value: 7

1 ]=> (car (car items-2))
;Value: 7

1 ]=> (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr items-3))))))))))))
;Value: 7
```

# Exercise 2.26

+ [Exercise 2.26](./Exercise_Source/E2_26).

```scheme
(define x (list 1 2 3))
(define y (list 4 5 6))
```
```scheme
1 ]=> (append x y)
;Value: (1 2 3 4 5 6)

1 ]=> (cons x y)
;Value: ((1 2 3) 4 5 6)

1 ]=> (list x y)
;Value: ((1 2 3) (4 5 6))
```
+ Explanation:
  + `(append x y)` creates a new list, the elements are simply the elements 
  from `x` and `y`, with `x` elements listed first, then `y` elements.
  + `(cons x y)`:
    + `(cons x y)` creates a pair, the first element in the pair is the 
    list `(1 2 3)`, while the second element is the list `(4 5 6)`. 
    + However the printed results looks like a list with the first element 
    being the list `(1 2 3)`, and the rest of the elements being elements 
    `3 4 5`. This is in fact identical to the first description. 
    + Indeed, `(list 4 5 6)` is identical to `(cons 4 (cons 5 (cons 6 ())))`, 
    so `(cons x y)` is the same as:
    ```scheme
    (cons x (cons 4 (cons 5 (cons 6 ()))))
    ```
    + That's why the first element in `(cons x y)` is the entire list of `x`, 
    while the rest of the elements are the elements in `y`.
  + `(list x y)`: creates a list of three elements including the empty list. 
  The first element is the whole list of `x`, the second element is the whole 
  list of `y`, while the third element is the empty list. 
  + While `(cons x y)` and `(list x y)` both have the list `x` as their first 
  elements, the rest of their elements are not the same per the above 
  explanation. 
  ```scheme
  1 ]=> (cdr (cdr (cons x y)))
  ;Value: (5 6)

  1 ]=> (cdr (cdr (list x y)))
  ;Value: ()
  ```

# Exercise 2.27

+ [Exercise 2.27](./Exercise_Source/E2_27.scm).

```scheme
(define (deep-reverse items) 
  (define (d-r-iter iter-return iter-items) 
    (if (null? iter-items) 
      iter-return 
      (let 
        ((next-item (car iter-items))) 
        (d-r-iter 
          (cons 
            (if (pair? next-item) 
              (d-r-iter () next-item) 
              next-item) 
            iter-return) 
          (cdr iter-items))))) 
  (d-r-iter () items))
```

```scheme
1 ]=> (define x (list 1 2 (list 3 4)))
;Value: x

1 ]=> (deep-reverse x)
;Value: ((4 3) 2 1)

1 ]=> (define x (list (list 1 2) (list 3 4)))
;Value: x

1 ]=> (deep-reverse x)
;Value: ((4 3) (2 1))

1 ]=> (define x (list (list (list 1 2) 3 4) 5 6 (list 7 (list 8 9))))
;Value: x

1 ]=> (deep-reverse x)
;Value: (((9 8) 7) 6 5 (4 3 (2 1)))
```

# Exercise 2.28

+ [Exercise 2.28](./Exercise_Source/E2_28.scm).

```scheme
(define (fringe tree) 
  (define (fringe-iter iter-return iter-tree) 
    (if (null? iter-tree) 
      iter-return 
      (let 
        ((next-item (car iter-tree))) 
        (fringe-iter 
          (if (pair? next-item) 
            (fringe-iter iter-return next-item) 
            (cons next-item iter-return)) 
          (cdr iter-tree)))))
  (reverse (fringe-iter () tree)))
```

```scheme
1 ]=> (define x (list (list 1 2) (list 3 4)))
;Value: x

1 ]=> x
;Value: ((1 2) (3 4))

1 ]=> (define y (list (list 1 2 (list 3 4 5)) (list 6 (list 7 8) 9 (list 10 11) 12)))
;Value: y

1 ]=> y
;Value: ((1 2 (3 4 5)) (6 (7 8) 9 (10 11) 12))

1 ]=> (fringe x)
;Value: (1 2 3 4)

1 ]=> (fringe (list x x))
;Value: (1 2 3 4 1 2 3 4)

1 ]=> (fringe y)
;Value: (1 2 3 4 5 6 7 8 9 10 11 12)

1 ]=> (fringe (list y (list x y)))
;Value: (1 2 3 4 5 6 7 8 9 10 11 12 1 2 3 4 1 2 3 4 5 6 7 8 9 10 11 12)
```

# Exercise 2.29

+ [Exercise 2.29](./Exercise_Source/E2_29.scm).

## Exercise 2.29a

```scheme
(define (make-mobile left right) 
  (list left right))

(define (make-branch branch-len structure) 
  (list branch-len structure))
```

```scheme
(define (left-branch bin-mobile) 
  (car bin-mobile))

(define (right-branch bin-mobile) 
  (car (cdr bin-mobile)))

(define (branch-length bin-branch) 
  (car bin-branch))

(define (branch-structure bin-branch) 
  (car (cdr bin-branch)))
```

+ Test mobile `b-mobile`:
```scheme
(define lll (make-branch 7 5))
(define llr (make-branch 2 3))
(define ll (make-branch 4 (make-mobile lll llr)))
(define lr (make-branch 1 4))
(define l (make-branch 3 (make-mobile ll lr)))
(define rr (make-branch 8 9))
(define rl (make-branch 5 11))
(define r (make-branch 6 (make-mobile rl rr)))
(define b-mobile (make-mobile l r))
```

```
         `b-mobile`
              |
           _3_|__6___
           |        |
       __4_|1  __5__|___8____
       |    |  |            |
___7___|_2  |  |            |
|        |  4  11           9
|        |
5        3
```

```scheme
1 ]=> ; 2.29a - Testing
(branch-length (left-branch b-mobile))
;Value: 3

1 ]=> (branch-length (right-branch (branch-structure (left-branch b-mobile))))
;Value: 1

1 ]=> (branch-length (right-branch b-mobile))
;Value: 6

1 ]=> (branch-structure (left-branch (branch-structure (right-branch b-mobile))))
;Value: 11
```

## Exercise 2.29b

```scheme
(define (branch-weight branch) 
  (let 
    ((branch-end (branch-structure branch))) 
    (cond 
      ((null? branch-end) 0)
      ((pair? branch-end) (total-weight branch-end)) 
      (else branch-end))))

(define (total-weight bin-mobile) 
  (+ 
    (branch-weight (left-branch bin-mobile)) 
    (branch-weight (right-branch bin-mobile))))
```

```scheme
1 ]=> (total-weight b-mobile)
;Value: 32
```

## Exercise 2.29c

+ Many online trials for the balance check procedure traverse the 
tree multiple times to compute the weights, which is inefficient.
+ The following `is-balanced` procedure tries to minimize repeated 
calculations of weights by passing the sub-weights "up" the recursive 
tree. 
+ If it detects imbalance in one of the sub-mobiles, the procedure 
will pass a signal and stop traversing other branches. 
```scheme
(define (is-balanced bin-mobile) 
  (define imbalance-signal #f) 
  (define found-imbalance boolean?) 
  (define fully-balanced number?) 
  (define (branch-balance branch) 
    (let ((branch-end (branch-structure branch))) 
      (cond 
        ((null? branch-end) 0) 
        ((pair? branch-end) (iter-bw branch-end)) 
        (else branch-end))))
  (define (iter-bw iter-mobile) 
    (let 
      ((left (left-branch iter-mobile)) 
      (right (right-branch iter-mobile))) 
      (let ((l-bal-wt (branch-balance left))) 
        (if (found-imbalance l-bal-wt) 
          imbalance-signal 
          (let ((r-bal-wt (branch-balance right))) 
            (if (found-imbalance r-bal-wt) 
              imbalance-signal 
                (if 
                  (= 
                    (* (branch-length left) l-bal-wt) 
                    (* (branch-length right) r-bal-wt)) 
                  (+ l-bal-wt r-bal-wt) 
                  imbalance-signal))))))) 
  (fully-balanced (iter-bw bin-mobile)))
```

+ Another test mobile `b-b-mobile`:
```scheme
(define b-ll (make-branch 4 3))
(define b-lr (make-branch 2 6))
(define b-l (make-branch 8 (make-mobile b-ll b-lr)))
(define b-rr (make-branch 15 2))
(define b-rl (make-branch 3 10))
(define b-r (make-branch 6 (make-mobile b-rl b-rr)))
(define b-b-mobile (make-mobile b-l b-r))
```

```
      `b-b-mobile`
            |
    ____8___|___6__
    |             |
__4_|_2        _3_|______15_______
|     |        |                 |
|     |        |                 |
3     6        10                2
```

```scheme
1 ]=> (is-balanced b-mobile)
;Value: #f

1 ]=> (is-balanced b-b-mobile)
;Value: #t
```

## Exercise 2.29d

+ [Exercise 2.29d](./Exercise_Source/E2_29d.scm).

```scheme
(define (make-mobile left right) 
  (cons left right))

(define (make-branch branch-len structure) 
  (cons branch-len structure))
```

```scheme
(define (left-branch bin-mobile) 
  (car bin-mobile))

(define (right-branch bin-mobile) 
  (cdr bin-mobile))

(define (branch-length bin-branch) 
  (car bin-branch))

(define (branch-structure bin-branch) 
  (cdr bin-branch))
```

+ Only the selectors `right-branch` and `branch-structure` had to 
be changed. 
+ The rest of the program works as before.

```scheme
1 ]=> ; 2.29d - 2.29a - Testing
(branch-length (left-branch b-mobile))
;Value: 3

1 ]=> (branch-length (right-branch (branch-structure (left-branch b-mobile))))
;Value: 1

1 ]=> (branch-length (right-branch b-mobile))
;Value: 6

1 ]=> (branch-structure (left-branch (branch-structure (right-branch b-mobile))))
;Value: 11
```
```scheme
1 ]=> (total-weight b-mobile)
;Value: 32
```
```scheme
1 ]=> (is-balanced b-mobile)
;Value: #f

1 ]=> (is-balanced b-b-mobile)
;Value: #t
```

# Exercise 2.30 

+ [Exercise 2.28](./Exercise_Source/E2_30.scm).

```scheme
(define (sqr-tree-recursive tree) 
  (cond 
    ((null? tree) ()) 
    ((pair? tree) 
      (cons 
        (sqr-tree-recursive (car tree)) 
        (sqr-tree-recursive (cdr tree)))) 
    (else (* tree tree))))

(define (sqr-tree-map tree) 
  (map 
    (lambda (sub-tree) 
      (if (pair? sub-tree) 
        (sqr-tree-map sub-tree) 
        (square sub-tree))) 
    tree))

(define (sqr-tree-r-map tree) 
  (if (pair? tree) 
    (map sqr-tree-r-map tree) 
    (square tree)))

```

```scheme
1 ]=> (sqr-tree-recursive num-tree)
;Value: (1 (4 (9 16) 25) (36 49))

1 ]=> (sqr-tree-map num-tree)
;Value: (1 (4 (9 16) 25) (36 49))

1 ]=> (sqr-tree-r-map num-tree)
;Value: (1 (4 (9 16) 25) (36 49))
```

# Exercise 2.31

+ [Exercise 2.31](./Exercise_Source/E2_31.scm).

```scheme
(define (tree-map proc tree) 
  (define (tree-map-iter tree) 
    (if (pair? tree) 
      (map tree-map-iter tree) 
      (proc tree)))
  (tree-map-iter tree))

(define (sqr-tree tree) (tree-map square tree))
```

```scheme
1 ]=> (sqr-tree num-tree)
;Value: (1 (4 (9 16) 25) (36 49))
```

# Exercise 2.32

+ [Exercise 2.32](./Exercise_Source/E2_32.scm).

```scheme
(define (subsets s) 
  (if (null? s) 
    (list ()) 
    (let 
      ((rest (subsets (cdr s))) 
        (1st-elem (car s))) ; added line
      (append 
        rest 
        (map 
          (lambda (sub-s) (cons 1st-elem sub-s)) 
          rest)))))
```

```scheme
1 ]=> (subsets '(1 2 3))
;Value: (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

1 ]=> (subsets '(1 2 3 4))
;Value: (() (4) (3) (3 4) (2) (2 4) (2 3) (2 3 4) (1) (1 4) (1 3) (1 3 4) (1 2) (1 2 4) (1 2 3) (1 2 3 4))
```

+ This procedure works by successively appending more subsets, adding 
one element each time. 
+ The procedure first `cdr`s down the original set `s` through recursive 
calls of `subset` until it reaches `()`. 
+ Since all sets contain the empty set and there are no more elements in 
`s` to `cdr` down, the recursive calls stop and `()` is returned.
+ Then the procedure `append`s "up" the set `s`. At each depth of the 
recursive tree with some `1st-elem`, there are two lists being appended: 
  + The list `rest` is the subset returned from deeper recursive depths. 
  Since they were from deeper recursive depths, they do not contain the 
  `1st-elem` at the current depth. 
  + The list returned from `map` is a mapping from `rest` to a list that 
  is the same as `rest`, except all sets within now has `1st-elem` appended. 
+ In other words, two disjoint sets (of subsets of `s`) are combined, one of 
which contains subsets that have the `1st-elem` at the depth, the other 
contains subsets that does not have the `1st-elem`. 
+ Then the results from the particular depth is returned as `rest` to the 
depth above, where the process repeats. After processing a new `1st-elem`, 
another two lists are appended:
  + The *new* `rest` containing union of: 
    + Subsets *without* the *prior* `1st-elem`, AND *without* the *new* `1st-elem`.
    + Subsets *with* the *prior* `1st-elem`, AND *without* the *new* 1st-elem. 
  + The *new* `map` of *new* rest that would be a union of:
    + Subsets *without* the *prior* `1st-elem`, AND *with* the *new* `1st-elem`.
    + Subsets *with* the *prior* `1st-elem`, AND *with* the *new* 1st-elem. 
+ The procedure then continues on until all elements were considered. By the 
recursive nature of the process described above, the growing list eventually 
grow to encompass all subsets of `s` by considering one addtional element 
at a time.
+ Put another way, the procedure makes use of the fact that all subsets 
of some set $S$ can be separated into two disjoint sets $T$ and $T^c$. 
Where $T$ has all subsets of $S$ that has an element $t\in S$, and 
$T^c$ has all subsets of $S$ without $t$. But to get $T$ we only 
need to add $t$ to every set inside $T^c$. This can then be repeated 
on $T^c$ for some other element $u\in S$ and $u\neq t$, eventually 
giving all subsets of $S$. 

# Exercise 2.33

+ [Exercise 2.33](./Exercise_Source/E2_33.scm)
+ Mapping sequences with `seq-map`:
  ```scheme
  (define (seq-map proc sequence) 
    (accumulate 
      (lambda (iter-elem remaining) 
        (cons 
          (if (pair? iter-elem) 
            (seq-map proc iter-elem) 
            (proc iter-elem)) 
          remaining)) 
      () sequence))
  ```
+ Appending sequences with `seq-append`:
  ```scheme
  (define (seq-append seq1 seq2) 
    (accumulate cons seq2 seq1))
  ```
+ Getting length of a sequence with `seq-length`: 
  ```scheme
  (define (seq-length sequence) 
    (accumulate 
      (lambda (iter-elem len-rest) 
        (+ 1 len-rest)) 
      0 sequence))
  ```
+ Testing: 
  ```scheme
  1 ]=> ; Testing
  (define num-list (list 1 2 3 (list 4 5) 6 (list 7 (list 8 9))))
  ;Value: num-list

  1 ]=> (seq-map square num-list)
  ;Value: (1 4 9 (16 25) 36 (49 (64 81)))

  1 ]=> (define num-list-1 (list 1 2 (list 3 4)))
  ;Value: num-list-1

  1 ]=> (define num-list-2 (list (list 5 6 (list 7 8)) 9))
  ;Value: num-list-2

  1 ]=> (seq-append num-list-1 num-list-2)
  ;Value: (1 2 (3 4) (5 6 (7 8)) 9)

  1 ]=> (seq-length num-list-2)
  ;Value: 2
  ```

# Exercise 2.34
+ [Exercise 2.34](./Exercise_Source/E2_24.scm)
```scheme
(define (horner-eval x coeff-seq) 
  (accumulate 
    (lambda (this-coeff higher-term) (+ this-coeff (* x higher-term))) 
    0 
    coeff-seq))
```
```scheme
1 ]=> ; Test: BMD of fixed continuous beam under uniformly distributed load. 
(define q 3.0)
;Value: q

1 ]=> (define L 8.0)
;Value: l

1 ]=> (define BMD-coeff 
  (list 
    (- (/ (* q (square L)) 12.0)) 
    (/ (* q L) 2.0) 
    (- (/ q 2))))
;Value: bmd-coeff

1 ]=> (horner-eval 0.0 BMD-coeff)
;Value: -16.

1 ]=> (horner-eval (* L 0.21) BMD-coeff)
;Value: -.073599999999999

1 ]=> (horner-eval (/ L 2.0) BMD-coeff)
;Value: 8.
```

# Exercise 2.35

+ [Exercise 2.35](./Exercise_Source/E2_35.scm)

```scheme
(define (count-leaves t) 
  (accumulate 
    + 
    0 
    (map 
      (lambda (sub-t) 
        (if (pair? sub-t) (count-leaves sub-t) 1)) 
      t)))
```
```
1 ]=> (count-leaves ())
;Value: 0

1 ]=> (define num-list (list 1 2 (list 3 (list 4 5) 6) 7 (list 8 (list 9))))
;Value: num-list

1 ]=> (count-leaves num-list)
;Value: 9
```

# Exercise 2.36

+ [Exercise 2.36](./Exercise_Source/E2_36.scm)

```scheme
(define (accumulate-n op init seqs) 
  (if (null? (car seqs)) 
    () 
    (cons 
      (accumulate op init (map car seqs)) 
      (accumulate-n op init (map cdr seqs)))))
```

```scheme
1 ]=> (define M (list (list 3 0 0) (list 0 2 0) (list 0 0 1)))
;Value: m

1 ]=> (define sym (list (list 1 2 3) (list 2 4 7) (list 3 7 14)))
;Value: sym

1 ]=> (accumulate-n + 0 M)
;Value: (3 2 1)

1 ]=> (accumulate-n + 0 sym)
;Value: (6 13 24)
```

# Exercise 2.37 

+ [Exercise 2.37](./Exercise_Source/E2_37.scm)

```scheme
(define (matrix-*-vector m v) 
  (map 
    (lambda (m_i) (dot-product v m_i)) m))

(define (transpose mat) 
  (accumulate-n cons () mat))

(define (matrix-*-matrix m n) 
  (let 
    ((cols (transpose n))) 
    (map (lambda (m_i) (matrix-*-vector cols m_i)) m)))
```

```scheme
1 ]=> (define v '(1 2 3))
;Value: v

1 ]=> (define m (list '(1 2 3) '(4 5 6) '(7 8 9)))
;Value: m

1 ]=> (define a (list '(1 2 3) '(4 5 6)))
;Value: a

1 ]=> (define b (list '(1 2) '(3 4) '(5 6)))
;Value: b

1 ]=> (matrix-*-vector m v)
;Value: (14 32 50)

1 ]=> (transpose a)
;Value: ((1 4) (2 5) (3 6))

1 ]=> (matrix-*-matrix a b)
;Value: ((22 28) (49 64))
```
