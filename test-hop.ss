#lang scheme

;; A starter tester for hop-basics. It is NOT a sufficient
;; tester in its current version -- only a sanity check.

(require test-engine/scheme-tests)

(require "hop-basics.ss")

;;;;; Test functions in functions ;;;;;

;; testing composeN
;; Three sanity-check tests.
(check-expect ((composeN list 0) 'a) 'a)
(check-expect ((composeN list 1) 'a) '(a))
(check-expect ((composeN list 2) 'a) '((a)))
;; Test with multiple elements.
(check-expect ((composeN car 2) '((a () (b)) b c)) 'a)
;; Test with function that can't be performed with an n value of 0.
(check-expect ((composeN car 0) 'a) 'a)
;; Test with function that doesn't alter the list.
(check-expect ((composeN length 1) '(a b c d)) 4)

;; testing cdr_lists
;; Test with empty list.
(check-expect (cdr_lists '()) '())
;; Test with list of empty lists.
(check-expect (cdr_lists '(()()()()())) '())
;; Test with list of single elements formed by a list of two elements.
(check-expect (cdr_lists '((1)(4)(5)(6)(2 3))) '(3))
;; Test with a list of empty lists followed by a list of two elements.
(check-expect (cdr_lists '(()()()()(2 3))) '(3))
;; Test with lists of two elements seperated by empty lists.
(check-expect (cdr_lists '((2 4)()()()(2 3))) '(4 3))
;; Test with list of two elements followed by empty lists.
(check-expect (cdr_lists '((2 4)()()()())) '(4))
;; Test with sanity check.
(check-expect (cdr_lists '((1 2) (3 4 5) (6 7))) '(2 4 5 7))
;; Test with arbitrary sized list.
(check-expect (cdr_lists '((1 2 3 4) (1 2 3 4) (1 2 3 4))) '(2 3 4 2 3 4 2 3 4))

;; testing cdr_lists_hop
;; Test with empty list.
(check-expect (cdr_lists_hop '()) '())
;; Test with list of empty lists.
(check-expect (cdr_lists_hop '(()()()()())) '())
;; Test with list of single elements formed by a list of two elements.
(check-expect (cdr_lists_hop '((1)(4)(5)(6)(2 3))) '(3))
;; Test with a list of empty lists followed by a list of two elements.
(check-expect (cdr_lists_hop '(()()()()(2 3))) '(3))
;; Test with lists of two elements seperated by empty lists.
(check-expect (cdr_lists_hop '((2 4)()()()(2 3))) '(4 3))
;; Test with list of two elements followed by empty lists.
(check-expect (cdr_lists_hop '((2 4)()()()())) '(4))
;; Test with sanity check.
(check-expect (cdr_lists_hop '((1 2) (3 4 5) (6 7))) '(2 4 5 7))
;; Test with arbitrary sized list.
(check-expect (cdr_lists_hop '((1 2 3 4) (1 2 3 4) (1 2 3 4))) '(2 3 4 2 3 4 2 3 4))

(test)
