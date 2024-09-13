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

