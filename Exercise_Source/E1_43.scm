(define (compose f g) 
  (lambda (x) (f (g x))))

(define (inc i) (+ i 1))

(define (repeated f n) 
  (define (rep-iter f_i i) 
    (if 
      (< i 2) 
      f_i 
      (rep-iter (compose f f_i) (- i 1))))
  (rep-iter f n))

((repeated square 2) 5)
((repeated square 4) 2)
((repeated inc 60) 9)
