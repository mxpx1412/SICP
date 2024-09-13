(define (tree-map proc tree) 
  (define (tree-map-iter tree) 
    (if (pair? tree) 
      (map tree-map-iter tree) 
      (proc tree)))
  (tree-map-iter tree))

(define (sqr-tree tree) (tree-map square tree))

(define num-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(sqr-tree num-tree)
