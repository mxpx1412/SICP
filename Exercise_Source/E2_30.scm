(define (sqr-tree-recursive tree) 
  (cond 
    ((null? tree) ()) 
    ((pair? tree) 
      (cons 
        (sqr-tree-recursive (car tree)) 
        (sqr-tree-recursive (cdr tree)))) 
    (else (* tree tree))))

(define (sqr-tree-map tree) 
  (map 
    (lambda (sub-tree) 
      (if (pair? sub-tree) 
        (sqr-tree-map sub-tree) 
        (square sub-tree))) 
    tree))

(define (sqr-tree-r-map tree) 
  (if (pair? tree) 
    (map sqr-tree-r-map tree) 
    (square tree)))

(define num-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(sqr-tree-recursive num-tree)
(sqr-tree-map num-tree)
(sqr-tree-r-map num-tree)
