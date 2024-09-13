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

; Student defined (Exercise 2.8):
(define (sub-interval x y) 
  (make-interval 
    (- (lower-bound x) (upper-bound y)) 
    (- (upper-bound x) (lower-bound y))))

; Student defined width of an interval (Exercise 2.9):
(define (width-interval interval) 
  (/ (- (upper-bound interval) (lower-bound interval)) 2.0))

; Student modified interval division (Exercise 2.10):
(define (div-interval x y) 
  (if 
    (or 
      (< (upper-bound y) 0) 
      (> (lower-bound y) 0)) 
    (mul-interval 
      x
      (make-interval 
        (/ 1.0 (upper-bound y)) 
        (/ 1.0 (lower-bound y))))
    (error "Division undefined, denominator interval spans over 0.")))

(print-interval (div-interval (make-interval 1 2) (make-interval 0 2)))
(print-interval (div-interval (make-interval 1 2) (make-interval -2 0)))
(print-interval (div-interval (make-interval 1 2) (make-interval -2 2)))
(print-interval (div-interval (make-interval 1 2) (make-interval 0.1 2)))
(print-interval (div-interval (make-interval 1 2) (make-interval -2 -0.1)))
