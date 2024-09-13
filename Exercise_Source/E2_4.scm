(define (cons-alt x y) 
  (lambda (m) (m x y)))

(define (car-alt z) 
  (z (lambda (p q) p)))

(define (cdr-alt z) 
  (z (lambda (p q) q)))


(car-alt (cons-alt "sun" "moon"))
(cdr-alt (cons-alt "red" "blue"))
