(define (make-rat n d) (cons n d))

; Reduce rationals in selectors instead of constructor:
(define (numer x) 
  (let 
    ((divisor (gcd (car x) (cdr x)))) 
    (/ (car x) divisor)))
(define (denom x) 
  (let 
    ((divisor (gcd (car x) (cdr x)))) 
    (/ (cdr x) divisor)))
