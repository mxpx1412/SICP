(define (square x) (* x x))

(define (good-enough-cube guess x) 
  (> 0.00001 (abs (/ (- guess (improve-cube guess x)) guess))))

(define (improve-cube guess x) 
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (cube-iter guess x) 
  (if (good-enough-cube guess x) 
    guess 
    (cube-iter (improve-cube guess x) x)))

(define (cbrt x) 
  (cube-iter 1.0 x))

(cbrt 1000)

(* (cbrt 1000) (cbrt 1000) (cbrt 1000))
