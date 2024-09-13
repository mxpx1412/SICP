(define (for-each-item proc items) 
  (if 
    (null? items) 
    #t 
    (let 
      ((run (proc (car items)))) 
      (for-each-item proc (cdr items)))))

(for-each-item 
  (lambda (x) (newline) (display x)) 
  (list 1 2 3 4))
