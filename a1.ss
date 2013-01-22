#lang scheme

  ;; An identify function
  ;; (id x) returns x.
  (define id
    (lambda (x)
      x
      )
    )

  ;; (mem? a lst) returns true if atom a is an element in nested list lst.
  ;; Note: only return true if a is an element of lst (not an element of
  ;;       a sublist of lst).
  ;; Note: you should NOT use the built-in procedure member. 
  (define mem?
    (lambda (a lst)
       (if (null? lst)
           ;; Checks ff the list is found to be empty then it returns 
           ;; false to indicate the element isn't in the empty list.
           #f
           (or (equal? a (car lst)) (mem? a (cdr lst)))
           ;; Checks if the front element is equal to a or if the
           ;; remaining elements equal a by recursing on a list of
           ;; all but the first element.
           ;; It does not reccurse into a list object.
           )
       )
    )

  ;; (mirror? lst) returns true if lst is a flat list and if it contains
  ;; the same list of elements as its reverse.
  ;; Note: you should NOT use the built-in function reverse, but you may 
  ;;       define your own helper procedures.
  (define mirror? 
    (lambda (lst)
      (if (or (null? lst) (and (not (list? (car lst))) (null? (cdr lst))))
          ;; If the list is 1 element long and not a nested list or
          ;; empty then it is a mirror.
          #t
          (and (not (list? (last lst)))
               ;; Tests that the second element isn't a nested list.
               (and (not (list? (car lst)))
                    ;; Tests that the first element isn't a nested list.
                    (and (equal? (car lst) (last lst))
                         ;; Tests if the first and last elements are equal.
                         (mirror? (cdr (drop-right lst 1)))
                         ;; Calls the function recursivly on a list with an 
                         ;; element on the both sides removed.
                         )
                    )
               )
          )
      )
    )
     
  ;; (subst x y lst) returns the list lst with every occurrence of x
  ;; in lst and its sublists substituted by y.
  ;; Note: x and y are atoms; lst may be a nested list.
  (define subst 
    (lambda (x y lst)
      (if (null? lst)
          ;; If the list is empty, give back the null list.
          lst
          (if (pair? (car lst))
              ;; Checks if the first element of the list is a list itself
              (cons (subst x y (car lst)) (subst x y (cdr lst)))
              ;; Reccurses into the nested list then back through the original.
              (if (equal? (car lst) x)
                  ;; Checks if the current non-list value is equal to x.
                  (cons y (subst x y (cdr lst)))
                  ;; Changes the x value to y.
                  (cons (car lst) (subst x y (cdr lst)))
                  ;; Continues to reccurse down the list to look for x values
                  )
              )
          )
      )
    )

  ;; (add-node n tree) adds a number n to a tree, such that the tree holds
  ;; the property X (explained below) before and after n is added to it.
  ;; 
  ;; Note that in scheme, we represent a tree as a list (key left right), 
  ;; and an empty tree or subtree as the empty list ().  You may assume 
  ;; that the keys (i.e., datum) in the nodes are unique integer numbers.  A tree
  ;; with property X contains in each node a key that is strictly greater than all 
  ;; keys in its left subtree and strictly less than all keys in its right subtree.
  ;; If the tree already contains n, the tree is returned with no change.
  ;;
  ;; Example:
  ;;
  ;; tree:         3
  ;;             /   \
  ;;            1     6 
  ;;                 /
  ;;                4
  ;; 
  ;; list representation:   (3 (1 () ()) (6 (4 () ()) ()))
  ;;
  ;; the above tree after adding 2 becomes:
  ;;
  ;;               3
  ;;             /   \
  ;;            1     6 
  ;;             \   /
  ;;              2 4
  ;; 
  ;; list representation    (3 (1 () (2 () ())) (6 (4 () ()) ()))
  ;;
  (define add-node
    (lambda (n tree)
      (if (or (null? tree) (null? (car tree)))
          ;; If the tree is empty or a leaf has been reached then the next line is executed.
          (cons n (cons '() (cons '() '())))
          ;; A node with 2 empty leaves is placed.
          (if (equal? (car tree) n)
              ;; If the element is found in the tree, then it returns the original tree.
              tree
              (if (< n (car tree))
                  ;; If n is smaller than the current element then it reccursivly calls 
                  ;; add-node on the left side of the tree and reconstructs the tree with 
                  ;; the new changes.
                  (cons (car tree) (cons (add-node n (cadr tree)) (cddr tree) ))
                  (cons (car tree) (cons (cadr tree) (cons (add-node n (caddr tree)) '())))
                  ;; Otherwise, n has a larger value than the current node and it 
                  ;; reccursivly calls add-node on the right side of the tree and 
                  ;; reconstructs the tree with the new changes.
                  )
              )
          )
      )
    )
  (provide mem? mirror? subst add-node id)