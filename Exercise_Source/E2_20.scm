
(define (same-parity 1st-int . int-list) 
  (define par-check (if (even? 1st-int) even? odd?)) 
  (define (par-iter iter-list iter-result) 
    (if (null? iter-list) iter-result 
      (let 
        ((iter-num (car iter-list))) 
        (par-iter 
          (cdr iter-list) 
          (if 
            (par-check iter-num) 
            (cons iter-num iter-result) 
            iter-result))))) 
  (reverse (par-iter int-list (list 1st-int))))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7 8)
(same-parity 1)
(same-parity 1 2)
(same-parity 17 51 2 44 34 99)
