#lang racket

;; sum to n
(define (sum-to-n n)
  (if (= n 0)
      0
      (+ n (sum-to-n (- n 1))))
  )

(display (sum-to-n 6)) (newline) ;; --> 21

;; length of list
(define (length lst)
  (if (null? lst)
      0
      (+ 1 (length (cdr lst))))
  )

(display (length '(1 2 3 4 2))) (newline) ;; --> 5

;; absolute value of all members
;;(define (abs lst)
;;  (if (null? lst)
;;      ()
;;      (cons (abs-val (car lst)) (abs (cdr lst))))
;;  )

;;(display (abs '(1 -22 3 -4 2))) (newline) ;; --> (1 22 3 4 2)

;; sum of members on a list
(define (sum-of-mem lst)
  (if (null? lst)
      0
      (+ (car lst) (sum-of-mem (cdr lst))) 
  )
)

(display (sum-of-mem '(2 1 4))) (newline) ;; --> 7

;;append one list to another
(define (append-lists lst1 lst2)
    (if (null? lst1)
        lst2
        (cons (car lst1) (append-lists (cdr lst1) lst2))
    )
)

(display (append-lists '(1 3 2) '(21 4 2))) (newline) ;; --> (1 3 2 21 4 2)

;; counting atoms
;; helper atom function definition
(define (atom? x) 
  (and (not (pair? x))
       (not (null? x))))

(define (counting-atoms lst)
  (cond ((null? lst) 0)
        ((atom? lst) 1)
        (else (+ (counting-atoms (car lst)) (counting-atoms (cdr lst))))
  )
)

(display (counting-atoms '(1 (2 (3)) (5)))) (newline) ;; --> 4

;; length of the longest list and -1 if empty
(define (longest-list lst1 lst2)
  (cond ((and (null? lst1) (null? lst2)) -1)
        ((> (length lst1) (length lst2)) (length lst1))
        ((> (length lst2) (length lst1)) (length lst2))
  )
)

(display (longest-list '(1 2 2 (2 3) 3) '(1 2 2))) (newline) ;; --> 5



;; tree-add1
;; version 1
(define (tree-add1 tree)
    (if (null? tree)
        tree
        (if (number? (first tree))
           (cons (+ (first tree) 1) (tree-add1 (rest tree))) 
           (cons (tree-add1 (first tree)) (tree-add1 (rest tree)))        
        )
    )
)

;; version 2
(define (addone lst)
  (if (number? lst)
      (+ lst 1)
      (if (null? lst)
          lst
          (cons (addone (first lst)) (addone (rest lst))))
      )
)

;; test
(display (addone '(1 (3 2)))) (newline) ;; (3 (1 4)) --> (4 (2 5))

;;tree-max-depth (?)
(define (tree-max-depth lst)
  (if (or (null? lst) (not (pair? lst)))
      0
      (max
        (+ 1 (tree-max-depth (first lst)) )
        (tree-max-depth (rest lst))
      )
  )
)

;; test
(display (tree-max-depth '(1 (3 2)))) (newline) ;; --> 2

;; tree-max-width

;;bigger helper
(define (bigger a b)
  (if (> a b)
      a
      b)
  )

;;max-width function

;;tree-count-leaves

;;tree-map

;;tree-max and tree-min

;;flatten

;;tree-reshape

