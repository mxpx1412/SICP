(define (compose f g) 
  (lambda (x) (f (g x))))

(define (repeated f n) 
  (define (rep-iter f_i i) 
    (if 
      (< i 2) 
      f_i 
      (rep-iter (compose f f_i) (- i 1))))
  (rep-iter f n))

(define (smoothed f) 
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3.0)))

(define (n-smoothed f n) 
  ((repeated smoothed n) f))

(define dx 1.0)
((smoothed square) 0)
((n-smoothed square 2) 0)
