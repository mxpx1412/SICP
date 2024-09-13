; To extract `7` from each of the following lists with `car` and `cdr` combo: 

(define items-1 (list 1 3 (list 5 7) 9))
(define items-2 (list (list 7)))
(define items-3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

items-1
items-2
items-3

(car (cdr (car (cdr (cdr items-1)))))
(car (car items-2))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr items-3))))))))))))

