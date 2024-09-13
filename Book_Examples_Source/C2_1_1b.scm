; Starting point to build compound data for rationals:
(define x (cons 1 2))
(car x)
(cdr x)

; Forming pairs from pairs:
(define a (cons 1 2))
(define b (cons 3 4))
(define c (cons a b))
(car (car c))
(car (cdr c))
