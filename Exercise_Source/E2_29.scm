(define (make-mobile left right) 
  (list left right))

(define (make-branch branch-len structure) 
  (list branch-len structure))

; Test binary mobile

(define lll (make-branch 7 5))
(define llr (make-branch 2 3))
(define ll (make-branch 4 (make-mobile lll llr)))
(define lr (make-branch 1 4))
(define l (make-branch 3 (make-mobile ll lr)))
(define rr (make-branch 8 9))
(define rl (make-branch 5 11))
(define r (make-branch 6 (make-mobile rl rr)))
(define b-mobile (make-mobile l r))

; 2.29a - Selectors for a binary mobile

(define (left-branch bin-mobile) 
  (car bin-mobile))

(define (right-branch bin-mobile) 
  (car (cdr bin-mobile)))

(define (branch-length bin-branch) 
  (car bin-branch))

(define (branch-structure bin-branch) 
  (car (cdr bin-branch)))

; 2.29a - Testing
(branch-length (left-branch b-mobile))
(branch-length (right-branch (branch-structure (left-branch b-mobile))))
(branch-length (right-branch b-mobile))
(branch-structure (left-branch (branch-structure (right-branch b-mobile))))

; 2.29b

(define (branch-weight branch) 
  (let 
    ((branch-end (branch-structure branch))) 
    (cond 
      ((null? branch-end) 0)
      ((pair? branch-end) (total-weight branch-end)) 
      (else branch-end))))

(define (total-weight bin-mobile) 
  (+ 
    (branch-weight (left-branch bin-mobile)) 
    (branch-weight (right-branch bin-mobile))))

(total-weight b-mobile)

; 2.29c

(define (is-balanced bin-mobile) 
  (define imbalance-signal #f) 
  (define found-imbalance boolean?) 
  (define fully-balanced number?) 
  (define (branch-balance branch) 
    (let ((branch-end (branch-structure branch))) 
      (cond 
        ((null? branch-end) 0) 
        ((pair? branch-end) (iter-bw branch-end)) 
        (else branch-end))))
  (define (iter-bw iter-mobile) 
    (let 
      ((left (left-branch iter-mobile)) 
      (right (right-branch iter-mobile))) 
      (let ((l-bal-wt (branch-balance left))) 
        (if (found-imbalance l-bal-wt) 
          imbalance-signal 
          (let ((r-bal-wt (branch-balance right))) 
            (if (found-imbalance r-bal-wt) 
              imbalance-signal 
                (if 
                  (= 
                    (* (branch-length left) l-bal-wt) 
                    (* (branch-length right) r-bal-wt)) 
                  (+ l-bal-wt r-bal-wt) 
                  imbalance-signal))))))) 
  (fully-balanced (iter-bw bin-mobile)))

; 2.29c - Testing
(define b-ll (make-branch 4 3))
(define b-lr (make-branch 2 6))
(define b-l (make-branch 8 (make-mobile b-ll b-lr)))
(define b-rr (make-branch 15 2))
(define b-rl (make-branch 3 10))
(define b-r (make-branch 6 (make-mobile b-rl b-rr)))
(define b-b-mobile (make-mobile b-l b-r))

(is-balanced b-mobile)
(is-balanced b-b-mobile)
