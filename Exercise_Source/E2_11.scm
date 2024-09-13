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

; Student modified interval multiplication (Exercise 2.11):
(define (mul-interval x y) 
  (let 
    ((u-x (upper-bound x)) 
    (l-x (lower-bound x)) 
    (u-y (upper-bound y)) 
    (l-y (lower-bound y))) 
    (if (> u-x 0) 
      (if (> l-x 0) 
        (if (> u-y 0) 
          (if (> l-y 0) 
            (make-interval (* l-x l-y) (* u-x u-y)) 
            (make-interval (* u-x l-y) (* u-x u-y)))
          (make-interval (* u-x l-y) (* l-x u-y)))
        (if (> u-y 0)
          (if (> l-y 0) 
            (make-interval (* l-x u-y) (* u-x u-y)) 
            (make-interval 
              (min (* u-x l-y) (* l-x u-y)) 
              (max (* u-x u-y) (* l-x l-y))))
          (make-interval (* u-x l-y) (* l-x l-y))))
      (if (> u-y 0)
        (if (> l-y 0) 
          (make-interval (* l-x u-y) (* u-x l-y))
          (make-interval (* l-x u-y) (* l-x l-y)))
        (make-interval (* u-x u-y) (* l-x l-y))))))

(print-interval (mul-interval (make-interval 2 3) (make-interval 4 5)))
(print-interval (mul-interval (make-interval 2 3) (make-interval -5 4)))
(print-interval (mul-interval (make-interval 2 3) (make-interval -5 -4)))
(print-interval (mul-interval (make-interval -3 2) (make-interval 4 5)))
(print-interval (mul-interval (make-interval -3 2) (make-interval -5 4)))
(print-interval (mul-interval (make-interval -3 2) (make-interval -5 -4)))
(print-interval (mul-interval (make-interval -3 -2) (make-interval 4 5)))
(print-interval (mul-interval (make-interval -3 -2) (make-interval -5 4)))
(print-interval (mul-interval (make-interval -3 -2) (make-interval -5 -4)))
