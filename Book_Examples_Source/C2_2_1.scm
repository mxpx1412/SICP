(define one-through-four (cons 1 (cons 2 (cons 3 (cons 4 ())))))
(car one-through-four)
(car (cdr one-through-four))
(cons 0 one-through-four)
(define one-through-four (list 1 2 3 4))
(car one-through-four)
(car (cdr one-through-four))
(cons 0 one-through-four)

(define (list-ref items n) 
  (if 
    (= n 0) 
    (car items) 
    (list-ref (cdr items) (- n 1))))
(list-ref one-through-four 0)
(list-ref one-through-four 2)

(null? ())

(define (len-list-recursive items) 
  (if 
    (null? items) 
    0
    (+ 1 (len-list-recursive (cdr items)))))
(len-list-recursive one-through-four)

(define (len-list items) 
  (define (len-list-iter count iter-list) 
    (if (null? iter-list) count (len-list-iter (+ count 1) (cdr iter-list)))) 
  (len-list-iter 0 items))
(len-list one-through-four)
  
(define (append-list items-1 items-2) 
  (if 
    (null? items-1) 
    items-2 
    (cons (car items-1) (append-list (cdr items-1) items-2))))

(append-list one-through-four one-through-four)
