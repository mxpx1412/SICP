(define (good-enough-sqrt guess x) 
  (< (abs (- (square guess) x)) 0.001))

(define (average y z) 
  (/ (+ y z) 2))

(define (improve-sqrt guess x) 
  (average guess (/ x guess)))

(define (sqrt-iter guess x) 
  (if (good-enough-sqrt guess x) 
  	guess 
	(sqrt-iter (improve-sqrt guess x) x)))

(define (sqrt x) (sqrt-iter 1 x))

(sqrt 2.0)
