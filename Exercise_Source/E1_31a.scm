; Iterative process version of `product`

(define (product prod-term a next-term b) 
  (define (prod-iter iter-a iter-result) 
    (if 
      (> iter-a b) 
      iter-result 
      (prod-iter (next-term iter-a) (* (prod-term iter-a) iter-result))))
  (prod-iter a 1))

(define (john-wallis-pi n-terms) 
  (define (inc-JW-pi i) (+ i 2))
  (define (JW-pi-term i) 
    (/ (* (- i 1) (+ i 1)) (square i))) 
  (product JW-pi-term 3. inc-JW-pi n-terms))

(* 4 (john-wallis-pi 1000))
