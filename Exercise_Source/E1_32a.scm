; Iterative process version: 
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

(define (inc x) (+ x 1))
(sum square 1 inc 3)
(product square 1 inc 3)
