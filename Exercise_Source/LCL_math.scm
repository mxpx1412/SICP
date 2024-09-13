
; Iterative process accumulator
(define (accumulate combiner null-value acc-term a next-term b) 
  (define (acc-iter iter-a iter-result) 
    (if 
      (> iter-a b) 
      iter-result 
      (acc-iter (next-term iter-a) (combiner (acc-term iter-a) iter-result)))) 
  (acc-iter a null-value))

(define (sum sum-term a next-term b) 
  (accumulate + 0 sum-term a next-term b))

(define (product prod-term a next-term b) 
  (accumulate * 1 prod-term a next-term b))

; Parity 
(define (is-even n) (= (remainder n 2) 0))

; Trigonometry
(define pi 3.141592653589793)
(define (radian degree) (* degree (/ pi 180)))
(define (degree radian) (* radian (/ 180 pi)))
