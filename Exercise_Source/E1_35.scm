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

(define (f x) (+ 1.0 (/ 1.0 x)))

(fixed-point f 1.0)
