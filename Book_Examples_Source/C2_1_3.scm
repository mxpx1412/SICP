(define (cons-alt x y) 
  (define (dispatch m) 
    (cond  
      ((= m 0) x) 
      ((= m 1) y) 
      (else (error "Argument not 0 or 1: CONS" m))))
  dispatch)

(define (car-alt z) (z 0))
(define (cdr-alt z) (z 1))

(define water (cons-alt "hydrogen" "oxygen"))
(car-alt water)
(cdr-alt water)

(car-alt (cons-alt "west" "east"))
(cdr-alt (cons-alt "north" "south"))
