(define (average x y) (/ (+ x y) 2.0))

(define (close-enough x y) (< (abs (- x y)) 0.00001))

(define (fixed-point f first-guess) 
  (define (try guess) 
    (let 
      ((next-guess (f guess))) 
      (newline) 
      (display next-guess)
      (if 
        (close-enough guess next-guess) 
        next-guess 
        (try next-guess)))) 
  (try first-guess))

(define c 1000)

(define (f x) (/ (log c) (log x)))

(define (g x) (average (f x) x))

(fixed-point f 2.0)
(fixed-point g 2.0)
