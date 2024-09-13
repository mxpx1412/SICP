; Iteratively evolving `sum`
(define (sum sum-term a next-term b) 
  (define (sum-iter iter-a iter-result) 
    (if 
      (> iter-a b) 
      iter-result 
      (sum-iter (next-term iter-a) (+ iter-result (sum-term iter-a)))))
  (sum-iter a 0))
  
; Testing with integration from previous exercise.

(define (cube x) (* x x x))

(define (is-even x) (= (remainder x 2) 0))

; Computing definite integrals

(define (integral-mid-pt f a b dx) 
  (define (inc-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) inc-dx b) dx))

(define (integral-simpson f a b n) 
  (define dx (/ (- b a) n)) 
  (define (inc i) (+ i 1)) 
  (define (simpson-coeff i) 
    (cond 
      ((or (= i 0) (= i n)) 1) 
      ((is-even i) 2) 
      (else 4)))
  (define (simpson-term i) 
    (* (simpson-coeff i) (f (+ a (* i dx)))))
  (* 
    (/ dx 3.0) 
    (sum simpson-term 0 inc n))) 

; Known analytical result: 0.25 (asked by problem prompt)
(integral-mid-pt cube 0 1 (/ (- 1 0) 100))
(integral-mid-pt cube 0 1 (/ (- 1 0) 1000))
(integral-simpson cube 0 1 100)
(integral-simpson cube 0 1 1000)

; Known analytical result: 9
(integral-mid-pt square 0 3 (/ (- 3 0) 100))
(integral-mid-pt square 0 3 (/ (- 3 0) 1000))
(integral-simpson square 0 3 100)
(integral-simpson square 0 3 1000)

; Known analytical result: 41.333...
(integral-mid-pt square 1 5 (/ (- 5 1) 100))
(integral-mid-pt square 1 5 (/ (- 5 1) 1000))
(integral-simpson square 1 5 100)
(integral-simpson square 1 5 1000)

