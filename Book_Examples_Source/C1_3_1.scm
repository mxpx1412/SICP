(define (sum-integers a b) 
  (if (> a b) 0 (+ a (sum-integers (+ a 1) b))))

(define (sum-cubes a b) 
  (if (> a b) 0 (+ (cube a) (sum-cubes (+ a 1) b))))

(define (pi-sum a b) 
  (if (> a b) 0 (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

#|
; General pattern:

(define (<name> a b) 
  (if (> a b) 0 (+ (<term> a) (<name> (<next> a) b)))) 
|#

(define (sum sum-term a next-term b) 
  (if 
    (> a b) 
    0 
    (+ 
      (sum-term a) 
      (sum sum-term (next-term a) next-term b))))

; Passing arguments to `sum` to get `sum-cubes`.

(define (cube x) (* x x x))
(define (inc x) (+ x 1))

(define (sum-cubes-new a b) 
  (sum cube a inc b))

(sum-cubes 1 3)
(sum-cubes-new 1 3)

; Passing arguments to `sum` to get `sum-integers`.

(define (identity x) x)

(define (sum-integers-new a b) 
  (sum identity a inc b))

(sum-integers 1 3)
(sum-integers-new 1 3)

; Passing arguments to `sum` to get `pi-sum`.

(define (pi-sum-term n) (/ 1.0 (* n (+ n 2))))

(define (inc-4 x) (+ x 4))

(define (pi-sum-new a b) 
  (sum pi-sum-term a inc-4 b))

(* 8 (pi-sum 1 9000))
(* 8 (pi-sum-new 1 9000))

; Computing definite integrals

(define (integral f a b dx) 
  (define (inc-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) inc-dx b) dx))

(integral square 0 3 0.1)
(integral square 0 3 0.001)
(/ (cube 3) 3.0)
