; From text `accumulate` for sequence
(define (accumulate combiner initial sequence) 
  (if 
    (null? sequence) 
    initial 
    (combiner 
      (car sequence) 
      (accumulate combiner initial (cdr sequence)))))

; 2.33
(define (seq-map proc sequence) 
  (accumulate 
    (lambda (iter-elem remaining) 
      (cons 
        (if (pair? iter-elem) 
          (seq-map proc iter-elem) 
          (proc iter-elem)) 
        remaining)) 
    () sequence))

(define (seq-append seq1 seq2) 
  (accumulate cons seq2 seq1))

(define (seq-length sequence) 
  (accumulate 
    (lambda (iter-elem len-rest) 
      (+ 1 len-rest)) 
    0 sequence))

; Testing
(define num-list (list 1 2 3 (list 4 5) 6 (list 7 (list 8 9))))
(seq-map square num-list)

(define num-list-1 (list 1 2 (list 3 4)))
(define num-list-2 (list (list 5 6 (list 7 8)) 9))
(seq-append num-list-1 num-list-2)

(seq-length num-list-2)
