; Representing rationals
(define 
  (make-rat n d) 
  (let 
    ((divisor (gcd n d))) 
    (cons (/ n divisor) (/ d divisor))))
(define (numer x) (car x))
(define (denom x) (cdr x))

; Printing a rational
(define (print-rat x) 
  (newline) 
  (display (numer x))
  (display "/")
  (display (denom x)))

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

; Test calculations:
(define x (make-rat 1 2))
(numer x)
(denom x)
(define y (make-rat 3 4))
(print-rat (add-rat x y))
(print-rat (sub-rat x y))
(print-rat (mul-rat x y))
(print-rat (div-rat x y))
(equal-rat x y)
(equal-rat x (make-rat 2 4))
