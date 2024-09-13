(define (a-plus-abs-b a b) 
  ((if (> b 0) + -) a b))

#| 
Behaviour: if b greater than zero, execute a + b, 
but if b smaller than zero (negative), execute a - b, 
such that the expression essentially is a + |b| 
|#

(a-plus-abs-b 2 3)

(a-plus-abs-b 2 -3)
