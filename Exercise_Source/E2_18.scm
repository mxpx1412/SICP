(define one-through-four (list 1 2 3 4))

; Exercise 2.18 recursive process
(define (reversed-recursive items) 
  (define (iter-reverse iter-items) 
    (if 
      (null? (cdr iter-items)) 
      (list (car iter-items)) 
      (append 
        (iter-reverse (cdr iter-items)) 
        (list (car iter-items))))) 
  (iter-reverse items))
(reversed-recursive one-through-four)
(reversed-recursive (list 1))
(reversed-recursive (list 1 (list 2 3)))

; Exercise 2.18 iterative process
(define (reversed items) 
  (define (iter-reverse iter-items iter-result) 
    (if 
      (null? iter-items) 
      iter-result 
      (iter-reverse 
        (cdr iter-items) 
        (append (list (car iter-items)) iter-result)))) 
  (iter-reverse items ()))
(reversed one-through-four)
(reversed (list 1))
(reversed (list 1 (list 2 3)))
