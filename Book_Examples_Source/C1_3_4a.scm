(define (average x y) (/ (+ x y) 2.0))

; Returning average damped fucntion as a procedure:
(define (average-damp f) 
  (lambda (x) (average (f x) x)))

(define (close-enough x y) (< (abs (- x y)) 0.00001))

(define (fixed-point f first-guess) 
  (define (try guess) 
    (let 
      ((next-guess (f guess))) 
      (if 
        (close-enough guess next-guess) 
        next-guess 
        (try next-guess)))) 
  (try first-guess))

(define (sq-root x) 
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(sq-root 0)
(sq-root 1)
(sq-root 2)
(sq-root 3)
(sq-root 4)

(define (cube-root x) 
  (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))

(cube-root 0)
(cube-root 1)
(cube-root 2)
(cube-root 3)
(cube-root 4)
