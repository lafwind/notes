(define (sum term A next b)
  (if (> A B)
      0
      (+ (term A)
	 (sum term
	      (next A)
	      next
	      B))))

(define (sum-int A B)
  (define (identify X) X)
  (sum identify
       A
       (lambda (i) (+ i 1))
       B))

(define (sum-sq A B)
  (sum square
       A
       (lambda (i) (+ i 1))
       B))

(define (pi-sum A B)
  (sum (lambda (y) (/ 1 (* i (+ i 2 ))))
       A
       (lambda (i) (+ i 4))
       B))
