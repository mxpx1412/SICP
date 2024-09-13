(define (scale-list items factor) 
  (if (null? items) 
    () 
    (cons 
      (* (car items) factor) 
        (scale-list (cdr items) factor))))

(define num-list (list 0 1 2 3 4))
(scale-list num-list 2)

(define (map proc items) 
  (if (null? items) 
    () 
    (cons (proc (car items)) (map proc (cdr items)))))

(define (scale-list items factor) 
  (map (lambda (x) (* factor x)) items))

(scale-list num-list 2)
