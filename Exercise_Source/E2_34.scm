; From text `accumulate` for sequence
(define (accumulate combiner initial sequence) 
  (if 
    (null? sequence) 
    initial 
    (combiner 
      (car sequence) 
      (accumulate combiner initial (cdr sequence)))))

; 2.34
(define (horner-eval x coeff-seq) 
  (accumulate 
    (lambda (this-coeff higher-term) (+ this-coeff (* x higher-term))) 
    0 
    coeff-seq))

; Test: BMD of fixed continuous beam under uniformly distributed load. 
(define q 3.0)
(define L 8.0)
(define BMD-coeff 
  (list 
    (- (/ (* q (square L)) 12.0)) 
    (/ (* q L) 2.0) 
    (- (/ q 2))))
(horner-eval 0.0 BMD-coeff)
(horner-eval (* L 0.21) BMD-coeff)
(horner-eval (/ L 2.0) BMD-coeff)
