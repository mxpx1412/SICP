; From iterative process version of `accumulate`: 

(define (filtered-accumulate combiner null-value acc-term a next-term b filter) 
  (define (acc-iter iter-a iter-result) 
    (cond 
      ((> iter-a b) iter-result) 
      (else 
        (acc-iter 
          (next-term iter-a) 
          (if 
            (filter iter-a) 
            (combiner (acc-term iter-a) iter-result) 
            iter-result)))))
  (acc-iter a null-value))

; Prime testing using Miller-Rabin, modified from Exercise 1.28

(define (is-even n) (= 0 (remainder n 2)))

(define (miller-rabin-test a n) 
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
  (= (expmod-mr a (- n 1) n) 1))

(define (miller-rabin-iter n times)
  (define iter-a (+ (random (- n 1)) 1)) 
  (cond 
    ((= 0 times) #t) 
    ((miller-rabin-test iter-a n) 
      (miller-rabin-iter n (- times 1))) 
    (else #f)))

(define (is-prime n) (if (= n 1) #t (miller-rabin-iter n 100))) 

; Relatively prime testing:

(define (is-rel-prime m n) 
  (= (gcd m n) 1))

; Answering exercise 1.33 prompts:
; 1.33.a
(define (filtered-sum sum-term a next-term b filter) 
  (filtered-accumulate + 0 sum-term a next-term b filter))

(define (identity x) x)
(define (inc x) (+ x 1))

(filtered-sum identity 1 inc 5 is-prime)
(filtered-sum square 1 inc 5 is-prime)

; 1.33.b
(define (filtered-product prod-term a next-term b filter) 
  (filtered-accumulate * 1 prod-term a next-term b filter))

(define (prod-n-rel-prime n) 
  (define (rel-prime-to-n i) (is-rel-prime i n)) 
  (filtered-product identity 1 inc (- n 1) rel-prime-to-n))

(prod-n-rel-prime 5)
(prod-n-rel-prime 6)
