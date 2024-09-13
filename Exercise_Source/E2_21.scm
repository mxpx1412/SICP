; Text prompt:
#|
(define (square-list items)
(if (null? items)
nil
(cons
 ⟨??⟩ ⟨??⟩)))
(define (square-list items)
(map
 ⟨??⟩ ⟨??⟩))
|#

; Student completion:

(define nums-1-to-4 (list 1 2 3 4))
(define num-1 (list 1))
(define num-neg-1-2 (list -1 -2))

(define (sqr-list items) 
  (if (null? items) 
    ()  
    (cons (square (car items)) (sqr-list (cdr items)))))

(sqr-list nums-1-to-4)
(sqr-list num-1)
(sqr-list num-neg-1-2)

(define (sqr-list items) 
  (map square items))

(sqr-list nums-1-to-4)
(sqr-list num-1)
(sqr-list num-neg-1-2)
