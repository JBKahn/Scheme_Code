#lang scheme

;; A starter tester for grammar. It is NOT a sufficient
;; tester in its current version -- only a sanity check.

(require test-engine/scheme-tests)
(require racket/set)

(require "grammar.ss")

;;;;; Test procedures in grammar ;;;;;

;; defining sample test grammar and parse tree
(define g1 '((s n vp) (n cat) (n mat) (vp v on n) (v sat)))
(define pt1 '(s (n cat) (vp (v sat) on (n mat))))
(define pt1b 'cat)
(define g2 '((s np vp) (np art n) (np art happy n) (art the) (art a) (n cat) (n mat) (vp v) (vp v on np) (v sat)))
(define pt2 '(s (np (art the) happy (n cat)) (vp (v sat) on (np (art a) (n mat)))))
(define g3 '((a n n) (n cat) (n mat)))
(define pt3 '(n cat))
(define pt3b '(a (n cat) (n mat)))
(define g4 '())
(define pt4 '())

;; testing get_terminals
;; Test on arbitrary size list, sanity check.
(check-expect (length (get_terminals g1)) (length '(cat on sat mat)))
(check-expect (list->set (get_terminals g1)) (list->set '(cat on sat mat)))
;; Test on sample given in question.
(check-expect (length (get_terminals g2)) (length '(happy a the cat mat on sat)))
(check-expect (list->set (get_terminals g2)) (list->set '(happy a the cat mat on sat)))
;; Test with three production rules.
(check-expect (length (get_terminals g3)) (length '(cat mat)))
(check-expect (list->set (get_terminals g3)) (list->set '(cat mat)))
;; Test with no production rules.
(check-expect (length (get_terminals g4)) (length '()))
(check-expect (list->set (get_terminals g4)) (list->set '()))

;; testing get_non_terminals
;; Test on arbitrary size list, sanity check.
(check-expect (length (get_non_terminals g1)) (length '(vp v n s)))
(check-expect (list->set (get_non_terminals g1)) (list->set '(vp v n s)))
;; Test on sample given in question.
(check-expect (length (get_non_terminals g2)) (length '(s np art n vp v)))
(check-expect (list->set (get_non_terminals g2)) (list->set '(s np art n vp v)))
;; Test with three production rules.
(check-expect (length (get_non_terminals g3)) (length '(a n)))
(check-expect (list->set (get_non_terminals g3)) (list->set '(a n)))
;; Test with no production rules.
(check-expect (length (get_non_terminals g4)) (length '()))
(check-expect (list->set (get_non_terminals g4)) (list->set '()))

;; testing get_sentence
;; Test on arbitrary size list, sanity check.
(check-expect (get_sentence pt1 g1) '(cat sat on mat))
;; Test on single element.
(check-expect (get_sentence pt1b g1) '(cat))
;; Test on sample given in question.
(check-expect (get_sentence pt2 g2) '(the happy cat sat on a mat))
;; Test on single phrase.
(check-expect (get_sentence pt3 g3) '(cat))
;; Test with three phrases.
(check-expect (get_sentence pt3b g3) '(cat mat))
;; Test with no phrases.
(check-expect (get_sentence pt4 g4) '())

;; testing get_sentence_hop
;; Test on arbitrary size list, sanity check.
(check-expect (get_sentence_hop pt1) '(cat sat on mat))
;; Test on single element.
(check-expect (get_sentence_hop pt1b) '(cat))
;; Test on sample given in question.
(check-expect (get_sentence_hop pt2) '(the happy cat sat on a mat))
;; Test on single phrase.
(check-expect (get_sentence_hop pt3) '(cat))
;; Test with three phrases.
(check-expect (get_sentence_hop pt3b) '(cat mat))
;; Test with no phrases.
(check-expect (get_sentence_hop pt4) '())

(test)
