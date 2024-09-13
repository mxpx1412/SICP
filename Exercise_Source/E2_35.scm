(define (accumulate combiner initial sequence) 
  (if (null? sequence) 
    initial 
    (combiner  
      (car sequence) 
      (accumulate combiner initial (cdr sequence)))))

(define (count-leaves t) 
  (accumulate 
    + 
    0 
    (map 
      (lambda (sub-t) 
        (if (pair? sub-t) (count-leaves sub-t) 1)) 
      t)))

(count-leaves ())

(define num-list (list 1 2 (list 3 (list 4 5) 6) 7 (list 8 (list 9))))
(count-leaves num-list)

