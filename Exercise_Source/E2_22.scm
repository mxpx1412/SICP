; Louis Reasoner's first procedure

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
        (cons (square (car things))
          answer))))
  (iter items ()))

(square-list (list 1 2 3 4))

; Louis Reasoner's second procedure
 
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
        (cons answer
          (square (car things))))))
  (iter items ()))

(square-list (list 1 2 3 4))
