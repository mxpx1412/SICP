10
; Expect: 10

(+ 5 3 4)
; Expect: 12

(- 9 1)
; Expect: 8

(/ 6 2)
; Expect 3

(+ (* 2 4) (- 4 6))
; Expect 6

(define a 3)
; Expect a
; Expect `(display a)` will print 3

(define b (+ a 1))
; Expect b
; Expect `(display b)` will print 4

(+ a b (* a b))
; Expect 19

(= a b)
; Expect False

(if (and (> b a) (< b (* a b)))
  b
  a)
; Expect 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; Expect 16

(+ 2 (if (> b a) b a))
; Expect 6

(+ (cond ((> a b) a)
	 ((< a b) b)
	 (else -1))
   (+ a 1))
; Expect 8
