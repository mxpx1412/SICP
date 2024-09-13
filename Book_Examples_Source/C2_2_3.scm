(define (sum-odd-squares tree)
  (cond 
    ((null? tree) 0)
    ((not (pair? tree)) 
      (if (odd? tree) (square tree) 0))
    (else 
      (+ (sum-odd-squares (car tree))
      (sum-odd-squares (cdr tree))))))

(define num-tree (list 1 2 '(3 4 5) 6 '(7 8) 9))
(sum-odd-squares num-tree)

(define (fib n) 
  (cond 
    ((= n 0) 0)
    ((= n 1) 1) 
    (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (even-fibs n)
  (define (next k)
    (if (> k n)
      () 
      (let ((f (fib k)))
        (if (even? f)
          (cons f (next (+ k 1)))
          (next (+ k 1))))))
  (next 0))

(even-fibs 7)
