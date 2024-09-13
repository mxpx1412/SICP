; Iterative process version of `cont-frac`:
(define (cont-frac n d k) 
  (define (cont-frac-iter i frac-result) 
    (if 
      (= i 0) 
      frac-result 
      (let 
        ((next-frac (/ (n i) (+ (d i) frac-result)))) 
        (cont-frac-iter (- i 1) next-frac))))
  (cont-frac-iter k 0))

(define (e-frac i) 
  (* 2 (+ 1 (/ (- i 1) 3))))

(define (euler-num) 
  (+ 
    2.0 
    (cont-frac 
      (lambda (i) 1) 
      (lambda 
        (i) 
        (if 
          (= 0 (remainder (- i 2) 3)) 
          (* 2 (+ 1 (/ (- i 2) 3))) 
          1))
      100)))

(euler-num)
