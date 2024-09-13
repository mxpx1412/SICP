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

(define (tangent-cf x k) 
  (/ 
    (cont-frac 
      (lambda (i) (- (square x))) 
      (lambda (i) (+ 1 (* (- i 1) 2))) 
      k) 
    (if (= x 0) -1 (- x))))

(define pi-approx 3.14159265)
(define k 10000)
(tangent-cf (* pi-approx 0) k)
(tangent-cf (* pi-approx 0.25) k)
(tangent-cf (* pi-approx 0.5) k)
(tangent-cf (* pi-approx 0.75) k)
(tangent-cf (* pi-approx 1.0) k)
