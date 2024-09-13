(define (count-leaves tree) 
  (cond 
    ((null? tree) 0) 
    ((not (pair? tree)) 1) 
    (else 
      (+ 
        (count-leaves (car tree)) 
        (count-leaves (cdr tree))))))

(define x (cons (list 1 2) (list 3 4)))
(define y (list x x))

(length x)
(length y)
(count-leaves x)
(count-leaves y)
