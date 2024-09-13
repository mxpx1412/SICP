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

; Compute \(frac{1}{\varphi}\) with `cont-frac`: 
(define k 100)

(cont-frac 
  (lambda (i) 1.0) 
  (lambda (i) 1.0) 
  k)

; Actual value for \(\frac{1}{\varphi}\): 
(/ 1.0 (/ (+ 1 (sqrt 5)) 2.0))
