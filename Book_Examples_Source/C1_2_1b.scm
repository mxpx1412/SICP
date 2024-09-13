(define (fact-iter product counter max-count) 
  (if (> max-count counter) 
    product 
    (fact-iter (* counter product) 
	       (+ counter 1) 
	       max-count)))

(define (factorial n) 
  (fact-iter 1 1 n))

