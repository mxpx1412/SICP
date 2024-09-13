(define (count-divisions n divisor) 
  (define (iter-div iter-n count) 
    (if 
      (= (remainder iter-n divisor) 0) 
      (iter-div (/ iter-n divisor) (+ count 1)) 
      count)) 
  (iter-div n 0))

(define (cons-int a b) 
  (* (expt 2 a) (expt 3 b)))

(define (car-int c) (count-divisions c 2))

(define (cdr-int c) (count-divisions c 3))

(define z (cons-int 2 3))
(car-int z)
(cdr-int z)

(define z (cons-int 4 9))
(car-int z)
(cdr-int z)

(define z (cons-int 1 11))
(car-int z)
(cdr-int z)

(define z (cons-int 8 0))
(car-int z)
(cdr-int z)
