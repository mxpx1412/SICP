; Recursive evolving procedure to scale leaves
(define (scale-tree tree factor) 
  (cond 
    ((null? tree) ()) 
    ((pair? tree) 
      (cons 
        (scale-tree (car tree) factor) 
        (scale-tree (cdr tree) factor))) 
    (else (* tree factor))))

; Mapping over tree to scale leaves
(define (scale-tree-map tree factor) 
  (map 
    (lambda (sub-tree) 
      (if (pair? sub-tree) 
        (scale-tree sub-tree factor) 
        (* sub-tree factor))) 
    tree))

(define tree-example (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(scale-tree tree-example 10)
(scale-tree-map tree-example 10)
