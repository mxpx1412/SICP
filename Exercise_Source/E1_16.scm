(define (is-even x) 
    (= (remainder x 2) 0))

(define (f-expt-iter a b n) 
    (cond 
        ((= n 0) a) 
        ((is-even n) (f-expt-iter a (* b b) (/ n 2))) 
        (else (f-expt-iter (* a b) b (- n 1)))))

(define (fast-expt-iter b n) 
    (f-expt-iter 1 b n))

(fast-expt-iter 2 1)

(fast-expt-iter 2 4)

(fast-expt-iter 2 5)

(fast-expt-iter 3 1)

(fast-expt-iter 3 3)

(fast-expt-iter 3 4)

