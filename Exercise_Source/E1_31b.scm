; Recursive process version of `product`

(define (product prod-term a next-term b) 
  (if 
    (> a b) 
    1 
    (* (prod-term a) (product prod-term (next-term a) next-term b)))) 

(define (john-wallis-pi n-terms) 
  (define (inc-JW-pi i) (+ i 2))
  (define (JW-pi-term i) 
    (/ (* (- i 1) (+ i 1)) (square i))) 
  (product JW-pi-term 3. inc-JW-pi n-terms))

(* 4 (john-wallis-pi 1000))
