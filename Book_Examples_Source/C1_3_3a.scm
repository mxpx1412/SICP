(define (average x y) (/ (+ x y) 2.0))

(define (close-enough x y) (< (abs (- x y)) 0.0001))

(define (search-root f neg-point pos-point) 
  (let ((midpoint (average neg-point pos-point))) 
  (if 
    (close-enough neg-point pos-point) 
    midpoint 
    (let ((test-value (f midpoint))) 
      (cond 
        ((> test-value 0) (search-root f neg-point midpoint)) 
        ((< test-value 0) (search-root f midpoint pos-point)) 
        (else midpoint))))))

(define (half-interval-method f a b) 
  (let 
    ((a-val (f a)) (b-val (f b))) 
    (cond 
      ((and (negative? a-val) (positive? b-val)) 
        (search-root f a b)) 
      ((and (negative? b-val) (positive? a-val)) 
        (search-root f b a)) 
      (else 
        (error "Values are not of opposite sign!" a b)))))

(half-interval-method sin 2.0 4.0)

(define (cube x) (* x x x))
(half-interval-method (lambda (x) (- (cube x) (* 2 x) 3)) 1.0 2.0)
