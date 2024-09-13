; Copied and modified based on Exercise 1.22
; From book example:

(define (is-even n) (= 0 (remainder n 2)))

(define (expmod base expnt m) 
  (cond 
    ((= expnt 0) 1) 
    ((is-even expnt) 
      (remainder 
        (square (expmod base (/ expnt 2) m)) 
        m))
    (else 
      (remainder 
        (* base (expmod base (- expnt 1) m))
        m))))

(define (fermat-test n) 
  (define (fermat-trial a) 
    (= (expmod a n n) a))
  (fermat-trial (+ 1 (random (- n 1)))))

(define (fast-prime-fermat n times) 
  (cond 
    ((= times 0) true)
    ((fermat-test n) (fast-prime-fermat n (- times 1)))
    (else false)))

(define fermat-test-amount 500)

; From the exercise 1.21 problem statement:

(define (report-prime elapsed-time) 
  (display " => t = ") ; Modified slightly from text for clarity. 
  (display (* 1000000 elapsed-time)))

(define (start-prime-test n start-time) 
  (if (fast-prime-fermat n fermat-test-amount) 
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
          (if (fast-prime-fermat iter-num fermat-test-amount) (+ primes-found 1) primes-found)))))
  (cpt-iter start-num 0))

(consec-prime-test 1000000000 3)
(consec-prime-test 10000000000 3)
(consec-prime-test 100000000000 3)
(consec-prime-test 1000000000000 3)
