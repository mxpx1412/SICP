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

(define (dot-product v w) 
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v) 
  (map 
    (lambda (m_i) (dot-product v m_i)) m))

(define (transpose mat) 
  (accumulate-n cons () mat))

(define (matrix-*-matrix m n) 
  (let 
    ((cols (transpose n))) 
    (map (lambda (m_i) (matrix-*-vector cols m_i)) m)))

(define v '(1 2 3))
(define m (list '(1 2 3) '(4 5 6) '(7 8 9)))
(define a (list '(1 2 3) '(4 5 6)))
(define b (list '(1 2) '(3 4) '(5 6)))

(matrix-*-vector m v)
(transpose a)
(matrix-*-matrix a b)
