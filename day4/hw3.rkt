#lang racket

;;; Student Name: Filippos Lymperopoulos
;;;
;;; Check one:
;;; [*] I completed this assignment without assistance or external resources.
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


(define (assq key lst)
  (if (null? lst)
      #f
      (if (eq? key (first (first lst)))
          (first lst)
          (assq key (rest lst)))
      )
  )

;; test
(define operator-list
  (list (list 'ADD +)
        (list 'SUB -)
        (list 'MUL *)
        (list 'DIV /)
        (list 'GT >)
        (list 'LT <)
        (list 'GE >=)
        (list 'LE <=)
        (list 'EQ =)
        (list 'NEQ (lambda (x y) (not (= x y))))
        (list 'ANND (lambda (x y) (and x y)))
        (list 'ORR (lambda (x y) (or x y)))
        (list 'NOTT not)))

(display (assq 'ADD operator-list)) (newline) ;;--> '(ADD #<procedure:+>)
(display (assq 'FOO operator-list)) (newline) ;;--> #f
(display (assq 5 '((3 4) (1 6) (4 5)))) (newline) ;; --> #f
(display (assq 1 '((3 4) (1 6) (4 5)))) (newline) ;; --> (1 6)

;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

(define variable-list
  (list (list 'x 3)
        (list 'y 2)
        (list 'z -5)
  )
)

(define (calculate x variable-list)
  (if (symbol? x)
      (last (assq x variable-list))
      (if (or (boolean? x) (number? x))
          x
       (cond
         [(eq? (first x) 'ADD) (+ (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'SUB) (- (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'MUL) (* (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'DIV) (/ (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'GT)  (> (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'LT)  (< (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'GE)  (>= (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'LE)  (<= (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'EQ)  (eq? (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'NEQ) (not (eq? (calculate (second x) variable-list) (calculate (third x) variable-list)))]
         [(eq? (first x) 'ANND)(and (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'ORR) (or (calculate (second x) variable-list) (calculate (third x) variable-list))]
         [(eq? (first x) 'NOTT)(not (calculate (second x) variable-list))]
         [(eq? (first x) 'IPH) (if (calculate (second x) variable-list) (calculate (third x) variable-list) (calculate(fourth x) variable-list))]
         ))
  ))
 
(display (calculate '(ADD x z) variable-list)) (newline) ;; --> -2
(display (calculate 'z  variable-list)) (newline) ;; --> -5
(display (calculate '(IPH (GT x 0) z (- 0 z)) variable-list)) (newline) ;; --> -5
(display (calculate '(IPH (GT x 0) x (- 0 x)) '((x 3) (y 2) (z -5)))) (newline) ;; --> 3