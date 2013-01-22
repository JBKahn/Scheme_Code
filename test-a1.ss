#lang scheme

;; A starter tester for functions. It is NOT a sufficient
;; tester in its current version -- only a sanity check.

(require test-engine/scheme-tests)

(require "a1.ss")

;;;;; Test functions in functions ;;;;;
;; The mirror? tests
(check-expect (id '(a z a)) '(a z a))
;; Test arbitrary list
(check-expect (id '()) '())
;; Test empty list
(check-expect (id '(A)) '(A))
;; Test single element list
(check-expect (id 1) 1)
;; Test number
(check-expect (id 'hello) 'hello)
;; Test with string

;; The mirror? tests
(check-expect (mirror? '(a z a)) true)
;; Test odd number of element mirrored list
(check-expect (mirror? '(a)) true)
;; Test single item list
(check-expect (mirror? '()) true)
;; Test empty list
(check-expect (mirror? '(a z z a)) true)
;; Test even number of element mirrored list
(check-expect (mirror? '((a))) false)
;; Test single nested list
(check-expect (mirror? '(A z a)) false)
;; Test odd number of elmenets non mirrored list
(check-expect (mirror? '(A z z a)) false)
;; Test even number of elmenets non mirrored list
(check-expect (mirror? '(a 1 3 4 z 4 3 1 a)) true)
;; Test arbitrary mirrored list
(check-expect (mirror? '((1) 2 (1))) false)
;; Test mirrored lists with nested lists

;; The subst tests
(check-expect (subst 1 88 '(1 (1 3) 3 5)) '(88 (88 3) 3 5))
;; Test with nested list
(check-expect (subst 'a 'k '(a (b a (c a d) a) 3 5)) '(k (b k (c k d) k) 3 5))
;; Test with arbitrary length mixed symbols and nested nested lists.
(check-expect (subst 1 2 '(5 3 5)) '(5 3 5))
;; Test with no matches
(check-expect (subst 1 88 '()) '())
;; Test with empty list
(check-expect (subst 1 88 '(1)) '(88))
;; Test with single element list

;; The mem? tests
(check-expect (mem? 'a '(d b c (a e f))) false)
;; Test with nested list
(check-expect (mem? 1 '(1)) true)
;; Test with single element
(check-expect (mem? 1 '()) false)
;; Test with empty list
(check-expect (mem? 1 '(() 1)) true)
;; Test with item outside empty nested list
(check-expect (mem? 1 '(2)) false)
;; Test with single elemenet non-match
(check-expect (mem? 1 '((1 2 3) 1 (4 5 6))) true)
;; Test with element outside and inside nested list.

;; The add-node tests
(check-expect (add-node 2 '(3 (1 () ()) (6 (4 () ()) ()))) '(3 (1 () (2 ()())) (6 (4 ()())())))
;; Add node to right side of left side of tree
(check-expect (add-node 7 '(3 (1 () ()) (6 (4 () ()) ()))) '(3 (1 () ()) (6 (4 ()())(7 () ()))))
;; Add item to right side of right side of tree
(check-expect (add-node 3 '(4 (1 () ()) (6 (5 () ()) ()))) '(4 (1 () (3 () ())) (6 (5 () ()) ())))
;; Add item to right side of left side of tree
(check-expect (add-node 5 '(3 (1 () ()) (6 (4 () ()) ()))) '(3 (1 () ()) (6 (4 () (5 () ())) ())))
;; Add item to the right side of the left side of the right side of the tree
(check-expect (add-node 1 '(3 (1 () ()) (6 (4 () ()) ()))) '(3 (1 () ()) (6 (4 () ()) ())))
;; Add existing item to the tree
(check-expect (add-node 2 '(2 () ())) '(2 () ()))
;; Add existing item to the tree at the top element
(check-expect (add-node 2 '()) '(2 () ()))
;; Add node to non-existand tree
(test)
