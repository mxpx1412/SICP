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

; Above `expmod` procedure similar to previous `fast-exp` book example.
; Writing a few example evaluations for above procedure to gain understanding:

#|

(expmod 3 2 2)
(remainder (square (expmod 3 1 2)) 2)
(remainder (square (remainder (* 3 (expmod 3 (- 1 1) 2)) 2)) 2)
(remainder (square (remainder (* 3 (expmod 3 0 2)) 2)) 2)
(remainder (square (remainder (* 3 1) 2)) 2)
(remainder (square (remainder 3 2)) 2)
(remainder (square 1) 2)
(remainder 1 2)
1

(expmod 4 2 2)
(remainder (square (expmod 4 (/ 2 2) 2)) 2)
(remainder (square (expmod 4 1 2)) 2)
(remainder (square (remainder (* 4 (expmod 4 (- 1 1) 2)) 2)) 2)
(remainder (square (remainder (* 4 (expmod 4 0 2)) 2)) 2)
(remainder (square (remainder (* 4 1) 2)) 2)
(remainder (square (remainder 4 2)) 2)
(remainder (square 0) 2)
(remainder 0 2)
0

(expmod 5 3 2)
(remainder (* base (expmod base (- expnt 1) marg)) marg)
(remainder (* 5 (expmod 5 (- 3 1) 2)) 2)
(remainder (* 5 (expmod 5 2 2)) 2)
(remainder (* 5 (remainder (square (expmod 5 (/ 2 2) 2)) 2)) 2)
(remainder (* 5 (remainder (square (expmod 5 1 2)) 2)) 2)
(remainder (* 5 (remainder (square (expmod 5 1 2)) 2)) 2)
(remainder (* 5 (remainder (square (remainder (* 5 (expmod 5 (- 1 1) 2)) 2)) 2)) 2)
(remainder (* 5 (remainder (square (remainder (* 5 (expmod 5 0 2)) 2)) 2)) 2)
(remainder (* 5 (remainder (square (remainder (* 5 1) 2)) 2)) 2)
(remainder (* 5 (remainder (square (remainder 5 2)) 2)) 2)
(remainder (* 5 (remainder (square 1) 2)) 2)
(remainder (* 5 (remainder 1 2)) 2)
(remainder (* 5 1) 2)
(remainder 5 2)
1

|#

