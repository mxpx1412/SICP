(define (accumulate op initial sequence) 
  (if (null? sequence) 
    initial 
    (op 
      (car sequence) 
      (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs) 
  (if (null? (car seqs)) 
    () 
    (cons 
      (accumulate op init (map car seqs)) 
      (accumulate-n op init (map cdr seqs)))))

(define M (list (list 3 0 0) (list 0 2 0) (list 0 0 1)))
(define sym (list (list 1 2 3) (list 2 4 7) (list 3 7 14)))

(accumulate-n + 0 M)
(accumulate-n + 0 sym)
