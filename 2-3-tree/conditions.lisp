(cl:in-package #:clump-2-3-tree)

(define-condition 2-3-tree-error (error acclimation:condition)
  ())

(define-condition tree-for-insertion-must-be-empty (2-3-tree-error)
  ((%tree :initarg :tree :reader tree)))
