#lang scheme

  ;; (get_non_terminals grammar) returns the set of the non-terminal symbols in grammar as a list.
  ;; Note: grammar is a list of sublists of production rules.
  (define get_non_terminals 
    (λ (grammar)
      (make_set (map car grammar))
      ;; Uses a map to create a list of all the first elements of each of the rules, which are all 
      ;; non-terminals. That list is then turned into a list representation of the set of itself using
      ;; make_set.
      )
    )

  ;; (get_terminals grammar) returns the set of the terminal symbols in grammar as a list.
  ;; Note: grammar is a list of sublists of production rules.
  (define get_terminals 
    (λ (grammar)
      (define potential_terms (flatten (map cdr grammar)))
      ;; Uses a map to create a list of all the non-first elements of each of the rules, which are all
      ;; potential terminal symbols.
      (define non_terms (get_non_terminals grammar))
      ;; Uses the get_non_terminals function to create a list of terminals.
      (make_set (filter (λ (x) (not (member x non_terms))) potential_terms))
      ;; Takes the list of potential terminals and filters out the list of known non-terminals to create a
      ;; list of terminals. That list is then turned into a list representation of the set of itself using
      ;; make_set.
      )
    )

  ;; (make_set lst) returns the set of the symbols in lst as a list.
  ;; Note: lst is a list.
  (define make_set
    (λ (lst)
      (cond
        ((null? lst) lst)
        ;; If the list is empty then it's returned.
        (else (cons (car lst) 
                    (make_set (filter (λ (x) (and (not (equal? x (car lst))) (not (null? x)))) (cdr lst)))
                    )
              )
        ;; If the list isn't empty then each element x of the list is added to a filtered version of the rest of the
        ;; list where the rest of the list contains no empty lists or x's.
        )
      )
    )

  ;; (get_sentence ptree grammar) returns the yield of the parse tree ptree, using the production rules contained in 
  ;; grammer, as an ordered list.
  ;; Note: grammar is a list of sublists of production rules; ptree is a valid parse tree.
  (define get_sentence
    (λ (ptree grammar)
      (define terminals (get_terminals grammar))
      ;; terminals represents the set of the terminal symbols in grammar as a list, using get_terminals.
      (define non_terminals (get_non_terminals grammar))
      ;; non-terminals represents the set of the non-terminal symbols in grammar as a list, using get_non_terminals.
      (flatten (gs_helper ptree terminals non_terminals))
      ;; flattens the yield of the parse tree from the helper function gs_helper.
      )
    )
  ;; (read_phrase ptree term nonterm) returns the yield of the parse tree, ptree, with a list of non-terminals nonterm
  ;; and a list of terminals term.
  ;; Note: ptree is a valid parse tree; term is a list representation of a set of terminals; nonterm is a  list 
  ;; representation of a set of non-terminals.
  (define gs_helper
    (λ (ptree term nonterm)
      (cond
        ((null? ptree) ptree)
        ;; If the ptree is empty, then it is returned.
        ((not (list? ptree)) ptree)
         ;; If the ptree is a single item, then it is returned.
        ((list? (car ptree)) (cons (gs_helper (car ptree) term nonterm) (gs_helper (cdr ptree) term nonterm)))
        ;; If the parse tree's first element is a list, indicating a phrase, then it is evaluated and constructed
        ;; with the evaluation of the rest of the list.
        ((member (car ptree) nonterm) (gs_helper (cdr ptree) term nonterm))
        ;; If the parse tree's first element is a non-terminal then it is skipped over.
        (else (cons (car ptree) (gs_helper (cdr ptree) term nonterm)))
        ;; If the parse tree's first element isn't a terminal, then it must be a terminal and it's constructed
        ;; with the evaluation of the rest of the list.
        )
      )
    )

  ;; (get_sentence_hop ptree) returns the yield of the parse tree ptree as an ordered list.
  ;; Note: ptree is a valid parse tree.
  (define get_sentence_hop 
    (λ (ptree)
      (cond
        ((null? ptree) ptree)
        ;; If the ptree is empty, then it is returned.
        ((not (list? ptree)) (flatten ptree))
         ;; If the ptree is a single item, then it is returned.
         ;; Using flattned will ensure that it will return a list when it is passed a single element.
        (else (flatten (map gsh_helper (cdr ptree))))
        ;; flattens the yield of the parse tree from the helper function, gsh_helper, mapped to every 
        ;; phrase or element contained in the list (except the first, which is a non-terminal).
        )
      )
    )

  ;; (gsh_helper element) returns the yield of the parse tree element, element.
  ;; Note: element is a valid element of the tree phrase.
  (define gsh_helper 
    (λ (element)
      (cond
        ((null? element) null)
        ;; If the element is null, then it is returned.
        ((not (list? element)) (list element))
        ;; If the element is only a single item (not a list), then it is returned in a list.
        (else (get_sentence_hop element))
        ;; If the element is a list, then it's a phrase (a valid parse tree) and it's evaluated by get_sentence_hop.
        )
      )
    )

  ;; export procedures
  (provide get_non_terminals get_terminals get_sentence get_sentence_hop)