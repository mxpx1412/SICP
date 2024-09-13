(define (sum-max-squares x y z) 
  (define minimum (min x y z))
  (cond 
    ((= minimum x) (+ (* y y) (* z z)))
    ((= minimum y) (+ (* x x) (* z z)))
    (else (+ (* x x) (* y y)))
    )
  )

(sum-max-squares 1 2 -3)
