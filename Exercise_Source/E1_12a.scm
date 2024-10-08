(define (Pascal-triangle rows) 
  (display "\n")
  (define (Pascal-element iter-row iter-col) 
    (if (or (= 1 iter-col) (= iter-row iter-col)) 
      1 
      (+ (Pascal-element (- iter-row 1) (- iter-col 1)) 
	 (Pascal-element (- iter-row 1) iter-col))))
  (define (Pascal-row-iter iter-row iter-col) 
    (cond 
      ((and (= iter-row iter-col) (not (> iter-row rows))) 
       (display (Pascal-element iter-row iter-col))
       (display "\n")
       (Pascal-row-iter (+ iter-row 1) 1))
      ((not (> iter-row rows)) 
       (display (Pascal-element iter-row iter-col))
       (display " ")
       (Pascal-row-iter iter-row (+ 1 iter-col)))))
  (Pascal-row-iter 1 1))

(Pascal-triangle 7)
