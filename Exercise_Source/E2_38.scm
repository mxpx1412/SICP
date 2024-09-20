(define (fold-right op initial sequence) 
  (if (null? sequence) 
    initial 
    (op 
      (car sequence) 
      (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
    (define (iter result rest)
      (if (null? rest)
        result
        (iter (op result (car rest))
          (cdr rest))))
  (iter initial sequence))

(fold-right / 1 '(1 2 3))
(fold-left / 1 '(1 2 3))
(fold-right list () (list 1 2 3))
(fold-left list () (list 1 2 3))

; $f(x, y) = 2(x+y)$
(define (f x y) (* 2 (+ x y)))
(fold-right f 0 '(1 2 3))
(fold-left f 0 '(1 2 3))

; Commutative and associative operations folds the same:
(fold-right + 1 '(1 2 3))
(fold-left + 1 '(1 2 3))
(fold-right * 1 '(1 2 3))
(fold-left * 1 '(1 2 3))

