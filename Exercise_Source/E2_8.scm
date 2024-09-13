; From text:
(define (make-interval a b) (cons a b))

; Student defined (Exercise 2.7):
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (print-interval interval) 
  (newline) 
  (display "(")
  (display (lower-bound interval))
  (display ", ")
  (display (upper-bound interval))
  (display ")"))

; From text (Alyssa P. Hacker's procedures):
(define (add-interval x y) 
  (make-interval 
    (+ (lower-bound x) (lower-bound y)) 
    (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y) 
  (let 
    ((p1 (* (lower-bound x) (lower-bound y))) 
    (p2 (* (lower-bound x) (upper-bound y))) 
    (p3 (* (upper-bound x) (lower-bound y))) 
    (p4 (* (upper-bound x) (upper-bound y)))) 
    (make-interval 
      (min p1 p2 p3 p4) 
      (max p1 p2 p3 p4))))

(define (div-interval x y) 
  (mul-interval 
    x
    (make-interval 
      (/ 1.0 (upper-bound y)) 
      (/ 1.0 (lower-bound y)))))

; Student defined (Exercise 2.8):
(define (sub-interval x y) 
  (make-interval 
    (- (lower-bound x) (upper-bound y)) 
    (- (upper-bound x) (lower-bound y))))

; Testing
(define X (make-interval 1 2))
(define Y (make-interval -1 3))
(print-interval (sub-interval X Y))
