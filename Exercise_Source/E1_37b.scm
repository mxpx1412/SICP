; Recursive process version of `cont-frac`:
(define (cont-frac n d k) 
  (define (next-frac i) 
    (if 
      (> i k) 
      0
      (/ (n i) (+ (d i) (next-frac (+ i 1))))))
  (next-frac 1))

; Compute \(frac{1}{\varphi}\) with `cont-frac`: 
(define k 100)

(cont-frac 
  (lambda (i) 1.0) 
  (lambda (i) 1.0) 
  k)

; Actual value for \(\frac{1}{\varphi}\): 
(/ 1.0 (/ (+ 1 (sqrt 5)) 2.0))
