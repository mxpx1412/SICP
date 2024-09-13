(define (compose f g) 
  (lambda (x) (f (g x))))

(define (inc i) (+ i 1))

((compose square inc) 6)
