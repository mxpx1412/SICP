; From textbook

(define (is-even n) (= 0 (remainder n 2)))
; (define (is-one num) (if (= num 1) 0 num))

(define (expmod-mr base expnt m) 
  (define (squaremod num) 
    (define num-squared-mod (remainder (square num) m))
    (cond 
      ((and 
        (= num-squared-mod 1) 
        (not (= num-squared-mod (- m 1))) 
        (not (= num-squared-mod 1)))
        0) 
      (else num-squared-mod)))
  (cond 
    ((= expnt 0) 1) 
    ((is-even expnt) 
      (squaremod (expmod-mr base (/ expnt 2) m)))
    (else 
      (remainder 
        (* base (expmod-mr base (- expnt 1) m))
        m))))

; Modified from student solution to Exercise 1.27

(define (miller-rabin-all n) 
  (define (miller-rabin-trial a) 
    (cond 
      ((= a n) #t) 
      ((= (expmod-mr a (- n 1) n) 1) 
            (miller-rabin-trial (+ a 1)))
      (else #f))) 
  (miller-rabin-trial 1))

(define (miller-rabin-loop start-num end-num) 
  (cond 
    ((> start-num end-num) (newline) (display "Test complete."))
    (else 
      (newline)
      (display start-num)
      (display ", ")
      (display (miller-rabin-all start-num))
      (display ", ")
      (miller-rabin-loop (+ start-num 1) end-num))))

; To test if program correct:
(miller-rabin-loop 1 6601)
