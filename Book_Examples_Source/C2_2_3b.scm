; Filter for sequences: 
(define (filter predicate sequence) 
  (cond 
    ((null? sequence) ()) 
    ((predicate (car sequence)) 
      (cons (car sequence) (filter predicate (cdr sequence))))
    (else (filter predicate (cdr sequence)))))

(filter odd? (list 1 2 3 4 5))

; Accumulator for sequences: 
(define (accumulate op initial sequence) 
  (if (null? sequence) 
    initial 
    (op 
      (car sequence) 
      (accumulate op initial (cdr sequence)))))

(accumulate + 0 '(1 2 3 4))
(accumulate cons () '(1 2 3 4 5))

; Enumerator for integers: 
(define (enumerate-integers i n) 
  (if (> i n) () (cons i (enumerate-integers (+ i 1) n))))

(enumerate-integers 1 4)

; Enumerator for tree:
(define (enumerate-tree tree) 
  (cond 
    ((null? tree) ()) 
    ((not (pair? tree)) (list tree)) 
    (else 
      (append 
        (enumerate-tree (car tree)) 
        (enumerate-tree (cdr tree))))))

(define num-tree (list 1 2 '(3 4 5) 6 (list 7 '(8 9))))
(enumerate-tree num-tree)

; Reformulate `sum-odd-squares` as structured in signal flow diagram:
(define (sum-odd-squares tree) 
  (accumulate + 0 (map square (filter odd? (enumerate-tree tree)))))

(sum-odd-squares num-tree)

(define (fib n) 
  (define (fib-iter k fib-i fib-j) 
    (if (> k n) 
      fib-j 
      (fib-iter (+ k 1) fib-j (+ fib-i fib-j))))
  (cond 
    ((= n 0) 0) 
    ((= n 1) 1) 
    (else (fib-iter 2 (fib 0) (fib 1)))))

; Reformulate `even-fibs` as structured in signal flow diagram:
(define (even-fibs n) 
  (accumulate cons () (filter even? (map fib (enumerate-integers 0 n)))))

(even-fibs 7)

; Using similar signal flow structure to list squares of Fibonacci numbers: 
(define (list-fib-squares n) 
  (accumulate 
    cons 
    () 
    (map square (map fib (enumerate-integers 0 n)))))

(list-fib-squares 7)

; Using similar signal flow structure to compute product of odds in sequence: 
(define (prod-squares-odds sequence) 
  (accumulate * 1 (map square (filter odd? sequence))))

(prod-squares-odds (list 1 2 3 4))
