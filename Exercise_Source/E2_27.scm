(define (deep-reverse items) 
  (define (d-r-iter iter-return iter-items) 
    (if (null? iter-items) 
      iter-return 
      (let 
        ((next-item (car iter-items))) 
        (d-r-iter 
          (cons 
            (if (pair? next-item) 
              (d-r-iter () next-item) 
              next-item) 
            iter-return) 
          (cdr iter-items))))) 
  (d-r-iter () items))

(define x (list 1 2 (list 3 4)))
(deep-reverse x)

(define x (list (list 1 2) (list 3 4)))
(deep-reverse x)

(define x (list (list (list 1 2) 3 4) 5 6 (list 7 (list 8 9))))
(deep-reverse x)
