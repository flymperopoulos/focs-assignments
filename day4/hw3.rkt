#lang racket

;;; Student Name: Filippos Lymperopoulos
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

;;;;;;;;;;;
;; 1. assq

;; `assq` is a function that takes a key and an association list.
;;
;; It returns the corresponding key/value pair from the list
;; (*i.e.*, the pair whose key is *eq?* to the one it is given).
;;
;; If the key is not found in the list, `assq` returns `#f`.

(define (assq-helper key lst1 lst2)
  (if (null? lst2)
      #f
      (if (eq? key (first lst1))
          lst1
          (assq-helper key (first lst2) (rest lst2))
  )))


(define (assq key lst)
  (assq-helper key (first lst) (rest lst))
  )

(display (assq 5 '((3 4) (1 6) (4 5)))) (newline) ;; --> #f
(display (assq 1 '((3 4) (1 6) (4 5)))) (newline) ;; --> (1 6)

;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

