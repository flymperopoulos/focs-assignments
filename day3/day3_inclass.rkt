#lang racket

;; length of list
(define (lst-length lst)
  (if (null? lst)
      0
      (+ 1 (lst-length (rest lst))))
  )

;; member in a list
(define (member? elt lst)
  (if (null? lst)
      #f
      (if (equal? elt (first lst))
          #t
          (member? elt (rest lst)))
  ))

(display (member? 4 '(3 4 2))) (newline)

;;tail recursive call optimization
(define (list-length-2 lst)
  (ll lst 0)
)

(define (ll lst so-far)
  (if (null? lst)
      so-far
      (ll (rest lst) (+ 1 so-far))
      )
)

;; factorial
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))) 
  )

(display (factorial 3)) (newline)

;; factoial tail optimization
(define (factorial-main n)
  (factorial-helper n 1)
  )

(define (factorial-helper num prod)
  (if (= num 1)
      prod
      (factorial-helper (- num 1) (* num prod)))
  )

(display (factorial-main 3)) (newline)

;; filter
(define (my-filter op lst)
  (cond ((null? lst) null)
        ((op (first lst)) (cons (first lst) (my-filter op (rest lst))))
        (else (my-filter op (rest lst)))
        )
  )

(display (my-filter even? '(1 2 3 4 5 6))) (newline)

;; map
(define (double x) (* 2 x))

(define (my-map op lst)
  (if (null? lst) null
        (cons (op (first lst)) (my-map op (rest lst)))
  )
)

(display (my-map double '(1 2 3))) (newline)

;; append
(define (my-append lst1 lst2)
  (if (null? lst1)
      lst2
      (cons (first lst1) (my-append (rest lst1) lst2))
  )
)

(display (my-append '(1 2 3) '(4 5 6))) (newline)

;; zip
(define (my-zip lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons (list (first lst1) (first lst2)) (my-zip (rest lst1) (rest lst2)))
      )
)

(display (my-zip '(1 2 6 7) '(4 5 4 5 2))) (newline)

;; reverse
(define (my-reverse lst)
  (if (null? lst)
      lst
      (my-append (my-reverse (cdr lst)) (list (car lst)))
  ))
    
(display (my-reverse '(3 4 6))) (newline)

;; count number of times
(define (count input lst)
  (if (null? lst)
      0
      (if (eq? input (first lst))
          (+ 1 (count input (rest lst)))
          (count input (rest lst)))
      )
  )

(display (count 'elt '(elt 4 3 ee elt elt))) (newline) ;;--> 3

;; remove duplicates
(define (remove-helper input lst)
  (if (null? lst)
      input
      (if (eq? input (remove-helper (first lst) (rest lst)))
          '()
          (my-append input (remove-helper (first lst) (rest lst)))
  )))

(define (remove-dups lst)
  remove-helper (first lst) (rest lst)
  )

(display (remove-dups '(elt 4 3 ee 3 elt elt))) (newline) ;;--> (elt 4 3 ee)

;; reverse but not reverse the sublists

