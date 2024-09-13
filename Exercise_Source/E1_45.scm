(define (average x y) (/ (+ x y) 2.0))

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

(define (compose f g) 
  (lambda (x) (f (g x))))

(define (repeated f n) 
  (define (rep-iter f_i i) 
    (if 
      (< i 2) 
      f_i 
      (rep-iter (compose f f_i) (- i 1))))
  (rep-iter f n))

(define (nth-root x n) 
  (fixed-point 
    ((repeated 
        average-damp 
        (floor (/ (log n) (log 2)))) 
      (lambda (y) (/ x (expt y (- n 1)))))
    1.0))

(nth-root 9 32)
(nth-root 256 8)
(nth-root 15640.31349 5)
