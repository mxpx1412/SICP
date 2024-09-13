(define (int-digits num) 
  (define (digit-counter n count) 
    (if (> 1 (abs n)) 
      count 
      (digit-counter (/ n 10) (+ count 1)))) 
  (if (> 1 (abs num)) 
    1 
    (digit-counter (abs num) 0)))

(define (string-repeat str total) 
  (define (repeat-iter head count) 
    (if (> count 0) 
      (repeat-iter (string-append head str) (- count 1)) 
      head))
  (repeat-iter "" total))

(define (is-even int) 
  (= (modulo int 2) 0))

(define (is-odd int) 
  (= (modulo int 2) 1))

(define (display-padded content total-pads padder align centering) 
  (define left-pads 
    (cond (centering 
	    (if (is-odd total-pads) 
	      (cond ((string=? align "left") 
		     (floor (/ total-pads 2))) 
		    ((string=? align "right") 
		     (ceiling (/ total-pads 2)))) 
	      (/ total-pads 2))) 
	  ((string=? align "left") 0) 
	  ((string=? align "right") total-pads)))
  (define right-pads (- total-pads left-pads))
  (display (string-repeat padder left-pads))
  (display content)
  (display (string-repeat padder right-pads)))

(define (Pascal-triangle rows) 
  (display "\n")
  (define (Pascal-element iter-row iter-col) 
    (if (or (= 1 iter-col) (= iter-row iter-col)) 
      1 
      (+ (Pascal-element (- iter-row 1) (- iter-col 1)) 
	 (Pascal-element (- iter-row 1) iter-col))))
  (define block-width 
    (int-digits 
      (Pascal-element rows (ceiling (/ rows 2)))))
  (define triangle-spacer (string-repeat " " block-width))
  (define (Pascal-display number iter-row iter-col) 
    (display-padded 
      number 
      (- block-width (int-digits number)) 
      " " 
      "left" 
      #t))
  (define (Pascal-row-iter iter-row iter-col) 
    (define iter-number (Pascal-element iter-row iter-col))
    (cond 
      ((= 1 iter-col) 
       (display (string-repeat triangle-spacer (- rows iter-row)))))
    (cond 
      ((and (= iter-row iter-col) (not (> iter-row rows))) 
       (Pascal-display iter-number iter-row iter-col)
       (display "\n")
       (Pascal-row-iter (+ iter-row 1) 1))
      ((not (> iter-row rows)) 
       (Pascal-display iter-number iter-row iter-col)
       (display triangle-spacer)
       (Pascal-row-iter iter-row (+ 1 iter-col)))))
  (Pascal-row-iter 1 1))

(Pascal-triangle 16)
