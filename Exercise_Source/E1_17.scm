(define (double m) (+ m m))

#|
(define (halve-iter even-num iter-num) 
    (cond 
        ((= (+ iter-num iter-num) even-num) iter-num) 
        (else (halve-iter even-num (- iter-num 1)))))
|# 

(define (halve m) 
    (define (halve-iter even-num iter-num) 
        (cond 
            ((= (+ iter-num iter-num) even-num) iter-num) 
            (else (halve-iter even-num (- iter-num (if (< even-num 1) -1 1))))))
    (halve-iter m m))


(define (is-even m)
    (cond ((< (abs m) 2) (=  m 0)) (else (is-even (- m (if (< m 0) -2 2))))))

#| Using `int-times` instead of `*` to not confuse functions. |#


(define (int-times a b) 
    (define (int-times-iter a_0 a-iter b-iter) 
        (cond 
            ((= b-iter 0) a_0)
            ((is-even b-iter) (int-times-iter a_0 (double a-iter) (halve b-iter))) 
            (else (int-times-iter (+ a_0 a-iter) a-iter (- b-iter 1)))))
    (if (or (and (< a 0) (< b 0)) (and (> a 0) (> b 0)))
        (int-times-iter 0 (abs a) (abs b)) 
        (int-times-iter 0 (- (abs a)) (abs b))))

(int-times -1 3)
(int-times 1 -3)
(int-times 2 4)
(int-times -5 -3)
(int-times -9 0)
(int-times 0 3)
