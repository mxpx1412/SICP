; Searching for divisors

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor) 
    (cond 
        ((> (square test-divisor) n) n) 
        ((can-divide test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (can-divide a b) (= (remainder b a) 0))

(define (is-prime n) 
    (= n (smallest-divisor n)))
