(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n) 
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x)))) 

(define two (lambda (f) (lambda (x) (f (f x)))))

; Adding two Church numerals.
(define (plus m n) 
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))

; Testing Church numeral with one and two.
(define (inc i) (+ i 1)) 
(define (half-step x) (+ x 0.5))
((one inc) 0)
((one half-step) 0)
((two inc) 0)
((two half-step) 0)
(((plus one two) inc) 0)
(((plus one two) half-step) 0)

; Defining procedures to convert to/from Church numerals for testing.
(define (num-to-church n) 
  (define (church-iter i church-i) 
    (if 
      (= i n) 
      church-i 
      (church-iter (+ i 1) (add-1 church-i)))) 
  (church-iter 0 zero))

(define (church-to-num church-n) 
  ((church-n inc) 0))

; Testing Church numeral addition with large numbers.
(define c-125 (num-to-church 125))
(define c-415 (num-to-church 415))
(define result (plus c-125 c-415))
(church-to-num result)
((result half-step) 0)
