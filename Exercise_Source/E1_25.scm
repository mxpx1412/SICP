; Original `expmod` from the text.
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

; Original `fast-expt` from the text.
(define (is-even n) 
    (= (remainder n 2) 0))

(define (fast-expt b n) 
    (cond ((= n 0) 1) 
        ((is-even n) (square (fast-expt b (/ n 2)))) 
        (else (* b (fast-expt b (- n 1))))))

; Alyssa P. Hacker's suggested `expmod`, renamed `expmod-new`.

(define (expmod-new base expnt m) 
    (remainder (fast-expt base expnt) m))

; Procedure to test process time.

(define (time-test init-runtime to-compute) 
    (define time-elapsed (- (runtime) init-runtime)) 
    (newline) 
    (display "Time elapsed: ")
    (display time-elapsed) 
    to-compute)

; Time tests:
(define init-runtime (runtime))
(time-test init-runtime (expmod 1000 1000003 1000003))

(define init-runtime (runtime))
(time-test init-runtime (expmod-new 1000 1000003 1000003))
