#lang scheme

  ;; (composeN f n) returns a procedure that applies f to its argument n times. A procedure applied 0 
  ;; times is an identity procedure.
  ;; Note: f is a valid procedure; n is a valid integer greater than or equal to zero.
    (define composeN 
      (λ (f n)
        (cond
          ((zero? n) identity)
          ;; In order to satisfy the base case and n being zero, the identity proceedure is used.
          (else (compose (composeN f (- n 1)) f))
          ;; The proceedure f is composed so that is applies (n-1) times after f.
          )
        )
      )

  ;; (cdr_lists lst) returns a new list containing all elements of the cdr's of the sublists.
  ;; Note: lst is a valid list.
    (define cdr_lists 
      (λ (lst)
        (cond
          ((null? lst) null)
          ;; If the list is empty then null is returned.
          ((null? (car lst)) (flatten (cdr_lists (cdr lst))))
          ;; If the first list is empty then it is skipped and the cdr's of the rest of the lists
          ;; are evaluated recursivly and then flattened
          (else (flatten (cons (cdr (car lst)) (cdr_lists (cdr lst)))))
          ;; Flatten the construction of the cdr of the first element of the list with the cdr's
          ;; of the rest of the elements of the list, lst, recursivly.
          )
        )
      )

  ;; (cdr_lists_hop lst) returns a new list containing all elements of the cdr's of the sublists.
  ;; Note: lst is a valid list of sublists.
    (define cdr_lists_hop 
      (λ (lst)
        (flatten (map cdr (filter (λ (x) (not (empty? x))) lst)))
        ;; The list, lst, has the empty lists filtered out and then the resulting list has the map function 
        ;; apply cdr to every sublist. The result of the map function is then flattened.
        )
      )

    ;; export procedures
    (provide composeN cdr_lists cdr_lists_hop)