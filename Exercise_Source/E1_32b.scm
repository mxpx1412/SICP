; Recursive process version: 
(define (accumulate combiner null-value acc-term a next-term b) 
  (if 
    (> a b) 
    null-value 
    (combiner (acc-term a) (accumulate combiner null-value acc-term (next-term a) next-term b))))

(define (sum sum-term a next-term b) 
  (accumulate + 0 sum-term a next-term b))

(define (product prod-term a next-term b) 
  (accumulate * 1 prod-term a next-term b))

(define (inc x) (+ x 1))
(sum square 1 inc 3)
(product square 1 inc 3)
