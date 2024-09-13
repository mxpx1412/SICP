; Representing rationals
(define 
  (make-rat n d) 
  (let 
    ((divisor ((if (< d 0) - abs) (gcd n d)))) 
    (cons 
      (/ n divisor) 
      (/ d divisor))))
(define (numer x) (car x))
(define (denom x) (cdr x))

; Printing a rational
(define (print-rat x) 
  (newline) 
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat 4 20))
(print-rat (make-rat -4 -20))
(print-rat (make-rat -4 20))
(print-rat (make-rat 4 -20))

; Operations on rationals:
(define (add-rat x y) 
  (make-rat 
    (+ (* (numer x) (denom y)) (* (numer y) (denom x))) 
    (* (denom x) (denom y))))
(define (sub-rat x y) 
  (make-rat 
    (- (* (numer x) (denom y)) (* (numer y) (denom x))) 
    (* (denom x) (denom y))))
(define (mul-rat x y) 
  (make-rat 
    (* (numer x) (numer y)) 
    (* (denom x) (denom y))))
(define (div-rat x y) 
  (make-rat 
    (* (numer x) (denom y)) 
    (* (denom x) (numer y))))
(define (equal-rat x y) 
  (= 
    (* (numer x) (denom y)) 
    (* (numer y) (denom x))))
