(define (average x y) (/ (+ x y) 2.0))

(define (average-damp f) 
  (lambda (x) (average (f x) x)))

(define (close-enough x y) (< (abs (- x y)) 0.00001))

(define (fixed-point f first-guess) 
  (define (try guess) 
    (let 
      ((next-guess (f guess))) 
      (if 
        (close-enough guess next-guess) 
        next-guess 
        (try next-guess)))) 
  (try first-guess))

(define (compose f g) 
  (lambda (x) (f (g x))))

(define (repeated f n) 
  (define (rep-iter f_i i) 
    (if 
      (< i 2) 
      f_i 
      (rep-iter (compose f f_i) (- i 1))))
  (rep-iter f n))

(define (nth-root x n num-damps) 
  (fixed-point 
    ((repeated average-damp num-damps) 
      (lambda (y) (/ x (expt y (- n 1)))))
    1.0))

; 4th root converges after 2 damps:
(define root 4)
(nth-root 9 root 2)

; 7th root converges after 2 damps:
(define root 7)
(nth-root 9 root 2)

; 8th root converges after 3 damps:
(define root 8)
(nth-root 9 root 3)

; 15th root converges after 3 damps:
(define root 15)
(nth-root 9 root 3)

; 16th root converges after 4 damps:
(define root 16)
(nth-root 9 root 4)

; 31st root converges after 4 damps:
(define root 31)
(nth-root 9 root 4)

; 32nd root converges after 5 damps:
(define root 32)
(nth-root 9 root 5)
