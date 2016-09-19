#lang racket

;;; Student Name: Filippos Lymperopoulos
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [*] I completed this assignment with assistance from Sawyer Vaughan - we worked together to figure out ax definition's sustainability.

;; lookup-list that will update after new variable is defined
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

;; look up and return the value/procedure for the key specified
(define (assq key lst)
  (if (null? lst)
      #f
      (if (eq? key (first (first lst)))
          (first lst)
          (assq key (rest lst)))
      )
  )

;; check if we have defined something new
(define (DEFINE? lst)
  (if (list? lst)
      (if (eq? (first lst) 'DEFINE)
          #t
          #f
       )
      #f
      )
  )

(define (LAMBDA? lst)
  (if (list? lst)
      (if (eq? (first lst) 'LAMBDA)
          #t
          #f
       )
      #f
      )
  )
(define (exists-in? input lookup-list)
  (if (null? lookup-list)
      #f
      (if (eq? (second input) (first (first lookup-list)))
          #t
          (exists-in? input (rest lookup-list))
      )
  )
)

;; do the calc
(define (calculate input lookup-list)
  (if (DEFINE? input)
      (if (exists-in? input lookup-list)
          (repl (map (lambda(x) (if (eq? (first x) (second input)) (list (first x) (third input)) x)) lookup-list))
          (repl (append lookup-list (list (list (second input) (third input)))))
      )
      (if (LAMBDA? input)
          (list 'lambda (second input) (third input) lookup-list)
          (if (list? input)
              (
               (second (assq (first input) lookup-list))
               (calculate (second input) lookup-list)
               (calculate (third input) lookup-list)
               )
              (if (symbol? input)
                  (second (assq input lookup-list))
                  input
                  )
           ))     
))

;; start the interpreter
(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish") (newline)
  (repl operator-list))

;; keep the interpreter running
(define (repl operator-list)
  (display "mini-eval>> ")
  (display (calculate (read) operator-list))
  (newline)
  (repl operator-list))

(run-repl)
