; From book examples: 

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

(define (deriv g dx) 
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define dx 0.00001)

(define (newton-transform g) 
  (lambda (x) (- x (/ (g x) ((deriv g dx) x)))))

(define (newton-method f first-guess) 
  (fixed-point (newton-transform f) first-guess))

; Student solution to Exercise 1.40

(define (cube x) (* x x x))

(define (cubic a b c) 
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

; Solve \(0 = x^3 - 2x^2 - 9x + 18
; Known results: -3, 2, 3

(newton-method (cubic -2 -9 18) -4.0)
(newton-method (cubic -2 -9 18) 1.0)
(newton-method (cubic -2 -9 18) 4.0)
