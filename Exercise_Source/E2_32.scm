(define (subsets s) 
  (if (null? s) 
    (list ()) 
    (let 
      ((rest (subsets (cdr s))) 
        (1st-elem (car s))) ; added line
      (append 
        rest 
        (map 
          (lambda (sub-s) (cons 1st-elem sub-s)) 
          rest)))))

(subsets '(1 2 3))
(subsets '(1 2 3 4))
