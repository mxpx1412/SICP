(define (good-enough-sqrt guess x) 
  (< (abs (- (* guess guess) x)) 0.001))

(define (average m n) (/ (+ m n) 2))

(define (improve-sqrt guess x) 
  (average guess (/ x guess)))

(define (new-if predicate then-clause else-clause) 
  (cond (predicate then-clause) 
	(else else-clause)))

(define (sqrt-iter guess x) 
  (new-if (good-enough-sqrt guess x) 
	  guess 
	  (sqrt-iter (improve-sqrt guess x) x)))

(define (sqrt x) (sqrt-iter 1.0 x))

(sqrt 9.0)
