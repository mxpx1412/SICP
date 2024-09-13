(define (is-even m) 
    (= (remainder m 2) 0))

(define (f-fib-iter a b p q count)
    (cond 
        ((= 0 count) b)
        ((is-even count)
            (f-fib-iter 
                a
                b
                (+ (* p p) (* q q))
                (+ (* 2 p q) (* q q))
                (/ count 2)))
        (else 
            (f-fib-iter 
                (+ (* b q) (* a p) (* a q)) 
                (+ (* b p) (* a q))
                p
                q
                (- count 1)))))

(define (fast-fib n) 
    (f-fib-iter 1 0 0 1 n))
