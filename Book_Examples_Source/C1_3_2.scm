; Definition using helper function
(define (f x y) 
  (define (f-helper a b) 
    (+ 
      (* x (square a)) 
      (* y b) 
      (* a b))) 
  (f-helper (+ 1 (* x y)) (- 1 y)))

(f 1 2)

; Definition using internal definition
(define (f x y) 
  (define a (+ 1 (* x y))) 
  (define b (- 1 y)) 
  (+ 
    (* x (square a)) 
    (* y b) 
    (* a b)))

(f 1 2)

; Definition using `lambda`
(define (f x y) 
  ((lambda (a b) 
    (+ 
      (* x (square a)) 
      (* y b) 
      (* a b))) 
    (+ 1 (* x y)) (- 1 y)))

(f 1 2)

; Definition using special form `let`
(define (f x y) 
  (let 
    ((a (+ 1 (* x y))) 
    (b (- 1 y))) 
  (+ 
    (* x (square a)) 
    (* y b) 
    (* a b))))

(f 1 2)
