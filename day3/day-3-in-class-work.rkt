#lang racket

;;;;;;;;;;
;;; Day 3 in class work

;;;;;;;;;;
;; 0.  Implement factorial both recursively and tail recursively.
;;     Hint:  The tail recursive version will use a helper function.

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

;;;;;;;;;;;
;; 1.  Filter is built in to scheme.

;; (filter even? '(1 2 3 4 5 6))  --> '(2 4 6)  ;; using the built-in even?
;; (filter teen? '(21 17 2 13 4 42 2 16 3)) --> '(17 13 16)
                        ;; assuming (define (teen x) (and (<= 13 x) (<= x 19)))))
;; (filter list? '(3 (3 2 1) symbol (4 2) (1 (2) 3)) --> '((3 2 1) (4 2) (1 (2) 3))

;; Implement it anyway.  You might want to call it my-filter?  What arguments does it take?

(define (my-filter op lst)
  (cond ((null? lst) null)
        ((op (first lst)) (cons (first lst) (my-filter op (rest lst))))
        (else (my-filter op (rest lst)))
        )
  )

(display (my-filter even? '(1 2 3 4 5 6))) (newline)



;;;;;;;;;;;
;; 2.  Map is also built in to scheme.

;; (map double '(1 2 3))  --> '(4 5 6)  ;; assuming (define (double x) (* 2 x))
;; (map incr '(1 2 3)) --> '(2 3 4)     ;; assuming (define (incr x) (+ x 1))
;; (map last '((3 2 1) (4 2) (1 2 3)) --> '(1 2 3)
                                        ;; assuming (define (last lst)
                                        ;;            (if (null? (rest lst))
                                        ;;                (first lst)
                                        ;;                (last (rest lst))))

;; Implement it as well.  You might want to call it my-map.  What arguments does it take?

(define (double x) (* 2 x))

(define (my-map op lst)
  (if (null? lst) null
        (cons (op (first lst)) (my-map op (rest lst)))
  )
)

(display (my-map double '(1 2 3))) (newline)


;;;;;;;;;;;
;; 3.  While we're reimplementing built-ins, implement my-append (just like built in append)
;;     It takes two lists and returns a list containing all of the elements of the originals, in order.
;;     Note that it is purely functional, i.e., it doesn't MODIFY either of the lists that it is passed.

;; (append '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6)

;; You might want to draw out the box and pointer structures for the original two lists
;; as well as for the new list.  Confirm with a member of the instructional staff....


(define (my-append lst1 lst2)
  (if (null? lst1)
      lst2
      (cons (first lst1) (my-append (rest lst1) lst2))
  )
)

(display (my-append '(1 2 3) '(4 5 6))) (newline)


;;;;;;;;;;;
;; 4.  zip takes two lists, and returns a list of elements of size two, until one of the lists runs out.

;; (zip '(1 2 3) '(4 5 6)) ;; --> '((1 4) (2 5) (3 6))
;; (zip '(1 2 3) '(a b c d e f g)) ;; --> '((1 a) (2 b) (3 c))

;; Implement `zip`.

(define (my-zip lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons (list (first lst1) (first lst2)) (my-zip (rest lst1) (rest lst2)))
      )
)

(display (my-zip '(1 2 6 7) '(4 5 4 5 2))) (newline)


;;;;;;;;;;;;
;; 5.  Last built-in (for now):  (my-)reverse.
;;     Takes a list, returns a new list with the elements reversed.

;; (reverse '(1 2 3)) --> '(3 2 1)

(define (my-reverse lst)
  (if (null? lst)
      lst
      (my-append (my-reverse (cdr lst)) (list (car lst)))
  ))
    
(display (my-reverse '(3 4 6))) (newline)


;;;;;;;;;;;;
;; More puzzles:
;;
;;  - (count elt lst) returns the number of times that elt appears in lst

(define (count input lst)
  (if (null? lst)
      0
      (if (eq? input (first lst))
          (+ 1 (count input (rest lst)))
          (count input (rest lst)))
      )
  )

(display (count 'elt '(elt 4 3 ee elt elt))) (newline) ;;--> 3

;;  - (remove-dups lst) returns a new list that contains the elements of lst but without repeats
;;       (remove-dups '(1 2 3 1 4 5 2 4 6)) --> '(1 2 3 4 5 6)

;;(display (remove-dups '(elt 4 3 ee 3 elt elt))) (newline) ;;--> (elt 4 3 ee)

;;  - reverse reverses a list, but doesn't reverse sublists in a tree.  (Try it and see.)

;;    Write deep-reverse, which reverses all sublists as well.
;;  - Which of these can you implement using tail recursion?
