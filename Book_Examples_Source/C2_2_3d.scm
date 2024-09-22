(define (accumulate op initial sequence) 
  (if (null? sequence) 
    initial 
    (op 
      (car sequence) 
      (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append () (map proc seq)))

(define (remove item sequence)
  (filter 
    (lambda (x) (not (= x item)))
    sequence))

(define (permutations set) 
  (if 
    (null? set) (list ()) ; if set empty, return sequence containing empty set 
    (flatmap 
      (lambda (elem-x) 
        (map (lambda (elem-p) (cons elem-x elem-p)) 
          (permutations (remove elem-x set)))) 
      set)))

(define example-set (list 1 2 3))
(permutations example-set)
