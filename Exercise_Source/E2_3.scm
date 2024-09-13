; LCL is "LCL: Common Library"
(load "LCL_math.scm")

(define (make-point x y) (cons x y))
(define (x-point pt) (car pt))
(define (y-point pt) (cdr pt))
(define (print-point pt) 
  (newline) 
  (display "(") 
  (display (x-point pt)) 
  (display ", ") 
  (display (y-point pt)) 
  (display ")"))

(define (make-segment start-pt end-pt) (cons start-pt end-pt)) 
(define (start-segment line) (car line))
(define (end-segment line) (cdr line))
(define (len-segment line) 
  (sqrt 
    (+ 
      (square 
        (- (x-point (end-segment line)) (x-point (start-segment line))))
      (square 
        (- (y-point (end-segment line)) (y-point (start-segment line)))))))
(define (add-vec v1 v2) 
  (make-point 
    (+ (x-point v1) (x-point v2)) 
    (+ (y-point v1) (y-point v2))))

(define (average m n) (/ (+ m n) 2.0))

(define (midpoint-segment line) 
  (make-point 
    (average 
      (x-point (start-segment line))  
      (x-point (end-segment line))) 
    (average 
      (y-point (start-segment line))  
      (y-point (end-segment line)))))


#|
Define rectangles by its diagonal segment, and the angle between the diagonal 
and the base (measured clockwise from the diagonal). 
|#
(define (make-rectang diagonal diag-angle) 
  (cons diagonal diag-angle))
(define (diagonal rectangle) (car rectangle))
(define (diag-angle rectangle) (cdr rectangle))
(define (base-len rectangle) 
  (* (len-segment (diagonal rectangle)) (cos (diag-angle rectangle)))) 
(define (height-len rectangle) 
  (* (len-segment (diagonal rectangle)) (sin (diag-angle rectangle)))) 
(define (area rectangle) 
  (* (base-len rectangle) (height-len rectangle)))
(define (perimeter rectangle) 
  (* 2.0 (+ (base-len rectangle) (height-len rectangle))))
; https://www.desmos.com/calculator/rnuglceswi

(define d 
  (make-segment 
    (make-point 1 1) 
    (make-point 5 4)))
(define a (radian 36.86989765))
(define R (make-rectang d a))

(degree (diag-angle R))
(area R)
(perimeter R)

#|
Define rectangles by its origin, rotation (base measured counterclockwise 
from the x-axis), and dimensions in base and height.
|#
(define (make-rectang position dims) (cons position dims))
; Constructor and selectors related to position:
(define (make-position origin rotation) (cons origin rotation)) 
(define (rectang-position rectangle) (car rectangle))
(define (origin rectangle) (car (rectang-position rectangle)))
(define (rotation rectangle) (cdr (rectang-position rectangle)))
; Constructor and selectors related to dimensions: 
(define (make-dims base-len height-len) (cons base-len height-len))
(define (rectang-dims rectangle) (cdr rectangle))
(define (base-len rectangle) (car (rectang-dims rectangle)))
(define (height-len rectangle) (cdr (rectang-dims rectangle)))
; Updated selectors for `diag-angle` and `diagonal`
(define (diag-angle rectangle) 
  (atan (height-len rectangle) (base-len rectangle)))
(define (diagonal rectangle) 
  (let 
    ((b (base-len rectangle)) 
      (h (height-len rectangle)) 
      (a (rotation rectangle)) 
      (x_0 (x-point (origin rectangle))) 
      (y_0 (y-point (origin rectangle)))) 
    (make-segment 
      (origin rectangle) 
      (make-point 
        (+ x_0 (- (* b (cos a)) (* h (sin a)))) 
        (+ y_0 (+ (* b (sin a)) (* h (cos a))))))))
; https://www.desmos.com/calculator/9brka5v52h

; Abstraction barriers allow same `area` and `perimeter` procedures to work:
(define R 
  (make-rectang 
    (make-position 
      (make-point 1 1) 
      (radian 30)) 
    (make-dims 4 3)))
(degree (diag-angle R))
(area R)
(perimeter R)
