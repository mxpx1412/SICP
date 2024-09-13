; From textbook

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

; Student solution to Exercise 1.27

(define (fermat-test-all n) 
    (define (fermat-trial a) 
        (cond 
            ((= a n) #t) 
            ((= (expmod a n n) a) (fermat-trial (+ a 1)))
            (else #f))) 
    (fermat-trial 1))

(fermat-test-all 561)
(fermat-test-all 1105)
(fermat-test-all 1729)
(fermat-test-all 2465)
(fermat-test-all 2821)
(fermat-test-all 6601)

#|
; To test if program correct for "normal" numbers:
(fermat-test-all 1)
(fermat-test-all 2)
(fermat-test-all 3)
(fermat-test-all 4)
(fermat-test-all 5)
(fermat-test-all 6)
(fermat-test-all 7)
(fermat-test-all 8)
(fermat-test-all 9)
(fermat-test-all 10)
|#

