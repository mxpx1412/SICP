(define (iterative-improve is-close improve) 
  (define (iterate guess) 
    (if 
      (is-close guess) 
      guess 
      (iterate (improve guess))))
  iterate)

; `sq-root` in terms of `iterative-improve`
(define (average a b) (/ (+ a b) 2.0))

(define (sq-root x) 
  ((iterative-improve 
    (lambda (guess) (< (abs (- (square guess) x)) 0.000001)) 
    (lambda (guess) (average guess (/ x guess)))) 
  1.0))

(sq-root 2)
(sq-root 9)
(sq-root 10)

; `fixed-point` in terms of `iterative-improve`
(define (fixed-point f first-guess) 
  ((iterative-improve 
    (lambda (guess) (< (abs (- (f guess) guess)) 0.000001)) 
    f) 
    first-guess))

(define (average-damp f) (lambda (x) (average (f x) x)))

(fixed-point cos 1.0)
(fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)
(fixed-point (average-damp (lambda (y) (/ 2.0 y))) 1.0)
