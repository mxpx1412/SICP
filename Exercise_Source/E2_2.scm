(define (make-point x y) 
  (cons x y))

(define (x-point pt) 
  (car pt))

(define (y-point pt) 
  (cdr pt))

(define (print-point pt) 
  (newline) 
  (display "(") 
  (display (x-point pt)) 
  (display ", ") 
  (display (y-point pt)) 
  (display ")"))

(define (make-segment start-pt end-pt) 
  (cons start-pt end-pt))

(define (start-segment line) 
  (car line))

(define (end-segment line) 
  (cdr line))

(define (average m n) (/ (+ m n) 2.0))

(define (midpoint-segment line) 
  (make-point 
    (average 
      (x-point (start-segment line))  
      (x-point (end-segment line))) 
    (average 
      (y-point (start-segment line))  
      (y-point (end-segment line)))))

(define u (make-point -1.2 7.4))
(define v (make-point 2.8 -3.2))
(define line-u-v (make-segment u v))
(print-point (midpoint-segment line-u-v))
