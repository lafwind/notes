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


;;; SQRT
;;; HERON

;;; way 1
(define (sqrt x)
  (fixed-point
   (lambda (y) (average (/ x y) y))
   1))

;;; way 2
(define (sqrt x)
  (fixed-point
   (average-damp (lambda (y) (/ x y)))
   1))

(define average-damp
  (lambda (f)
    (lambda (x) (average (f x) x))))

(define (fixed-point f start)
  (define tolerance 0.00001)
  (define (close-enuf? u v)
    (< (abs (- u v)) tolerance))
  (define (iter old new)
    (if (close-enuf? old new)
	new
	(iter new (f new))))
  (iter start (f start)))
