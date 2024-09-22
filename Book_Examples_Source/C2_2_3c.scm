(define (accumulate op initial sequence) 
  (if (null? sequence) 
    initial 
    (op 
      (car sequence) 
      (accumulate op initial (cdr sequence)))))

(define 
  (enumerate-interval low high) 
    (if 
      (> low high) () 
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq) 
  (accumulate append () (map proc seq)))

; Prime number testing procedures from Chapter 1: 
(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor) 
    (cond 
        ((> (square test-divisor) n) n) 
        ((can-divide test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (can-divide a b) (= (remainder b a) 0))

(define (is-prime n) 
    (= n (smallest-divisor n)))

(define (sum-is-prime pair) 
  (is-prime (+ (car pair) (cadr pair))))

(define (make-pair-sum pair) 
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n) 
  (map make-pair-sum 
    (filter 
      sum-is-prime 
      (flatmap 
        (lambda (i) 
          (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1)))) 
        (enumerate-interval 1 n)))))

(prime-sum-pairs 6)
