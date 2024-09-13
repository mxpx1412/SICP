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

(define (fixed-point-of-transform g transform guess) 
  (fixed-point (transform g) guess))

; Square root by transforming with average damping into fixed-point problem
(define (sq-root x) 
  (fixed-point-of-transform 
    (lambda (y) (/ x y)) 
    average-damp 
    1.0))

(sq-root 0)
(sq-root 1)
(sq-root 2)
(sq-root 3)
(sq-root 4)
(sq-root 5)

; Square root by transforming with Newton's method into fixed-point problem 
(define (deriv g dx) 
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define dx 0.00001)

(define (newton-transform g) 
  (lambda (x) (- x (/ (g x) ((deriv g dx) x)))))

(define (newton-method f first-guess) 
  (fixed-point (newton-transform f) first-guess))

(define (sq-root x) 
  (fixed-point-of-transform 
    (lambda (y) (- (square y) x)) 
    newton-transform 
    1.0))

(sq-root 0)
(sq-root 1)
(sq-root 2)
(sq-root 3)
(sq-root 4)
(sq-root 5)
