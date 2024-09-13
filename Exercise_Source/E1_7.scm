(define (average m n) 
  (/ (+ m n) 2))

(define (improve-sqrt guess x) 
  (average guess (/ x guess)))

(define (good-enough-sqrt guess x) 
  (> 0.000001 (abs (/ (- guess (improve-sqrt guess x)) guess))))

(define (sqrt-iter guess x) 
  (if (good-enough-sqrt guess x) 
    guess 
    (sqrt-iter (improve-sqrt guess x) x)))

(define (sqrt x) 
  (sqrt-iter 1.0 x))

(define test_num 99999999999999999999)

(sqrt test_num)

(square (sqrt test_num))
