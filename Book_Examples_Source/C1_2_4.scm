(define (is-even n) 
    (= (remainder n 2) 0))

(define (fast-expt b n) 
    (cond ((= n 0) 1) 
        ((is-even n) (square (fast-expt b (/ n 2)))) 
        (else (* b (fast-expt b (- n 1))))))

(fast-expt 2 8)
