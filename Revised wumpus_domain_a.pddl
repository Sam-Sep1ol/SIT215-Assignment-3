(define (domain wumpus_domain_a)

  (:predicates
   (adj ?square-1 ?square-2)
   (pit ?square)
   (at ?what ?square)
   (have ?who ?what)
   (dead ?who)
   (clear-path ?from ?to))

  (:action move
    :parameters (?who ?from ?to)
    :precondition (and (adj ?from ?to)
		       (not (pit ?to))
		       (at ?who ?from))
    :effect (and (not (at ?who ?from))
		 (at ?who ?to))
    )

  (:action take
    :parameters (?who ?what ?where)
    :precondition (and (at ?who ?where)
		       (at ?what ?where))
    :effect (and (have ?who ?what)
		 (not (at ?what ?where)))
    )

  (:action shoot
    :parameters (?who ?from ?to ?arrow ?victim)
    :precondition (and (have ?who ?arrow)
		       (at ?who ?from)
		       (at ?victim ?to)
		       (clear-path ?from ?to))
    :effect (and (dead ?victim)
		 (not (at ?victim ?to))
		 (not (have ?who ?arrow)))
    )
)

;; Helper function to determine clear path (horizontal and vertical)
(:derived (clear-path ?from ?to)
  (or (forall (?middle)
          (and (adj ?from ?middle) 
               (adj ?middle ?to)
               (not (pit ?middle))))
      (forall (?middle)
          (and (adj ?middle ?from)
               (adj ?to ?middle)
               (not (pit ?middle)))))
)
  
