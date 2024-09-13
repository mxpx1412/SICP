
; From book example: modified the incrementing of the divisor.
; Made additional improvements to try and achieve 50% time reduction.

(define (smallest-divisor n) 
    (cond 
        ((= (remainder n 2) 0) 2) 
        (else (find-divisor n 3))))

(define (find-divisor n test-divisor) 
  (cond 
    ((> (square test-divisor) n) n) 
    ((can-divide test-divisor n) test-divisor)
    (else (find-divisor n (+ test-divisor 2)))))

(define (can-divide a b) (= (remainder b a) 0))

(define (is-prime n) 
  (= n (smallest-divisor n)))

; From the exercise 1.21 problem statement:

(define (report-prime elapsed-time) 
  (display " => t = ") ; Modified slightly from text for clarity. 
  (display (* 1000000 elapsed-time)))

(define (start-prime-test n start-time) 
  (if (is-prime n) 
    (report-prime (- (runtime) start-time))))

(define (timed-prime-test n) 
  (newline) 
  (display n) 
  (start-prime-test n (runtime)))

; Student solution begins:

(define (consec-prime-test start-num primes-needed) 
  (define (cpt-iter iter-num primes-found) 
    (cond 
      ((< primes-found primes-needed) 
        (timed-prime-test iter-num) 
        (cpt-iter 
          (+ iter-num 
            (cond 
              ((or 
                (= iter-num 1) 
                (= iter-num 2)
                (= (remainder iter-num 2) 0)) 
                1) 
              (else 2))) 
          (if (is-prime iter-num) (+ primes-found 1) primes-found)))))
  (cpt-iter start-num 0))

(consec-prime-test 1000000000 3)
(consec-prime-test 10000000000 3)
(consec-prime-test 100000000000 3)
(consec-prime-test 1000000000000 3)
