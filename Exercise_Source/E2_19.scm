; Exercise 2.18 iterative process
(define (reversed items) 
  (define (iter-reverse iter-items iter-result) 
    (if 
      (null? iter-items) 
      iter-result 
      (iter-reverse 
        (cdr iter-items) 
        (append (list (car iter-items)) iter-result)))) 
  (iter-reverse items ()))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (first-denom coin-values) 
  (car coin-values))

(define (except-first-denom coin-values) 
  (cdr coin-values))

(define (no-more coin-values) (null? coin-values))

(define (cc amount coin-values) 
  (cond 
    ((= amount 0) 1) 
      ((or (< amount 0) (no-more coin-values)) 0) 
      (else 
        (+ 
          (cc 
            amount 
            (except-first-denom coin-values)) 
          (cc 
            (- amount (first-denom coin-values)) 
            coin-values)))))

(cc 4 us-coins)
(cc 11 us-coins)
(cc 4 uk-coins)
(cc 11 uk-coins)

(define us-coins (reversed us-coins))
us-coins
(define uk-coins (reversed uk-coins))
uk-coins

(cc 4 us-coins)
(cc 11 us-coins)
(cc 4 uk-coins)
(cc 11 uk-coins)

(define us-coins (list 25 50 1 5 10))
us-coins
(define uk-coins (list 1 0.5 10 20 5 2 100 50))
uk-coins

(cc 4 us-coins)
(cc 11 us-coins)
(cc 4 uk-coins)
(cc 11 uk-coins)
