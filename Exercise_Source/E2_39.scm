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

(define (reverse-fr sequence)
  (fold-right 
    (lambda (x y) 
      (if (null? y) (list x) (append y (list x)))) 
    () sequence))

(define (reverse-fl sequence)
  (fold-left 
    (lambda (x y) (cons y x)) 
    () sequence))

(reverse-fr '(1))
(reverse-fr '(1 2))
(reverse-fr '(1 2 3))
(reverse-fr (list 1 '(2 3)))
(reverse-fr (list '(1 2) 3))

(reverse-fl '(1))
(reverse-fl '(1 2))
(reverse-fl '(1 2 3))
(reverse-fl (list 1 '(2 3)))
(reverse-fl (list '(1 2) 3))

