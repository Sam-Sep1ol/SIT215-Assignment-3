(define (domain blocks)
    (:requirements :strips :typing) ; Specifies the requirements for the PDDL domain
   
    (:types block robot) ; Defines the types of objects in the domain
   
    (:predicates ; Defines the predicates (properties or relationships) between objects
        (on ?x - block ?y - block) ; Indicates that block ?x is on top of block ?y
        (ontable ?x - block) ; Indicates that block ?x is on the table
        (clear ?x - block) ; Indicates that block ?x has nothing on top of it
        (handempty ?r - robot) ; Indicates that the robot's hand is empty
    )
   
    (:action pickup ; Defines the pickup action
        :parameters (?b - block ?r - robot) ; Specifies the parameters of the action
        :precondition (and (clear ?b) (ontable ?b) (handempty ?r)) ; Preconditions that must be met for the action
        :effect (and (not (clear ?b)) (not (ontable ?b)) (not (handempty ?r))) ; Effects of the action
    )
   
    (:action putdown ; Defines the putdown action
        :parameters (?b - block ?r - robot) ; Specifies the parameters of the action
        :precondition (and (not (clear ?b)) (not (ontable ?b)) (not (handempty ?r))) ; Preconditions that must be met for the action
        :effect (and (clear ?b) (ontable ?b) (handempty ?r)) ; Effects of the action
    )
   
    (:action unstack ; Defines the unstack action
        :parameters (?b - block ?c - block ?r - robot) ; Specifies the parameters of the action
        :precondition (and (on ?b ?c) (clear ?b) (not (handempty ?r))) ; Preconditions that must be met for the action
        :effect (and (clear ?c) (handempty ?r) (not (on ?b ?c))) ; Effects of the action
    )
   
    (:action stack ; Defines the stack action
        :parameters (?b - block ?c - block ?r - robot) ; Specifies the parameters of the action
        :precondition (and (clear ?c) (handempty ?r)) ; Preconditions that must be met for the action
        :effect (and (not (clear ?c)) (not (handempty ?r)) (on ?b ?c)) ; Effects of the action
    )
)
