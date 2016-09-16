#lang racket

;; list-length
(define (list-length lst)
  (if (null? lst)
      0
      (+ 1 (list-length (rest lst))))
)
(display (list-length '(2 3 4 5))) (newline)

;; count-evens

(define (count-evens lst)
  (if (null? lst)
      0
      (if (even? (first lst))
          (+ 1 (count-evens (rest lst)))
          (count-evens (rest lst))
      )
  )
)

(display (count-evens '(2 3 4 5 6))) (newline)

;; count-evens-filter
(define (count-evens-filter lst)
  (if (null? lst)
      0
      (+ 1 (count-evens-filter (rest (filter even? lst))))
  ))

(display (count-evens-filter '(2 3 4 5 6))) (newline)

;;list-square

(define (square-of num)
  (* num num)
  )

(define (list-squares lst)
  (if (null? lst)
      lst
      (cons (square-of (first lst)) (list-squares (rest lst)))
  ))

(display (list-squares '(2 3 4 5 6))) (newline)


;; list-add1

(define (list-add1 lst)
  (if (null? lst)
      lst
      (cons (+ 1 (first lst)) (list-add1 (rest lst)))))

(display (list-add1 '(2 3 4 5 6))) (newline)

;; list-add10

(define (list-add10 lst)
  (if (null? lst)
      lst
      (cons (+ 10 (first lst)) (list-add1 (rest lst)))))

(display (list-add10 '(2 3 4 5 6))) (newline)

;; list-addn

(define (list-addn n lst)
  (map (lambda (x) (+ x n)) lst)
  )

(display (list-addn 20 '(2 3 4 5 6))) (newline)

;; filter-even

(define (filter-even lst)
  (filter even? lst))

(display (filter-even '(3 4 2 7))) (newline)

;; filter-positive

(define (filter-positive lst)
  (filter positive? lst))

(display (filter-positive '(3 4 -2 7))) (newline)

;; filter-gt
(define (filter-gt l lst)
  (if (null? lst)
      lst
      (if (>= (first lst) l)
          (cons (first lst) (filter-gt l (rest lst)))
          (filter-gt l (rest lst))
  ))
  )

;; filter-gt-lambda
(define (filter-gt-lambda l lst)
  (filter (lambda (x) (>= x l)) lst))

(display (filter-gt-lambda 3 '(-2 1 3 5 1))) (newline)
         