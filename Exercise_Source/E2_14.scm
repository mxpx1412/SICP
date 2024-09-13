; From text: 
(define (make-interval a b) (cons a b))

; From text (Exercise 2.12):
(define (make-center-width c w) 
  (make-interval (- c w) (+ c w)))

(define (center i) 
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i) 
  (/ (- (upper-bound i) (lower-bound i)) 2))

; Student defined (Exercise 2.12):
(define (make-center-percent c p) 
  (make-center-width c (abs (* c (/ p 100)))))

(define (percent i) 
  (* 100 (/ (width i) (abs (center i)))))

; Student defined (Exercise 2.7) then modified:
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (print-interval interval) 
  (newline) 
  (display "(")
  (display (lower-bound interval))
  (display ", ")
  (display (upper-bound interval))
  (display ")"))

; Student defined (Exercise 2.14) to print in centre-tolerance form
(define (print-interval-ct interval) 
  (newline) 
  (display (center interval))
  (display " +- ")
  (display (percent interval))
  (display "%"))

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
; (define (width-interval interval) 
;  (/ (- (upper-bound interval) (lower-bound interval)) 2.0))

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

; From text (Lem E. Tweakit parallel resistance procedures):
(define (par1 r1 r2) 
  (div-interval 
    (mul-interval r1 r2) 
    (add-interval r1 r2)))

(define (par2 r1 r2) 
  (let 
    ((one (make-interval 1 1))) 
      (div-interval 
        one 
        (add-interval 
          (div-interval one r1) 
          (div-interval one r2)))))

(define A (make-center-percent 365 4))
(define B (make-center-percent 1867 5))
(print-interval-ct (div-interval A A))
(print-interval-ct (div-interval A B))
(print-interval-ct (par1 A B))
(print-interval-ct (par2 A B))
