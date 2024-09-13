#| Iterative process for exercise function |#

(define (f n) 
  (define (f-iter f_1 f_2 f_3 count) 
    (if (> 3 count) 
      f_1 
      (f-iter (+ f_1 (* 2 f_2) (* 3 f_3)) f_1 f_2 (- count 1))))
  (if (< n 3) 
    n
    (f-iter 2 1 0 n)))

(f 5)
