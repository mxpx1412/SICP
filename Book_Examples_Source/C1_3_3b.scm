(define (average x y) (/ (+ x y) 2.0))

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

(fixed-point cos 1.0)

(fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)

; This version does not converge!
; (define (sq-root x) (fixed-point (lambda (y) (/ x y)) 1.0))

; Convergent version:
(define (sq-root x) 
  (fixed-point 
    (lambda (y) (average y (/ x y))) 
    1.0))
(sq-root 0)
(sq-root 1)
(sq-root 2)
(sq-root 3)
(sq-root 4)
(sq-root 5)
