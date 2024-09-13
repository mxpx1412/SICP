(define (fringe tree) 
  (define (fringe-iter iter-return iter-tree) 
    (if (null? iter-tree) 
      iter-return 
      (let 
        ((next-item (car iter-tree))) 
        (fringe-iter 
          (if (pair? next-item) 
            (fringe-iter iter-return next-item) 
            (cons next-item iter-return)) 
          (cdr iter-tree)))))
  (reverse (fringe-iter () tree)))

(define x (list (list 1 2) (list 3 4)))
x
(define y (list (list 1 2 (list 3 4 5)) (list 6 (list 7 8) 9 (list 10 11) 12)))
y

(fringe x)
(fringe (list x x))
(fringe y)
(fringe (list y (list x y)))
